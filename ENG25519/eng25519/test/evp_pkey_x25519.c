#include <openssl/bio.h>
#include <openssl/bn.h>
#include <openssl/dsa.h>
#include <openssl/ec.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/rsa.h>
#include <string.h>

#include "apps.h"
#include "ossl/eng25519_objects.h"
#include "ossl_compat.h"

#define LOAD_ENG25519

#ifdef LOAD_ENG25519
#    ifndef _DEBUG
#        define _DEBUG
#    endif /* _DEBUG */
// #include "meths/ed25519_meth.h"
#endif /* LOAD_ENG25519 */

const char *prog_name = __FILE__;

void print_help()
{
    BIO_printf(bio_err,
               "Syntax: %s {op} {name} {privkey_hexstring}\n"
               "\t{op} is either:\n"
               "\t\t1\t : print private key\n"
               "\t\t2\t : print public key\n"
               "\t\t3\t : print both\n",
               prog_name);
    BIO_printf(bio_err,
               "\n"
               "EXAMPLE (print PEM private key):\n\t\"%s 1 %s %s\"\n",
               prog_name, "EVP_PKEY_EC:prime192v1",
               "323FA3169D8E9C6593F59476BC142000AB5BE0E249C43426");
    BIO_printf(
        bio_err,
        "\n"
        "EXAMPLE (print PEM public key):\n\t\"%s 2 %s %s\"\n",
        prog_name, "ED25519",
        "833fe62409237b9d62ec77587520911e9a759cec1d19755b7da901b96dca3d42");
    return;
}

static EC_KEY *EC_KEY_new_set_private(int nid, const char *hexprivkey)
{
    const EC_GROUP *group = NULL;
    EC_POINT *pub_key = NULL;
    EC_KEY *eck = NULL;
    BIGNUM *bn = NULL;

    eck = EC_KEY_new_by_curve_name(nid);
    if (!eck) {
        BIO_printf(bio_err, "Error creating EC_KEY by nid=%i\n", nid);
        goto err;
    }

    int hexlen = BN_hex2bn(&bn, hexprivkey);
    if (strlen(hexprivkey) != (size_t)hexlen) {
        BIO_printf(bio_err, "Error creating BIGNUM\n");
        goto err;
    }

    if (!EC_KEY_set_private_key(eck, bn)) {
        BIO_printf(bio_err, "Error setting private key\n");
        goto err;
    }

    // generate the corresponding public key
    group = EC_KEY_get0_group(eck);
    pub_key = EC_POINT_new(group);

    if (!EC_POINT_mul(group, pub_key, bn, NULL, NULL, NULL)) {
        BIO_printf(bio_err, "Error deriving public key\n");
        goto err;
    }

    if (!EC_KEY_set_public_key(eck, pub_key)) {
        BIO_printf(bio_err, "Error setting public key\n");
        goto err;
    }

    return eck;

err:
    ERR_print_errors(bio_err);
    if (eck)
        EC_KEY_free(eck);
    if (bn)
        BN_free(bn);
    if (pub_key)
        EC_POINT_free(pub_key);
    return NULL;
}

EVP_PKEY *EVP_PKEY_set_private(const char *name, const char *hexprivkey)
{
    // void *to_free = NULL;
    EVP_PKEY *pkey = NULL;

    ENGINE *e = NULL;
    int nid = NID_undef, subparam = 0;

    if (1 != EVP_PKEY_name_parser(&nid, &subparam, &e, name)) {
        BIO_printf(bio_err, "Cannot identify %s\n", name);
        goto err;
    }

    pkey = EVP_PKEY_keygen_wrapper(nid, subparam, e);
    if (!pkey) {
        BIO_printf(bio_err, "Cannot generate key for %s\n", name);
        goto err;
    }

    if (!hexprivkey)
        return pkey;

    if (nid == EVP_PKEY_EC) {
        EC_KEY *eck = NULL;

        eck = EC_KEY_new_set_private(subparam, hexprivkey);
        if (!eck) {
            BIO_printf(bio_err, "Error setting EC_KEY private key\n");
            goto err;
        }
        if (!EVP_PKEY_set1_EC_KEY(pkey, eck)) {
            BIO_printf(bio_err, "Error setting EVP private key\n");
            goto err;
        }
        // #ifdef LOAD_ENG25519
        //     } else if (nid == NID_ED25519) {
        //         size_t len = 0;
        //         unsigned char *sk = OPENSSL_hexstr2buf(hexprivkey, &len);

        //         if (len != Ed25519_PRIVKEYLEN) {
        //             OPENSSL_free(sk);
        //             BIO_printf(bio_err, "Private key length should be exactly
        //             %u bytes (read %lu B)\n",
        //                     Ed25519_PRIVKEYLEN, len);
        //             goto err;
        //         }
        //         if (1 != EVP_PKEY_ed25519_set_private(pkey, sk)) {
        //             OPENSSL_free(sk);
        //             BIO_printf(bio_err, "Error setting EVP private key\n");
        //             goto err;
        //         }

        //         OPENSSL_free(sk);
        // #endif /* LOAD_ENG25519 */
        //  } else if (nid == EVP_PKEY_DSA) {
        //  } else if (nid == EVP_PKEY_RSA) {
    } else {
        BIO_printf(bio_err, "%s NOT IMPLEMENTED for %s\n", __func__, name);
        goto err;
    }

    return pkey;
err:
    ERR_print_errors(bio_err);
    if (pkey)
        EVP_PKEY_free(pkey);
    return NULL;
}

enum op_type {
    UNDEF = -1,
    PRINT_PRIVATE = 0x1,
    PRINT_PUBLIC = 0x2,
    PRINT_BOTH = 0x3,
};

int main(int argc, char *argv[])
{
    int nid = NID_undef, subparam = 0;
    ENGINE *e = NULL;
    const char *name = "X25519";
    EVP_PKEY_CTX *ctx = NULL, *peer_ctx = NULL;
    EVP_PKEY *pkey = NULL, *peer_pkey = NULL;
    size_t keylen = 0;
    uint8_t *key = NULL, *peer_key = NULL;

    prog_name = argv[0];
    (void)argc;
    /* define  OPENSSL_CONF=$PWD/eng25519.cnf */
    apps_init();

    if (1 != EVP_PKEY_name_parser(&nid, &subparam, &e, name)) {
        BIO_printf(bio_err, "Cannot identify %s\n", name);
        goto end;
    }
    pkey = EVP_PKEY_keygen_wrapper(nid, subparam, e);
    if (!pkey) {
        BIO_printf(bio_err, "Cannot generate key for %s\n", name);
        goto end;
    }
    peer_pkey = EVP_PKEY_keygen_wrapper(nid, subparam, e);
    if (!peer_pkey) {
        BIO_printf(bio_err, "Cannot generate key for %s\n", name);
        goto end;
    }
    if (!(ctx = EVP_PKEY_CTX_new(pkey, e))) {
        BIO_printf(bio_err, "%s: Failure in parameters ctx generation\n",
                   OBJ_nid2sn(nid));
        goto end;
    }
    if (!(peer_ctx = EVP_PKEY_CTX_new(peer_pkey, e))) {
        BIO_printf(bio_err, "%s: Failure in parameters ctx generation\n",
                   OBJ_nid2sn(nid));
        goto end;
    }
    // EVP_PKEY_print_public(bio_err, pkey, 2, NULL);
    EVP_PKEY_print_private(bio_err, pkey, 2, NULL);
    // EVP_PKEY_print_public(bio_err, peer_pkey, 2, NULL);
    EVP_PKEY_print_private(bio_err, peer_pkey, 2, NULL);

    if (EVP_PKEY_derive_init(ctx) <= 0) {
        BIO_printf(bio_err, "Failure in derive init\n");
        goto end;
    }
    if (EVP_PKEY_derive_init(peer_ctx) <= 0) {
        BIO_printf(bio_err, "Failure in derive init\n");
        goto end;
    }
    if (EVP_PKEY_derive_set_peer(ctx, EVP_PKEY_CTX_get0_pkey(peer_ctx)) <= 0) {
        BIO_printf(bio_err, "Failure in derive_set_peer\n");
        goto end;
    }
    if (EVP_PKEY_derive_set_peer(peer_ctx, EVP_PKEY_CTX_get0_pkey(ctx)) <= 0) {
        BIO_printf(bio_err, "Failure in derive_set_peer\n");
        goto end;
    }
    if (EVP_PKEY_derive(ctx, NULL, &keylen) <= 0) {
        BIO_printf(bio_err, "Failure in getting keylen\n");
        goto end;
    }
    if ((key = OPENSSL_secure_malloc(keylen)) == NULL ||
        (peer_key = OPENSSL_secure_malloc(keylen)) == NULL) {
        BIO_printf(bio_err, "Failure in malloc for key\n");
        goto end;
    }
    if (EVP_PKEY_derive(ctx, key, &keylen) <= 0) {
        BIO_printf(bio_err, "Failure in EVP_PKEY_derive\n");
        goto end;
    }
    if (EVP_PKEY_derive(peer_ctx, peer_key, &keylen) <= 0) {
        BIO_printf(bio_err, "Failure in EVP_PKEY_derive\n");
        goto end;
    }
    if (memcmp(key, peer_key, keylen) == 0) {
        BIO_printf(bio_err, "Success!\n");
    } else {
        BIO_printf(bio_err, "Failure!\n");
    }

end:
    ERR_print_errors(bio_err);
    if (pkey)
        EVP_PKEY_free(pkey);
    if (peer_pkey)
        EVP_PKEY_free(peer_pkey);
    if (ctx)
        EVP_PKEY_CTX_free(ctx);
    if (peer_ctx)
        EVP_PKEY_CTX_free(peer_ctx);
    if (key)
        OPENSSL_secure_clear_free(key, keylen);
    if (peer_key)
        OPENSSL_secure_clear_free(peer_key, keylen);
    BIO_free(bio_err);
    return 0;
}

/* vim: set ts=4 sw=4 tw=78 et : */
