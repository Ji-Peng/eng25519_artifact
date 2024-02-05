/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef PROVIDER_BATCH_H
#define PROVIDER_BATCH_H

#include <openssl/crypto.h>

#include "meths/eng25519_keypair.h"

typedef struct batch_ctx_st BATCH_CTX;
typedef struct batch_store_st BATCH_STORE;

/**
 * The context for batch computation.
 * nid_data: information about the algorithm instructed by NID.
 * batch_size: the number of key-pairs once batch.
 * store: used for storing batch data.
 */
struct batch_ctx_st {
    const ENG25519_ECDH_NID_DATA *nid_data;
    size_t batch_size;

    BATCH_STORE *store;
};

/**
 * The struct for storing batch data.
 * lock: used for protect this struct due to multi-thread access.
 * available: current number of key-pairs.
 * data_size: the size of the _data[].
 * pks: public key pointer.
 * sks: secret key pointer.
 * _data[]: real pk and sk storage.
 */
struct batch_store_st {
    CRYPTO_RWLOCK *lock;
    size_t available;
    size_t data_size;

    uint8_t *pks;
    uint8_t *sks;

    uint8_t _data[];
};

int eng25519_prov_batch_init(void);

int eng25519_prov_batch_deinit(void);

int eng25519_prov_batch_get_keypair(ENG25519_KEYPAIR *kp);

#endif