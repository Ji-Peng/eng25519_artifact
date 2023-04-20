
#ifndef X25519_METH_H
#define X25519_METH_H

#include <openssl/evp.h>

void eng25519_register_x25519(EVP_PKEY_METHOD *pmeth);

#endif