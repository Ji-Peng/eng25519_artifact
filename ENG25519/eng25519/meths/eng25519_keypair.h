/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ENG25519_ECDH_KEYPAIR_H
#define ENG25519_ECDH_KEYPAIR_H

#include <openssl/obj_mac.h>
#include <stddef.h> /** size_t */
#include <stdint.h> /** uint8_t */

#define CURVE25519_BITS 253
#define CURVE25519_SECURITY_BITS 128

#define X25519_PUBKEYLEN 32U   // crypto_scalarmult_curve25519_BYTES
#define X25519_PRIVKEYLEN 32U  // crypto_scalarmult_curve25519_BYTES
#define X25519_SHAREDKEYLEN 32U

#define Ed25519_PUBKEYLEN 32U   // crypto_sign_ed25519_PUBLICKEYBYTES
#define Ed25519_PRIVKEYLEN 32U  // crypto_sign_ed25519_SEEDBYTES
#define Ed25519_EXP_PRIVKEYLEN \
    (32U + 32U)                  // crypto_sign_ed25519_SECRETKEYBYTES
#define Ed25519_SIGN_LENGTH 64U  // crypto_sign_ed25519_BYTES

/**
 * Information about a algorithm instructed by NID.
 * nid: algorithm's id.
 * name: algorithm name.
 * sk_bytes: number of bytes of secret key.
 * pk_bytes: number of bytes of public key.
 * sk_to_pk: function used for computing public key from secret key. This
 * function will be used when implementing ASN1-related functions.
 * default_md_nid: NID of default message digest algorithm.
 */
typedef struct {
    int nid;
    const char *name;
    size_t sk_bytes;
    size_t pk_bytes;
    int (*sk_to_pk)(uint8_t *pk, const uint8_t *sk);
    int default_md_nid;
} ENG25519_ECDH_NID_DATA;

/**
 * A keypair structure.
 * nid: algorithm's id.
 * nid_data: algorithm related information.
 * sk: secret key.
 * pk: public key.
 * has_private: communication peer always has not a private key, and peer's
 * keypair is set in ctrl function when op == ASN1_PKEY_CTRL_SET1_TLS_ENCPT.
 */
typedef struct {
    int nid;
    const ENG25519_ECDH_NID_DATA *nid_data;

    uint8_t *sk;
    uint8_t *pk;
    char has_private;
} ENG25519_KEYPAIR;

/**
 * 0: has private key.
 * 1: no private key.
 */
typedef enum {
    NO_FLAG = 0,
    NO_PRIV_KEY = 1,
} eng25519_keypair_flags_t;

/**
 * Alloc memory for a ENG25519_KEYPAIR struct.
 */
ENG25519_KEYPAIR *eng25519_keypair_new(int nid, eng25519_keypair_flags_t flags);

/**
 * Free memory for a ENG25519_KEYPAIR struct.
 */
void eng25519_keypair_free(ENG25519_KEYPAIR *kp);

/**
 * Obtain algorithm information related to the nid.
 */
const ENG25519_ECDH_NID_DATA *eng25519_get_nid_data(int nid);

#define _eng25519_keypair_is_invalid(kp, contains_private)               \
    ((kp) == NULL || ((contains_private) && (1 != (kp)->has_private)) || \
     NULL == eng25519_get_nid_data((kp)->nid))

#define eng25519_keypair_is_invalid(kp) _eng25519_keypair_is_invalid((kp), 0)
#define eng25519_keypair_is_invalid_private(kp) \
    _eng25519_keypair_is_invalid((kp), 1)

#endif