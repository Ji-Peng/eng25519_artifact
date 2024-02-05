/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ENG25519_OBJECTS_H
#define ENG25519_OBJECTS_H

#include <openssl/objects.h>

#ifdef NID_X25519
#undef NID_X25519
#endif

#ifdef NID_ED25519
#undef NID_ED25519
#endif

extern int NID_identity_md;
extern int NID_X25519;
extern int NID_ED25519;

int eng25519_register_nids();

#endif