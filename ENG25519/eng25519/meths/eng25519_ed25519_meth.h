/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ED25519_METH_H
#define ED25519_METH_H

#include <openssl/evp.h>

#include "eng25519_keypair.h"

void eng25519_register_ed25519(EVP_PKEY_METHOD *pmeth);

int ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk);
int EVP_PKEY_CTX_ed25519_set_private(EVP_PKEY_CTX *ctx,
                                     const uint8_t sk[Ed25519_PRIVKEYLEN]);
int EVP_PKEY_ed25519_set_private(EVP_PKEY *pkey, const uint8_t sk[Ed25519_PRIVKEYLEN]);

#endif