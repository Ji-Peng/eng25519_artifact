
#ifndef ASN1_METH_H
#define ASN1_METH_H

#include <openssl/evp.h>

int eng25519_register_asn1_meth(int nid, EVP_PKEY_ASN1_METHOD **ameth,
                                const char *pem_str, const char *info);

#endif