#ifndef HEADER_ENG25519ERR_H
# define HEADER_ENG25519ERR_H

# define ENG25519err(f, r) ERR_ENG25519_error((f), (r), __FILE__, __LINE__)


# ifdef  __cplusplus
extern "C" {
# endif
int ERR_load_ENG25519_strings(void);
void ERR_unload_ENG25519_strings(void);
void ERR_ENG25519_error(int function, int reason, char *file, int line);
# ifdef  __cplusplus
}
# endif

/*
 * ENG25519 function codes.
 */
# define ENG25519_F_ASN1_ED25519_ITEM_VERIFY              115
# define ENG25519_F_ASN1_GENERIC_CTRL                     100
# define ENG25519_F_ASN1_GENERIC_PRIV_DECODE              101
# define ENG25519_F_ASN1_GENERIC_PRIV_ENCODE              102
# define ENG25519_F_ASN1_GENERIC_PUB_DECODE               103
# define ENG25519_F_ASN1_GENERIC_PUB_ENCODE               104
# define ENG25519_F_ED25519_KEYGEN                        105
# define ENG25519_F_ED25519_SIGN                          106
# define ENG25519_F_ED25519_SK_TO_PK                      107
# define ENG25519_F_ED25519_VERIFY                        108
# define ENG25519_F_ENG25519_KEYPAIR_NEW                  109
# define ENG25519_F_EVP_PKEY_CTX_ED25519_SET_PRIVATE      113
# define ENG25519_F_EVP_PKEY_ED25519_SET_PRIVATE          114
# define ENG25519_F_X25519_DERIVE                         110
# define ENG25519_F_X25519_KEYGEN                         111
# define ENG25519_F_X25519_SK_TO_PK                       112

/*
 * ENG25519 reason codes.
 */
# define ENG25519_R_BAD_SIGNATURE                         100
# define ENG25519_R_CANNOT_DERIVE_PK                      101
# define ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN 107
# define ENG25519_R_INVALID_ENCODING                      102
# define ENG25519_R_INVALID_KEY                           103
# define ENG25519_R_INVALID_PEER_KEY                      104
# define ENG25519_R_INVALID_PRIVATE_KEY                   105
# define ENG25519_R_KEYS_NOT_SET                          106
# define ENG25519_R_MISSING_NID_DATA                      108
# define ENG25519_R_MISSING_PRIVATE_KEY                   109
# define ENG25519_R_RANDOM_NUMBER_GENERATION_FAILED       110
# define ENG25519_R_WRONG_LENGTH                          111

#endif
