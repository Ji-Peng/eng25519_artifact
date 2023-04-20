
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