
#include <openssl/engine.h>
#include <openssl/obj_mac.h>
#include <string.h> /* memcpy() */

#include "debug/debug.h"
#include "meths/eng25519_asn1_meth.h"
#include "meths/eng25519_ed25519_meth.h"
#include "meths/eng25519_md_identity_meth.h"
#include "meths/eng25519_x25519_meth.h"
#include "ossl/eng25519_err.h"
#include "ossl/eng25519_objects.h"
#include "ossl/ossl_compat.h"
#include "providers/api/base.h"

#define ENG25519_DEBUG_ENVVAR "ENG25519_DEBUG"
#define ENG25519_DEBUG_DEFAULT_LEVEL LOG_EXTRM

#ifndef ENG25519_ENGINE_ID
#    define ENG25519_ENGINE_ID "eng25519"
#endif

#ifndef ENG25519_ENGINE_NAME
#    define ENG25519_ENGINE_NAME "An engine gluing together OpenSSL and batch Curve25519"
#endif

static const char *engine_id = ENG25519_ENGINE_ID;
static const char *engine_name = ENG25519_ENGINE_NAME ".";

static int eng25519_register_methods();

static int eng25519_pkey_meths(ENGINE *e, EVP_PKEY_METHOD **pmeth, const int **nids,
                               int nid);

static int eng25519_pkey_meth_nids[] = {0 /* NID_X25519 */, 0 /** NID_ED25519 */, 0};

static void eng25519_pkey_meth_nids_init()
{
    eng25519_pkey_meth_nids[0] = NID_X25519;
    eng25519_pkey_meth_nids[1] = NID_ED25519;
}

static EVP_PKEY_METHOD *pmeth_X25519 = NULL;
static EVP_PKEY_METHOD *pmeth_Ed25519 = NULL;

/* --------------- ASN1 methods ---------------- */

static int eng25519_pkey_asn1_meths(ENGINE *e, EVP_PKEY_ASN1_METHOD **ameth,
                                    const int **nids, int nid);
static int eng25519_register_ameth(int id, EVP_PKEY_ASN1_METHOD **ameth, int flags);

static int eng25519_pkey_asn1_meth_nids[] = {0 /* NID_X25519 */, 0 /** NID_ED25519 */, 0};

static void eng25519_pkey_asn1_meth_nids_init()
{
    eng25519_pkey_asn1_meth_nids[0] = NID_X25519;
    eng25519_pkey_asn1_meth_nids[1] = NID_ED25519;
}

static EVP_PKEY_ASN1_METHOD *ameth_X25519 = NULL;
static EVP_PKEY_ASN1_METHOD *ameth_Ed25519 = NULL;

static int eng25519_digests(ENGINE *e, const EVP_MD **digest, const int **nids, int nid);

static int eng25519_digests_nids[] = {0 /* NID_identity_md */, 0};

static int eng25519_digests_nids_init()
{
    eng25519_digests_nids[0] = NID_identity_md;
    return 1;
}

static EVP_MD *md_identity = NULL;

static int eng25519_e_init(ENGINE *e)
{
    (void)e;
    verbose("STUB\n");
    return 1;
}

static void eng25519_clear_methods(void)
{
    verbose("CALLED\n");
    pmeth_X25519 = NULL;
    ameth_X25519 = NULL;
    pmeth_Ed25519 = NULL;
    ameth_Ed25519 = NULL;
}

static int eng25519_e_destroy(ENGINE *e)
{
    (void)e;
    verbose("CALLED\n");

    if (!eng25519_implementation_deinit()) {
        errorf("eng25519_implementation_deinit failed\n");
    }

    eng25519_clear_methods();

    debug_logging_finish();
    ERR_unload_ENG25519_strings();
    OBJ_cleanup();

#ifdef OPENSSL_V102_COMPAT
    if (md_identity != NULL) {
        OPENSSL_free(md_identity);
        md_identity = NULL;
    }
#endif /* OPENSSL_V102_COMPAT */

    return 1;
}

static int eng25519_e_finish(ENGINE *e)
{
    (void)e;
    verbose("STUB\n");
    return 1;
}

static int eng25519_bind(ENGINE *e, const char *id)
{
    (void)id;
    debug_logging_init(ENG25519_DEBUG_DEFAULT_LEVEL, ENG25519_DEBUG_ENVVAR);

    verbose("CALLED(%p, \"%s\"[%p])\n", e, id, id);
    int ret = 0;
    if (!ENGINE_set_id(e, engine_id)) {
        errorf("ENGINE_set_id failed\n");
        goto end;
    }
    if (!ENGINE_set_name(e, engine_name)) {
        errorf("ENGINE_set_name failed\n");
        goto end;
    }

    if (!ENGINE_set_init_function(e, eng25519_e_init)) {
        errorf("ENGINE_set_init_function failed\n");
        goto end;
    }
    if (!ENGINE_set_destroy_function(e, eng25519_e_destroy)) {
        errorf("ENGINE_set_destroy_function failed\n");
        goto end;
    }
    if (!ENGINE_set_finish_function(e, eng25519_e_finish)) {
        errorf("ENGINE_set_finish_function failed\n");
        goto end;
    }

    if (!ERR_load_ENG25519_strings()) {
        errorf("ERR_load_ENG25519_strings failed\n");
        goto end;
    }

    if (!eng25519_register_nids()) {
        errorf("Failure registering NIDs\n");
        goto end;
    } else {
        eng25519_pkey_meth_nids_init();
        eng25519_pkey_asn1_meth_nids_init();
        eng25519_digests_nids_init();
    }

    if (!eng25519_register_methods()) {
        errorf("Failure registering methods\n");
        goto end;
    }

    if (!ENGINE_set_digests(e, eng25519_digests)) {
        errorf("ENGINE_set_digests failed\n");
        goto end;
    }

    if (!ENGINE_set_pkey_asn1_meths(e, eng25519_pkey_asn1_meths)) {
        errorf("ENGINE_set_pkey_asn1_meths failed\n");
        goto end;
    }

    if (!ENGINE_set_pkey_meths(e, eng25519_pkey_meths)) {
        errorf("ENGINE_set_pkey_meths failed\n");
        goto end;
    }

    if (!eng25519_implementation_init()) {
        errorf("eng25519_implementation_init failed\n");
        goto end;
    }

    ret = 1;
end:
    return ret;
}

#define sizeof_static_array(a) ((sizeof((a))) / sizeof((a)[0]))

static int eng25519_pkey_meths(ENGINE *e, EVP_PKEY_METHOD **pmeth, const int **nids,
                               int nid)
{
    (void)e;
    if (!pmeth) {
        debug("GET LIST\n");
        *nids = eng25519_pkey_meth_nids;
        return sizeof_static_array(eng25519_pkey_meth_nids) - 1;
    }
    debug("NID(%d/%s) ->", nid, OBJ_nid2sn(nid));

    if (nid == NID_X25519) {
        *pmeth = pmeth_X25519;
        debug_sl("pmeth_X25519\n");
        return 1;
    } else if (nid == NID_ED25519) {
        *pmeth = pmeth_Ed25519;
        debug_sl("pmeth_Ed25519\n");
        return 1;
    }

    debug_sl("NOT FOUND\n");
    *pmeth = NULL;
    return 0;
}

/* Register a new EVP_PKEY_METHOD for alg id under given flags */
static int eng25519_register_pmeth(int id, EVP_PKEY_METHOD **pmeth, int flags)
{
    *pmeth = EVP_PKEY_meth_new(id, flags);

    if (*pmeth == NULL)
        return 0;

    if (id == NID_X25519) {
        eng25519_register_x25519(*pmeth);
    } else if (id == NID_ED25519) {
        eng25519_register_ed25519(*pmeth);
    } else {
        /* Unsupported method */
        return 0;
    }

    return 1;
}

static int eng25519_pkey_asn1_meths(ENGINE *e, EVP_PKEY_ASN1_METHOD **ameth,
                                    const int **nids, int nid)
{
    (void)e;
    if (!ameth) {
        debug("GET LIST\n");
        *nids = eng25519_pkey_asn1_meth_nids;
        return sizeof_static_array(eng25519_pkey_asn1_meth_nids) - 1;
    }
    debug("NID(%d/%s) ->", nid, OBJ_nid2sn(nid));

    if (nid == NID_X25519) {
        *ameth = ameth_X25519;
        debug_sl("ameth_X25519\n");
        return 1;
    } else if (nid == NID_ED25519) {
        *ameth = ameth_Ed25519;
        debug_sl("ameth_Ed25519\n");
        return 1;
    }

    debug_sl("NOT FOUND\n");
    *ameth = NULL;
    return 0;
}

/* Register a new EVP_PKEY_ASN1_METHOD for alg id under given flags */
static int eng25519_register_ameth(int id, EVP_PKEY_ASN1_METHOD **ameth, int flags)
{
    verbose("CALLED\n");
    const char *pem_str = NULL;
    const char *info = NULL;

    (void)flags;
    if (!ameth)
        return 0;

    if (id == NID_X25519) {
        ;
    } else if (id == NID_ED25519) {
        /**
         * No need to bind the digest algorithm for Ed25519, so the second parameter is
         * NID_undef.
         */
        if (!OBJ_add_sigid(NID_ED25519, NID_identity_md, NID_ED25519)) {
            errorf("OBJ_add_sigid() failed\n");
            return 0;
        }
    } else {
        /* Unsupported method */
        return 0;
    }

    pem_str = OBJ_nid2sn(id);
    info = OBJ_nid2ln(id);
    return eng25519_register_asn1_meth(id, ameth, pem_str, info);
}

static int eng25519_digests(ENGINE *e, const EVP_MD **digest, const int **nids, int nid)
{
    (void)e;
    if (!digest) {
        debug("GET LIST\n");
        *nids = eng25519_digests_nids;
        return sizeof_static_array(eng25519_digests_nids) - 1;
    }
    debug("NID(%d/%s) ->", nid, OBJ_nid2sn(nid));

    if (nid == NID_identity_md && nid != NID_undef) {
        *digest = md_identity;
        debug_sl("md_identity\n");
        return 1;
    }

    debug_sl("NOT FOUND\n");
    *digest = NULL;
    return 0;
}

/* Register a new EVP_MD for alg md_id under given flags */
static int eng25519_register_md(int md_id, int pkey_type, EVP_MD **md, int flags)
{
    (void)flags;
    int ret = 0;
    debug(
        "registering md method for '%s' with md_id=%d, pkey_type=%d, "
        "flags=%08x\n",
        OBJ_nid2ln(md_id), md_id, pkey_type, flags);

    *md = EVP_MD_meth_new(md_id, pkey_type);

    if (*md == NULL)
        return 0;

    if (md_id == NID_identity_md) {
        eng25519_register_md_identity(*md);
        ret = 1;
    }

    if (ret == 1) {
        ret = EVP_add_digest(*md);
        return ret;
    }

    /* Unsupported md type */
    return 0;
}

static int eng25519_register_methods()
{
    if (!eng25519_register_ameth(NID_X25519, &ameth_X25519, 0)) {
        return 0;
    }
    if (!eng25519_register_ameth(NID_ED25519, &ameth_Ed25519, 0)) {
        return 0;
    }

    if (!eng25519_register_pmeth(NID_X25519, &pmeth_X25519, 0)) {
        return 0;
    }
    if (!eng25519_register_pmeth(NID_ED25519, &pmeth_Ed25519, 0)) {
        return 0;
    }

    if (!eng25519_register_md(NID_identity_md, NID_ED25519, &md_identity, 0)) {
        return 0;
    }

    return 1;
}

IMPLEMENT_DYNAMIC_BIND_FN(eng25519_bind)
IMPLEMENT_DYNAMIC_CHECK_FN()