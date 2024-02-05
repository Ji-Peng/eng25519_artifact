/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _KEM_H
#define _KEM_H

#include "gfparith.h"

#define BATCH_SIZE 8
#define SECRET_KEY_BYTES 32
#define PUBLIC_KEY_BYTES 32
#define SHARED_KEY_BYTES 32

void keygen(__m512i *pk, const __m512i *sk);
void shared_secret(__m512i *ss, const __m512i *ska, const __m512i *pkb);
void crypto_x25519_batch_keygen(uint8_t *pks, uint8_t *sks);
void crypto_ed25519_batch_keygen(uint8_t *pks, uint8_t *sks);
// void crypto_x25519_sharedsecret(uint8_t *ss, const uint8_t *ska, const uint8_t *pkb);

#endif
