/*
 * Copyright 2021 Nicola Tuveri <nic.tuv@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <string.h>
#include <openssl/err.h>
#include <openssl/ssl.h>

#define VERSION "20210407"

#define DFLT_CONNECT "localhost:853"
#define DFLT_CONNECTIONS (1024ULL)

struct ssl_key_info_st
{
    const char *key_type;
    int bits;
};

static int ssl_get_tmp_key_info(struct ssl_key_info_st *info, SSL *s)
{
    int rv = 0;
    EVP_PKEY *k = NULL;

    if (info == NULL || s == NULL)
        return 0;

    /**
     * SSL_get_peer_tmp_key() returns the temporary key provided by the peer and used during key exchange.
     * For example, if ECDHE is in use, then this represents the peer's public ECDHE key.
     */
    if (!SSL_get_peer_tmp_key(s, &k))
        goto end;

    switch (EVP_PKEY_id(k))
    {
#ifndef OPENSSL_NO_EC
    case EVP_PKEY_EC:
    {
        const char *curve_name = NULL;
        int curve_nid;
        const EC_KEY *ec;

        if ((ec = EVP_PKEY_get0_EC_KEY(k)) == NULL)
            goto end;
        curve_nid = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
        if (curve_nid != NID_undef)
        {
#define ECCURVE_NID2NIST(NID, NAME) \
    case NID:                       \
        curve_name = NAME;          \
        break
            switch (curve_nid)
            {
                ECCURVE_NID2NIST(NID_sect163r2, "B-163");
                ECCURVE_NID2NIST(NID_sect233r1, "B-233");
                ECCURVE_NID2NIST(NID_sect283r1, "B-283");
                ECCURVE_NID2NIST(NID_sect409r1, "B-409");
                ECCURVE_NID2NIST(NID_sect571r1, "B-571");
                ECCURVE_NID2NIST(NID_sect163k1, "K-163");
                ECCURVE_NID2NIST(NID_sect233k1, "K-233");
                ECCURVE_NID2NIST(NID_sect283k1, "K-283");
                ECCURVE_NID2NIST(NID_sect409k1, "K-409");
                ECCURVE_NID2NIST(NID_sect571k1, "K-571");
                ECCURVE_NID2NIST(NID_X9_62_prime192v1, "P-192");
                ECCURVE_NID2NIST(NID_secp224r1, "P-224");
                ECCURVE_NID2NIST(NID_X9_62_prime256v1, "P-256");
                ECCURVE_NID2NIST(NID_secp384r1, "P-384");
                ECCURVE_NID2NIST(NID_secp521r1, "P-521");
            default:
                curve_name = OBJ_nid2sn(curve_nid);
            }
#undef ECCURVE_NID2NIST
        }
        else
        {
            curve_name = "ECDH (custom curve)";
        }
        info->key_type = curve_name;
    }
    break;
    default:
        info->key_type = OBJ_nid2sn(EVP_PKEY_id(k));
#endif
    }

    info->bits = EVP_PKEY_bits(k);
    rv = 1;

end:
    EVP_PKEY_free(k);
    return rv;
}

static SSL *do_connect(const char *host, SSL_CTX *ctx)
{
    int rv = 0;
    SSL *sconn = NULL;
    BIO *conn = NULL;

    if ((conn = BIO_new_connect(host)) == NULL)
        return NULL;
    if ((sconn = SSL_new(ctx)) == NULL)
        goto err;
    if (!BIO_set_conn_hostname(conn, host))
        goto err;

    /* SSL_set_bio() transfers ownership of the BIO to the SSL object */
    SSL_set_bio(sconn, conn, conn);
    conn = NULL;

    rv = SSL_connect(sconn);
    if (rv == 1)
    {
        return sconn;
    }
    else if (rv <= 0)
    {
        rv = SSL_get_error(sconn, rv);

#define HANDLE_SSL_ERROR(err)              \
    case err:                              \
        fprintf(stderr, "Got " #err "\n"); \
        break;

        switch (rv)
        {
            HANDLE_SSL_ERROR(SSL_ERROR_NONE);
            HANDLE_SSL_ERROR(SSL_ERROR_ZERO_RETURN);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_READ);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_WRITE);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_CONNECT);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_ACCEPT);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_X509_LOOKUP);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_ASYNC);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_ASYNC_JOB);
            HANDLE_SSL_ERROR(SSL_ERROR_WANT_CLIENT_HELLO_CB);
            HANDLE_SSL_ERROR(SSL_ERROR_SYSCALL);
            HANDLE_SSL_ERROR(SSL_ERROR_SSL);
        default:
            fprintf(stderr, "SSL: Unexpected error\n");
        }
#undef HANDLE_SSL_ERROR
    }

err:
    ERR_print_errors_fp(stderr);
    BIO_free(conn);
    SSL_free(sconn);
    return NULL;
}

#include <sys/time.h>

static uint64_t main_loop(uint64_t connections, const char *host, SSL_CTX *ctx)
{
    uint64_t ret, i;
    struct timeval start, end;

    gettimeofday(&start, NULL);
    for (i = 0; i < connections; i++)
    {
        SSL *ssl_conn;

        ssl_conn = do_connect(host, ctx);
        if (ssl_conn == NULL)
        {
            fprintf(stderr, "Connection error\n");
            goto end;
        }
        SSL_shutdown(ssl_conn);
        SSL_free(ssl_conn);
    }
    gettimeofday(&end, NULL);

    ret = (end.tv_sec - start.tv_sec) * 1E6 + end.tv_usec - start.tv_usec;
    return ret;

end:
    return 0;
}

int main(int argc, char **argv)
{
    BIO *sbio = NULL, *out = NULL;
    SSL_CTX *ctx = NULL;
    SSL_CONF_CTX *cctx = NULL;
    char **args = argv + 1;
    const char *connect_str = DFLT_CONNECT;
    char *endptr = NULL;
    int nargs = argc - 1;
    int rv;
    uint64_t connections = DFLT_CONNECTIONS;
    uint64_t usec;
    struct ssl_key_info_st kinfo;

    /* Load default configuration file with default init options */
    rv = OPENSSL_init_ssl(
        OPENSSL_INIT_LOAD_SSL_STRINGS | OPENSSL_INIT_LOAD_CRYPTO_STRINGS |
            OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS |
            OPENSSL_INIT_LOAD_CONFIG | OPENSSL_INIT_ASYNC | OPENSSL_INIT_ATFORK,
        NULL);
    if (!rv)
    {
        fprintf(stderr, "Failure on OPENSSL_init_ssl\n");
        goto end;
    }

    ctx = SSL_CTX_new(TLS_client_method());
    cctx = SSL_CONF_CTX_new();
    SSL_CONF_CTX_set_flags(cctx, SSL_CONF_FLAG_CLIENT | SSL_CONF_FLAG_SHOW_ERRORS);
    SSL_CONF_CTX_set_ssl_ctx(cctx, ctx);
    while (*args && *args[0] == '-')
    {
        /* Parse application specific arguments first */
        if (strcmp(*args, "-help") == 0)
        {
            const char *pname = argv[0];
            fprintf(stderr,
                    "TLS timer v%s: measure wall-clock time for a fixed number of TLS connections\n\n"
                    "\tUsage: %s [options...]\n\n"
                    "\tSupported options:\n"
                    "\t\t%-20s\t%s\n"
                    "\t\t%-20s\t%s\n"
                    "\t\t%-20s\t%s\n",
                    VERSION, pname,
                    "-n <int>", "Number of connections to benchmark",
                    "-connect <addr>", "Server address",
                    "-*", "Any CLI command supported by SSL_CONF_cmd(3)");
            rv = 0;
            goto end;
        }
        else if (strcmp(*args, "-connect") == 0)
        {
            connect_str = args[1];
            if (connect_str == NULL)
            {
                fprintf(stderr, "Missing -connect argument\n");
                goto end;
            }
            args += 2;
            nargs -= 2;
            continue;
        }
        else if (strcmp(*args, "-n") == 0)
        {
            if (args[1] == NULL)
            {
                fprintf(stderr, "Missing -n argument\n");
                goto end;
            }
            connections = strtoull(args[1], &endptr, 0);
            if (endptr == NULL || *args[1] == '\0' || *endptr != '\0')
            {
                fprintf(stderr, "Invalid -n argument\n");
                goto end;
            }
            args += 2;
            nargs -= 2;
            continue;
        }

        /* Parse SSL_CONF_cmd(3) arguments */
        rv = SSL_CONF_cmd_argv(cctx, &nargs, &args);
        if (rv == -3)
        {
            fprintf(stderr, "Missing argument for %s\n", *args);
            ERR_print_errors_fp(stderr);
            goto end;
        }
        else if (rv == -1)
        {
            fprintf(stderr, "Bad argument for %s\n", *args);
            ERR_print_errors_fp(stderr);
            goto end;
        }
        if (rv < 0)
        {
            fprintf(stderr, "Error in command %s\n", *args);
            ERR_print_errors_fp(stderr);
            goto end;
        }
        /* If rv > 0 we processed something so proceed to next arg */
        if (rv > 0)
        {
            continue;
        }
        else
        {
            fprintf(stderr, "Unknown argument %s\n", *args);
            goto end;
        }
    }

    if (!SSL_CONF_CTX_finish(cctx))
    {
        fprintf(stderr, "Finish error\n");
        ERR_print_errors_fp(stderr);
        goto end;
    }

    /* Don't want any retries */
    SSL_CTX_set_mode(ctx, SSL_MODE_AUTO_RETRY); // | SSL_MODE_ASYNC

    /* Quiet shutdown means that upon shutdown we violate the TLS
     * standard, and don't send the `close notify` alert.
     *
     * This is EVIL, so we disable it explicitly.
     */
    SSL_CTX_set_quiet_shutdown(ctx, 0);

    {
        SSL *ssl_conn;

        ssl_conn = do_connect(connect_str, ctx);
        if (ssl_conn == NULL)
        {
            fprintf(stderr, "Connection error\n");
            goto end;
        }

        rv = ssl_get_tmp_key_info(&kinfo, ssl_conn);

        SSL_shutdown(ssl_conn);
        SSL_free(ssl_conn);

        if (!rv)
        {
            fprintf(stderr, "Error retrieving peer tmp key info\n");
            goto end;
        }
    }
    rv = 1;

    usec = main_loop(connections, connect_str, ctx);
    if (usec == 0)
        goto end;

    printf("{ "
           "\"%s\": %" PRIu64 ", "
           "\"%s\": %" PRIu64 ", "
           "\"%s\": \"%s\", "
           "\"%s\": %d "
           "}\n",
           "connections", connections,
           "wallclock_usec", usec,
           "key_type", kinfo.key_type,
           "key_bits", kinfo.bits);

    rv = 0;

end:
    if (rv != 0)
    {
        ERR_print_errors_fp(stderr);
        rv = 1;
    }
    SSL_CONF_CTX_free(cctx);
    SSL_CTX_free(ctx);
    BIO_free_all(sbio);
    BIO_free(out);

    return rv;
}
