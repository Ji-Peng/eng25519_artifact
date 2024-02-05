/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _DEBUG_H
#define _DEBUG_H

// ----------------------------------------------------------------

#ifdef _FORCE_NO_DEBUG
#    ifdef _DEBUG
#        undef _DEBUG
#    endif
#endif

#ifdef _FORCE_DEBUG
#    ifndef _DEBUG
#        define _DEBUG
#    endif
#endif

// #define PRINT_CC

#include <stdio.h>

#ifdef DEBUG_COLORS
// http://ascii-table.com/ansi-escape-sequences.php
// https://en.wikipedia.org/wiki/ANSI_escape_code
// http://misc.flogisoft.com/bash/tip_colors_and_formatting

#    define KRESET "\x1B[0m"
#    define KRED "\x1B[31m"
#    define KGRN "\x1B[32m"
#    define KYEL "\x1B[33m"
#    define KBLU "\x1B[34m"
#    define KMAG "\x1B[35m"
#    define KCYN "\x1B[36m"
#    define KWHT "\x1B[37m"

#    define KDBGL_FX KRESET "\x1B[4;38;5;202m"
#    define KDBGL_FN KRESET "\x1B[4;38;5;136m"
#    define KDBGL_LN KRESET "\x1B[4;38;5;130m"
#    define KDBGL_TX KRESET "\x1B[4m"

#    define DBGLOCFMT_BRIEF KDBGL_TX "@" KDBGL_FX "%-20s" KDBGL_TX ":\t" KRESET
#    define DBGLOCFMT                                                                 \
        KDBGL_FX "%s" KDBGL_TX "@ " KDBGL_FN "%s" KDBGL_TX ":" KDBGL_LN "%d" KDBGL_TX \
                 ":\t" KRESET
#    define KFTLMSG KRESET KRED
#    define KERRMSG KRESET KRED
#    define KWRNMSG KRESET "\x1B[38;5;226m"
#    define KINFMSG KRESET KCYN
#    define KDBGMSG KRESET "\x1B[38;5;33m"
#    define KVRBMSG KDBGMSG
#else
#    define KRESET ""
#    define KFTLMSG KRESET
#    define KERRMSG KRESET
#    define KWRNMSG KRESET
#    define KINFMSG KRESET
#    define KDBGMSG KRESET
#    define KVRBMSG KRESET
#    define DBGLOCFMT "%s@ %s:%d:\t"
#endif

#define LOG_FATAL (1)
#define LOG_ERR (2)
#define LOG_WARN (3)
#define LOG_INFO (4)
#define LOG_DBG (5)
#define LOG_VRB (6)
#define LOG_EXTRM (10)

#define _LOG_SL(KOLOR, format, args...)                   \
    do {                                                  \
        fprintf(_dbgstream, KOLOR format KRESET, ##args); \
    } while (0)

#define LOG_SL(level, args...)        \
    do {                              \
        if (level > debug_level)      \
            continue;                 \
        if (level >= LOG_VRB)         \
            _LOG_SL(KVRBMSG, ##args); \
        else if (level == LOG_DBG)    \
            _LOG_SL(KDBGMSG, ##args); \
        else if (level == LOG_INFO)   \
            _LOG_SL(KINFMSG, ##args); \
        else if (level == LOG_WARN)   \
            _LOG_SL(KWRNMSG, ##args); \
        else if (level == LOG_ERR)    \
            _LOG_SL(KERRMSG, ##args); \
        else if (level == LOG_FATAL)  \
            _LOG_SL(KFTLMSG, ##args); \
        fflush(_dbgstream);           \
    } while (0)

#define LOG(level, args...)                                           \
    do {                                                              \
        if (level > debug_level)                                      \
            continue;                                                 \
        fprintf(_dbgstream, DBGLOCFMT, __func__, __FILE__, __LINE__); \
        LOG_SL(level, ##args);                                        \
    } while (0)

extern FILE *_dbgstream;
void debug_logging_init(int default_level, const char *envvar_name);
void debug_logging_finish();

#ifdef _DEBUG
extern int debug_level;
extern char debug_brief;

#    define verbose(format, args...) LOG(LOG_VRB, format, ##args);
#    define verbose_sl(format, args...) LOG_SL(LOG_VRB, format, ##args);

#    define debug(format, args...) LOG(LOG_DBG, format, ##args);
#    define debug_sl(format, args...) LOG_SL(LOG_DBG, format, ##args);

#    define info(format, args...) LOG(LOG_INFO, format, ##args);
#    define info_sl(format, args...) LOG_SL(LOG_INFO, format, ##args);

#    define warn(format, args...) LOG(LOG_WARN, format, ##args);
#    define warn_sl(format, args...) LOG_SL(LOG_WARN, format, ##args);

#    define errorf(format, args...) LOG(LOG_ERR, format, ##args);
#    define errorf_sl(format, args...) LOG_SL(LOG_ERR, format, ##args);

#    define fatalf(format, args...) LOG(LOG_FATAL, format, ##args);
#    define fatalf_sl(format, args...) LOG_SL(LOG_FATAL, format, ##args);

void debug_32B(int lvl, const void *p);
void _debug_print_b64(int lvl, const void *p, size_t len);

#    define debug_b64(lvl, pt, len, format, args...)                \
        do {                                                        \
            LOG(lvl, #pt "(len=%lu)=" format, (size_t)len, ##args); \
            _debug_print_b64(lvl, pt, len);                         \
        } while (0);

#else
#    define verbose(format, args...)
#    define verbose_sl(format, args...)

#    define debug(format, args...)
#    define debug_sl(format, args...)

#    define info(format, args...)
#    define info_sl(format, args...)

#    define warn(format, args...) fprintf(stderr, format, ##args);
#    define warn_sl(format, args...) fprintf(stderr, format, ##args);

#    define errorf(format, args...) fprintf(stderr, format, ##args);
#    define errorf_sl(format, args...) fprintf(stderr, format, ##args);

#    define fatalf(format, args...) fprintf(stderr, format, ##args);
#    define fatalf_sl(format, args...) fprintf(stderr, format, ##args);

#    define debug_32B(lvl, void_args...)
#    define debug_b64(lvl, void_args...)

// #    define debug_logging_init(lvl, varname)
// #    define debug_logging_finish()
#endif

#include <stdint.h>
#include <stdio.h>
uint64_t cycles_now(void);

#endif /* _DEBUG_H */
