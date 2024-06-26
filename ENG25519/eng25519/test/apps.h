/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _APPS_H
#define _APPS_H

#include <openssl/bio.h>
#include <openssl/engine.h>
#include <openssl/evp.h>

extern BIO *bio_err;

void apps_init(void);
ENGINE *setup_engine(const char *engine, int debug);
void release_engine(ENGINE *e);

int EVP_PKEY_name_parser(int *nid, int *subparam, ENGINE **e, const char *name);
EVP_PKEY *EVP_PKEY_keygen_wrapper(int nid, int subparam, ENGINE *engine);

#endif /* _APPS_H */
