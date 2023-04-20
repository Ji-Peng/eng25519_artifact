/**
 ******************************************************************************
 * @file ecdh.h
 * @version 1.0.1
 * @date 2020-09-01
 * @copyright Copyright © 2020 by University of Luxembourg.
 * @author Developed at SnT APSIA by: H. Cheng, J. Groszschaedl, and J. Tian.
 *
 * @brief Header file of ECDH key exchange functions.
 *
 * @details
 * This file contains function prototypes of the ECDH key-pair generation and
 * the computation of the shared secret.
 ******************************************************************************
 */

#ifndef _KEM_H
#define _KEM_H

#include "gfparith.h"

#define BATCH_SIZE 8
#define SECRET_KEY_BYTES 32
#define PUBLIC_KEY_BYTES 32
#define SHARED_KEY_BYTES 32

void keygen(__m512i *pk, const __m512i *sk);
void shared_secret(__m512i *ss, const __m512i *ska, const __m512i *pkb);
void crypto_x25519_batch_keygen(uint8_t *pks, uint8_t *sks);
void crypto_ed25519_batch_keygen(uint8_t *pks, uint8_t *sks);
// void crypto_x25519_sharedsecret(uint8_t *ss, const uint8_t *ska, const uint8_t *pkb);

#endif
