/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef X25519_METH_H
#define X25519_METH_H

#include <openssl/evp.h>

void eng25519_register_x25519(EVP_PKEY_METHOD *pmeth);

#endif