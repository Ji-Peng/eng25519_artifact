/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ED255_H
#define ED255_H

#include <string.h>

#include "params.h"

int ed25519_sk_to_pk_internal(uint8_t *pk, const uint8_t *sk);
int ed25519_sign(uint8_t *signature, const uint8_t *message, uint64_t message_length,
                 const uint8_t *pk, const uint8_t *sk);
int ed25519_verify(const uint8_t *message, uint64_t message_length, const uint8_t *pk,
                   const uint8_t *signature);

#endif