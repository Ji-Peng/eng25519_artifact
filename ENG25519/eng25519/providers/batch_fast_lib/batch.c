
#include <openssl/err.h>
#include <string.h>

#include "debug/debug.h"
// #include "ossl/eng25519_err.h"

#include <openssl/crypto.h>
#include <openssl/rand.h>

#include "batch.h"
#include "meths/eng25519_keypair.h"
#include "ossl/eng25519_objects.h"
#include "x25519_batch_avx512ifma/ecdh.h"

/** Our AVX512IFMA (8x1)-way KeyGen function generates 8 keypairs once. */
#define CURVE25519_BATCH_SIZE 8
/** The number of calling crypto_x25519_batch_keygen once */
#define X25519_KEYGEN_BATCH_NUM 16

/** used by CRYPTO_THREAD_run_once function */
static CRYPTO_ONCE init_once = CRYPTO_ONCE_STATIC_INIT;

/**
 * A global context including ref_count and BATCH_CTX.
 *
 * Note that:
 * 1) The life cycle of 'lock' is controlled by
 * eng25519_prov_batch_{init,deinit}. In init function, we use
 * CRYPTO_THREAD_run_once API to assure that the initialization of lock is
 * executed only once. In deinit function, we free the 'lock' when ref_count ==
 * 0.
 * 2) After initializing the 'lock', we can use this lock to protect this
 * structure.
 * 3) Regarding the responsibility of the 'lock',  it is used to protect the
 * ref_count and the initialization of the x25519_ctx and ed25519_ctx.
 * 3) Regarding the life cycle of x25519_ctx and ed25519_ctx, it is initialized by
 * eng25519_prov_curve25519_get_keypair with the protection of lock. And it is
 * destroyed by eng25519_prov_batch_deinit when ref_count == 0.
 */
static struct {
    CRYPTO_RWLOCK *lock;
    int ref_count;
    BATCH_CTX *x25519_ctx;
    BATCH_CTX *ed25519_ctx;
} global_ctx;

/**
 * Fill a buffer with len bytes of random data.
 * buf is a "const pointer" to a buffer.
 * len: length of random data in bytes.
 *
 * Return 1 on success, non-1 on failure.
 */
static int randombytes_buf(void *const buf, const size_t len)
{
    return RAND_bytes(buf, len);
}

/**
 * Init the 'lock' in global_ctx.
 * If global_ctx.lock is not NULL, print a error information.
 */
static void global_ctx_lock_init(void)
{
    if (global_ctx.lock != NULL) {
        errorf("global_ctx.lock is not NULL\n");
    }
    global_ctx.lock = CRYPTO_THREAD_lock_new();
}

/**
 * Fill the store with a call of batch_keygen function.
 * This function is called when 1) initializing the store and 2) the store is
 * empty.
 *
 * Returns 1 on success, 0 on failure.
 */
static int BATCH_STORE_fill(BATCH_STORE *store, int nid)
{
    /** secret keys size in bytes */
    size_t sks_size = 0;
    const ENG25519_ECDH_NID_DATA *nid_data = NULL;
    int i;

    if (nid == NID_X25519) {
        /** no need to check 'nid_data == NULL' */
        nid_data = eng25519_get_nid_data(nid);
        sks_size = nid_data->sk_bytes * CURVE25519_BATCH_SIZE * X25519_KEYGEN_BATCH_NUM;
        /** generate secret keys using randombytes_buf API */
        if (sks_size >= store->data_size || randombytes_buf(store->sks, sks_size) != 1) {
            return 0;
        }
        info("crypto_x25519_batch_keygen\n");
        for (i = 0; i < X25519_KEYGEN_BATCH_NUM; i++) {
            /** no return value */
            crypto_x25519_batch_keygen(
                store->pks + nid_data->pk_bytes * i * CURVE25519_BATCH_SIZE,
                store->sks + nid_data->sk_bytes * i * CURVE25519_BATCH_SIZE);
        }
        store->available = CURVE25519_BATCH_SIZE * X25519_KEYGEN_BATCH_NUM;
        return 1;
    } else if (nid == NID_ED25519) {
        nid_data = eng25519_get_nid_data(nid);
        sks_size = nid_data->sk_bytes * CURVE25519_BATCH_SIZE;
        /** generate secret keys using randombytes_buf API */
        if (sks_size >= store->data_size || randombytes_buf(store->sks, sks_size) != 1) {
            return 0;
        }
        info("crypto_ed25519_batch_keygen\n");
        /** no return value */
        crypto_ed25519_batch_keygen(store->pks, store->sks);
        store->available = CURVE25519_BATCH_SIZE;
        return 1;
    } else {
        return 0;
    }
}

/**
 * Create a BATCH_STORE and fill it.
 * This function is called when initializing a BATCH_CTX.
 * Note that:
 * 1) use the OPENSSL_secure_zalloc API because the store contains secret keys.
 * 2) free the lock and store on error branches.
 */
static BATCH_STORE *BATCH_STORE_new(const ENG25519_ECDH_NID_DATA *nid_data,
                                    size_t batch_size)
{
    int ok = 0;
    BATCH_STORE *store = NULL;
    CRYPTO_RWLOCK *lock = NULL;
    /** in bytes */
    size_t data_size = 0, sks_size = 0, pks_size = 0;

    sks_size = batch_size * nid_data->sk_bytes;
    pks_size = batch_size * nid_data->pk_bytes;
    data_size = sks_size + pks_size;

    if (data_size <= 0 ||
        (store = OPENSSL_secure_zalloc(sizeof(*store) + data_size)) == NULL ||
        (lock = CRYPTO_THREAD_lock_new()) == NULL)
        goto end;

    store->lock = lock;
    store->data_size = data_size;
    store->pks = &(store->_data[0]);
    store->sks = &(store->_data[pks_size]);

    if (!BATCH_STORE_fill(store, nid_data->nid))
        goto end;

    ok = 1;

end:
    if (!ok) {
        CRYPTO_THREAD_lock_free(lock);
        OPENSSL_secure_free(store);
        store = NULL;
    }
    return store;
}

/**
 * Free a BATCH_STORE structure.
 * Note that:
 * 1) free the lock in store;
 * 2) use OPENSSL_secure_clear_free because there are secret keys in store.
 * 3) the size of the memory needed to free is sizeof(*store) + data_size.
 */
static void BATCH_STORE_free(BATCH_STORE *store)
{
    size_t data_size = 0;

    if (store == NULL)
        return;

    data_size = store->data_size;
    CRYPTO_THREAD_lock_free(store->lock);
    OPENSSL_secure_clear_free(store, sizeof(*store) + data_size);
}

/**
 * Create a BATCH_CTX structure.
 */
static BATCH_CTX *BATCH_CTX_new(const ENG25519_ECDH_NID_DATA *nid_data)
{
    int ok = 0;
    BATCH_CTX *ctx = NULL;

    if ((ctx = OPENSSL_zalloc(sizeof(*ctx))) == NULL)
        goto end;

    ctx->nid_data = nid_data;

    if (nid_data->nid == NID_X25519) {
        ctx->batch_size = CURVE25519_BATCH_SIZE * X25519_KEYGEN_BATCH_NUM;
    } else if (nid_data->nid == NID_ED25519) {
        ctx->batch_size = CURVE25519_BATCH_SIZE;
    }

    if (ctx->batch_size == 0)
        goto end;

    if ((ctx->store = BATCH_STORE_new(nid_data, ctx->batch_size)) == NULL)
        goto end;

    ok = 1;

end:
    if (!ok) {
        OPENSSL_free(ctx);
        ctx = NULL;
    }
    return ctx;
}

static void BATCH_CTX_free(BATCH_CTX *ctx)
{
    if (ctx == NULL)
        return;
    BATCH_STORE_free(ctx->store);
    OPENSSL_free(ctx);
}

/**
 * Get a keypair.
 * The validity of kp is guaranteed by the upper-layer caller
 *  (i.e., eng25519_prov_batch_get_keypair).
 *
 * 1) get the BATCH_CTX according to the algorithm's NID.
 *   If the ctx is NULL, create it.
 *   Note that we need to use lock to protect global_ctx.*_ctx.
 * 2) get a keypair from BATCH_STORE
 *   If the store is empty, fill it.
 *   Note that we need to use the lock (in store) to protect the store.
 *
 * Returns 1 on success, 0 on failure.
 */
static int eng25519_prov_curve25519_get_keypair(ENG25519_KEYPAIR *kp)
{
    const ENG25519_ECDH_NID_DATA *nid_data = NULL;
    BATCH_CTX *ctx = NULL;
    size_t num;

    info("CALLED\n");

    /**
     * 1) acquire the global_ctx.lock.
     * 2) get the x25519_ctx or ed25519_ctx (if NULL create it).
     * 3) release the global_ctx.lock.
     */
    if (!CRYPTO_THREAD_write_lock(global_ctx.lock)) {
        errorf("Failed acquiring global_ctx.lock\n");
        return 0;
    }
    if (kp->nid == NID_X25519) {
        if (global_ctx.x25519_ctx == NULL) {
            ctx = global_ctx.x25519_ctx = BATCH_CTX_new(kp->nid_data);
            if (ctx == NULL)
                return 0;
        } else {
            ctx = global_ctx.x25519_ctx;
        }
    } else if (kp->nid == NID_ED25519) {
        if (global_ctx.ed25519_ctx == NULL) {
            ctx = global_ctx.ed25519_ctx = BATCH_CTX_new(kp->nid_data);
            if (ctx == NULL)
                return 0;
        } else {
            ctx = global_ctx.ed25519_ctx;
        }
    }
    if (!CRYPTO_THREAD_unlock(global_ctx.lock)) {
        errorf("Failed releasing global_ctx.lock\n");
        return 0;
    }

    nid_data = ctx->nid_data;

    /**
     * Here, assume the ctx is valid.
     * 1) acquire the store->lock.
     * 2) if no available keypair, fill the store. Then copy a keypair from
     * store to kp.
     * 3) release the store->lock.
     *
     * Note that:
     * 1) we should avoid deadlocking on error branches.
     * 2) clean the memory space after copying a keypair.
     */
    if (!CRYPTO_THREAD_write_lock(ctx->store->lock)) {
        errorf("Failed acquiring ctx->store->lock\n");
        return 0;
    }

    if (ctx->store->available == 0) {
        info("Store is empty; fill it\n");
        if (!BATCH_STORE_fill(ctx->store, nid_data->nid)) {
            if (!CRYPTO_THREAD_unlock(ctx->store->lock))
                errorf("Failed releasing ctx->store->lock\n");
            return 0;
        }
        /**
         * In Nicola's engntru project, 'available == 0' is checked again and I
         * think it is not necessary in this project.
         */
    }
    info("Get a keypair from store\n");
    num = --ctx->store->available;
    /** copy sk and pk from store to kp */
    memcpy(kp->sk, ctx->store->sks + num * nid_data->sk_bytes, nid_data->sk_bytes);
    memcpy(kp->pk, ctx->store->pks + num * nid_data->pk_bytes, nid_data->pk_bytes);

    /** erase keypair from buffer for Perfect Forward Secrecy (PFS) */
    OPENSSL_cleanse(ctx->store->sks + num * nid_data->sk_bytes, nid_data->sk_bytes);
    OPENSSL_cleanse(ctx->store->pks + num * nid_data->pk_bytes, nid_data->pk_bytes);

    if (!CRYPTO_THREAD_unlock(ctx->store->lock)) {
        errorf("Failed unlocking ctx->store->lock\n");
        return 0;
    }

    return 1;
}

/**
 * Init the batch context.
 *
 * 1) call global_ctx_lock_init with run_once API.
 * 2) global_ctx.ref_count++ with the protection of global_ctx.lock.
 *
 * Returns 1 on success, 0 on failure.
 */
int eng25519_prov_batch_init(void)
{
    if (!CRYPTO_THREAD_run_once(&init_once, global_ctx_lock_init) ||
        global_ctx.lock == NULL) {
        return 0;
    }

    if (!CRYPTO_THREAD_write_lock(global_ctx.lock)) {
        errorf("Failed acquiring global_ctx.lock\n");
        return 0;
    }

    global_ctx.ref_count++;

    if (!CRYPTO_THREAD_unlock(global_ctx.lock)) {
        errorf("Failed releasing global_ctx.lock\n");
        return 0;
    }
    return 1;
}

/**
 * Deinit the batch context.
 *
 * 1) Acquire the global_ctx.lock.
 * 2) global_ctx.ref_count--.
 * 3) If global_ctx.ref_count == 0, release global_ctx.x25519_ctx, global_ctx.ed25519.
 * 4) Release the global_ctx.lock.
 * Note that we need to assure all branches contain acquire-release lock operations.
 *
 * Returns 1 on success, 0 on failure.
 */
int eng25519_prov_batch_deinit(void)
{
    CRYPTO_RWLOCK *lock = NULL;
    if (!CRYPTO_THREAD_write_lock(global_ctx.lock)) {
        errorf("Failed acquiring global_ctx.lock\n");
        return 0;
    }

    global_ctx.ref_count--;

    if (global_ctx.ref_count == 0) {
        BATCH_CTX_free(global_ctx.x25519_ctx);
        BATCH_CTX_free(global_ctx.ed25519_ctx);
        lock = global_ctx.lock;
        global_ctx.lock = NULL;
        if (!CRYPTO_THREAD_unlock(lock)) {
            errorf("Failed releasing global_ctx.lock\n");
            return 0;
        }
        CRYPTO_THREAD_lock_free(lock);
    } else {
        if (!CRYPTO_THREAD_unlock(global_ctx.lock)) {
            errorf("Failed releasing global_ctx.lock\n");
            return 0;
        }
    }

    return 1;
}

/**
 * Get a new keypair for ECDH.
 *
 * Returns 1 on success, 0 on failure.
 */
int eng25519_prov_batch_get_keypair(ENG25519_KEYPAIR *kp)
{
    if (kp == NULL)
        return 0;

    if (kp->nid == NID_X25519 || kp->nid == NID_ED25519)
        return eng25519_prov_curve25519_get_keypair(kp);

    return 0;
}