/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

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