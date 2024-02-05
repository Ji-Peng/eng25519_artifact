/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ASN1_METH_H
#define ASN1_METH_H

#include <openssl/evp.h>

int eng25519_register_asn1_meth(int nid, EVP_PKEY_ASN1_METHOD **ameth,
                                const char *pem_str, const char *info);

#endif