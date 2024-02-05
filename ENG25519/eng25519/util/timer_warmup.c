/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

void warm_up_avx512(int signo)
{
    (void)signo;
    __asm__ __volatile__("vxorps %zmm0, %zmm0, %zmm0");
}

int main()
{
    struct sigaction act;
    union sigval tsval;
    act.sa_handler = warm_up_avx512;
    act.sa_flags = 0;
    sigemptyset(&act.sa_mask);
    sigaction(50, &act, NULL);
    while (1) {
        /** sleep 500 us */
        usleep(500);
        /** send signal */
        sigqueue(getpid(), 50, tsval);
    }
    return 0;
}