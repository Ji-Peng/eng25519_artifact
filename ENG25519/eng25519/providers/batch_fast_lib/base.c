
#include "providers/api/base.h"

#include "batch.h"
#include "debug/debug.h"

int eng25519_implementation_init(void)
{
    verbose("CALLED\n");
    return eng25519_prov_batch_init();
}

int eng25519_implementation_deinit(void)
{
    verbose("CALLED\n");
    return eng25519_prov_batch_deinit();
}