/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include <openssl/err.h>
#include "ossl/eng25519_err.h"

#ifndef OPENSSL_NO_ERR

static ERR_STRING_DATA ENG25519_str_functs[] = {
    {ERR_PACK(0, ENG25519_F_ASN1_ED25519_ITEM_VERIFY, 0),
     "eng25519_ed25519_item_verify"},
    {ERR_PACK(0, ENG25519_F_ASN1_GENERIC_CTRL, 0), "asn1_generic_ctrl"},
    {ERR_PACK(0, ENG25519_F_ASN1_GENERIC_PRIV_DECODE, 0),
     "asn1_generic_priv_decode"},
    {ERR_PACK(0, ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, 0),
     "asn1_generic_priv_encode"},
    {ERR_PACK(0, ENG25519_F_ASN1_GENERIC_PUB_DECODE, 0),
     "asn1_generic_pub_decode"},
    {ERR_PACK(0, ENG25519_F_ASN1_GENERIC_PUB_ENCODE, 0),
     "asn1_generic_pub_encode"},
    {ERR_PACK(0, ENG25519_F_ED25519_KEYGEN, 0), "ed25519_keygen"},
    {ERR_PACK(0, ENG25519_F_ED25519_SIGN, 0), "ed25519_sign"},
    {ERR_PACK(0, ENG25519_F_ED25519_SK_TO_PK, 0), "ed25519_sk_to_pk"},
    {ERR_PACK(0, ENG25519_F_ED25519_VERIFY, 0), "ed25519_verify"},
    {ERR_PACK(0, ENG25519_F_ENG25519_KEYPAIR_NEW, 0), "eng25519_keypair_new"},
    {ERR_PACK(0, ENG25519_F_EVP_PKEY_CTX_ED25519_SET_PRIVATE, 0),
     "EVP_PKEY_CTX_ed25519_set_private"},
    {ERR_PACK(0, ENG25519_F_EVP_PKEY_ED25519_SET_PRIVATE, 0),
     "EVP_PKEY_ed25519_set_private"},
    {ERR_PACK(0, ENG25519_F_X25519_DERIVE, 0), "X25519_derive"},
    {ERR_PACK(0, ENG25519_F_X25519_KEYGEN, 0), "X25519_keygen"},
    {ERR_PACK(0, ENG25519_F_X25519_SK_TO_PK, 0), "X25519_sk_to_pk"},
    {0, NULL}
};

static ERR_STRING_DATA ENG25519_str_reasons[] = {
    {ERR_PACK(0, 0, ENG25519_R_BAD_SIGNATURE), "bad signature"},
    {ERR_PACK(0, 0, ENG25519_R_CANNOT_DERIVE_PK),
    "failed to derive public key from private key"},
    {ERR_PACK(0, 0, ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN),
    "implementation backend returned unexpected value"},
    {ERR_PACK(0, 0, ENG25519_R_INVALID_ENCODING), "invalid encoding"},
    {ERR_PACK(0, 0, ENG25519_R_INVALID_KEY), "invalid key"},
    {ERR_PACK(0, 0, ENG25519_R_INVALID_PEER_KEY), "invalid peer key"},
    {ERR_PACK(0, 0, ENG25519_R_INVALID_PRIVATE_KEY), "invalid private key"},
    {ERR_PACK(0, 0, ENG25519_R_KEYS_NOT_SET), "keys not set"},
    {ERR_PACK(0, 0, ENG25519_R_MISSING_NID_DATA),
    "failed to get nid_data struct pointer"},
    {ERR_PACK(0, 0, ENG25519_R_MISSING_PRIVATE_KEY), "missing private key"},
    {ERR_PACK(0, 0, ENG25519_R_RANDOM_NUMBER_GENERATION_FAILED),
    "random number generation failed"},
    {ERR_PACK(0, 0, ENG25519_R_WRONG_LENGTH), "wrong length"},
    {0, NULL}
};

static ERR_STRING_DATA ENG25519_lib_name[] = {
    {0, "eng25519 engine"},
    {0, NULL}
};

#endif

static int lib_code = 0;
static int error_loaded = 0;

int ERR_load_ENG25519_strings(void)
{
    if (lib_code == 0)
        lib_code = ERR_get_next_error_library();

    if (!error_loaded) {
#ifndef OPENSSL_NO_ERR
        ERR_load_strings(lib_code, ENG25519_str_functs);
        ERR_load_strings(lib_code, ENG25519_str_reasons);
        ENG25519_lib_name->error = ERR_PACK(lib_code, 0, 0);
        ERR_load_strings(0, ENG25519_lib_name);
#endif
        error_loaded = 1;
    }
    return 1;
}

void ERR_unload_ENG25519_strings(void)
{
    if (error_loaded) {
#ifndef OPENSSL_NO_ERR
        ERR_unload_strings(lib_code, ENG25519_str_functs);
        ERR_unload_strings(lib_code, ENG25519_str_reasons);
        ERR_unload_strings(0, ENG25519_lib_name);
#endif
        error_loaded = 0;
    }
}

void ERR_ENG25519_error(int function, int reason, char *file, int line)
{
    if (lib_code == 0)
        lib_code = ERR_get_next_error_library();
    ERR_PUT_error(lib_code, function, reason, file, line);
}
