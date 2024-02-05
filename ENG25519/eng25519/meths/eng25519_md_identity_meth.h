/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef MD_IDENTITY_METH_H
#define MD_IDENTITY_METH_H

#include <openssl/evp.h>

typedef struct {
    unsigned char *m;
    unsigned long long offset;
    unsigned long long len;
} MD_IDENTITY_DATA;

void eng25519_register_md_identity(EVP_MD *md);

#endif