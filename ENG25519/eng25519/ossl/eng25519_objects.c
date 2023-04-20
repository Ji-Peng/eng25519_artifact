
#include "eng25519_objects.h"

#include "debug/debug.h"
#include "eng25519_objects_internal.h"

int NID_identity_md;
int NID_X25519;
int NID_ED25519;

static int _eng25519_register_nid(const char *oid_str, const char *sn, const char *ln)
{
    int new_nid = NID_undef;

    if (NID_undef != (new_nid = OBJ_sn2nid(sn))) {
        debug("'%s' is already registered with NID %d\n", sn, new_nid);
        return new_nid;
    }

    new_nid = OBJ_create(oid_str, sn, ln);

    if (new_nid == NID_undef) {
        fatalf("Failed to register NID for '%s'\n", ln);
        return 0;
    }
    debug("Registered '%s' with NID %d\n", sn, new_nid);

    ASN1_OBJECT *obj = OBJ_nid2obj(new_nid);
    if (!obj) {
        fatalf("Failed to retrieve ASN1_OBJECT for dynamically registered NID\n");
        return 0;
    }

    return new_nid;
}

#define ENG25519_REGISTER_NID(___BASENAME)                                       \
    if (NID_undef == (NID_##___BASENAME = _eng25519_register_nid(                \
                          eng25519_OID_##___BASENAME, eng25519_SN_##___BASENAME, \
                          eng25519_LN_##___BASENAME))) {                         \
        errorf("Failed to register NID for '%s'\n", eng25519_SN_##___BASENAME);  \
        return 0;                                                                \
    }

int eng25519_register_nids()
{
    ENG25519_REGISTER_NID(identity_md);

    ENG25519_REGISTER_NID(X25519);

    ENG25519_REGISTER_NID(ED25519);

    return 1;
}