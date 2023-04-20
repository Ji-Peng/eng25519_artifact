#include <stdint.h>

typedef struct dns_query_format {
    /** A: 01, IP address */
    uint16_t type;
    /** default = 1 */
    uint16_t classes;
} DNS_QRY_FMT;

typedef struct dns_header {
    /* a 16 bit identifier assigned by the client */
    uint16_t id;
    /**
     * qr: query or response, 0=query, 1=response
     * opcode: 0=standard query
     * aa: authoritative answer, default is 0
     * tc: Can be truncated?
     * rd: recursion desired
     * ra: recursion available
     * z: must be zeros
     * rcode: 0: no errors; 3: errors, no domain name.
     *
     * bit15, 0: query, 1: answer
     * bit14-bit11: 0: standard query
     * bit10: default is 0, authoritative answer
     * bit9: Can be truncated?
     * bit8: recursion desired
     * bit7: recursion available
     * bit6-bit4: must be 0
     * bit3-bit0: 0: no errors; 3: errors, no domain name.
     */
    uint16_t flags;
    /** Questions count */
    uint16_t numq;
    /** Answer RRs */
    uint16_t numAnswerRR;
    /** Authority RRs */
    uint16_t numAuthRR;
    /** Additional RRs */
    uint16_t numAddRR;
} DNS_HEADER;