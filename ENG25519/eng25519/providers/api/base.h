/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef ENG25519_BASE_API_H
#define ENG25519_BASE_API_H

/**
 * Initialize implementation backend.
 * This is called during the ENGINE bind() function.
 * 
 * Returns 1 on success, 0 otherwise.
 */
extern int eng25519_implementation_init(void);

/**
 * Deinitialize implementation backend.
 * This is called during the ENGINE destroy() function.
 * 
 * Returns 1 on success, 0 otherwise.
 */
extern int eng25519_implementation_deinit(void);

#endif