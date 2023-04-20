#define _XOPEN_SOURCE 600
#define _POSIX_C_SOURCE 200112L
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define MAX_LINE_LENGTH 512

#ifdef DEBUG
#    define debug(format, args...) printf(format, ##args)
#else
#    define debug(format, args...)
#endif

typedef struct {
    char log_time[20];
    int thread_num;
    int query_num;
    int found_unbound;
    int out_of_date;
} log_line;

int get_lines(char *in_str, int end, log_line *log);
int get_empty_line_num(char *str);
int out_of_date(char *log_time);
void print_now_time();
void warm_up_avx512();

/** default time internel for unbound to output log information */
double log_internel = 60.0;
regex_t regex;

int main(int argc, char *argv[])
{
    FILE *fp;
    char line[MAX_LINE_LENGTH];
    long fp_pos;
    long off;
    int lines_len;
    int end = 0;
    /** in microsecond */
    int sleep_internel = 0;
    log_line log;
    int read_file = 1;

    if (argc != 3) {
        printf(
            "Usage: ./heuristic_warmup path internel, where \"path\" is the path of "
            "unbound's log file and \"internel\" is the time interval of unbound "
            "reporting statistic\n");
        printf("For example, ./heuristic_warmup /var/log/syslog 60\n");
        return 0;
    }

    log_internel = atoi(argv[2]);

    /**
     * The line we want to match looks like:
     * Apr 18 20:46:58 localhost unbound: [120655:0] info: server stats for thread 0:
     * 10560 queries, 0 answers from cache, 0 recursions, 0 prefetch, 0 rejected by ip
     * ratelimiting
     */
    regcomp(
        &regex,
        "(.*) localhost unbound: \\[[0-9]+:0\\] info: server stats for thread ([0-9]+): "
        "([0-9]+) queries.*",
        REG_EXTENDED);

    memset(&log, 0, sizeof(log));

    while (1) {
        if (log.found_unbound == 1 && log.out_of_date == 0 &&
            out_of_date(log.log_time) == 0) {
            read_file = 0;
        } else {
            read_file = 1;
        }

        if (read_file) {
            fp = fopen(argv[1], "r");
            if (fp == NULL) {
                printf("Could not open file\n");
                return 1;
            }

            fseek(fp, 0, SEEK_END);

            while (ftell(fp) > 0) {
                fp_pos = ftell(fp);
                if (fp_pos > MAX_LINE_LENGTH) {
                    off = MAX_LINE_LENGTH;
                } else {
                    off = fp_pos;
                    end = 1;
                }

                /** move forward */
                fseek(fp, -off, SEEK_CUR);
                memset(line, 0, MAX_LINE_LENGTH);
                /** fread will move fp backwards */
                if (fread(line, off, 1, fp) != 1) {
                    printf("fread error\n");
                    return 0;
                }
                /** move forward again */
                fseek(fp, -off, SEEK_CUR);
                lines_len = get_lines(line, end, &log);
                fseek(fp, off - lines_len, SEEK_CUR);
                if (log.found_unbound == 1) {
                    /**
                     * If we found a line of log in reverse order, it muse be the newest
                     * log. Therefore, the loop can end.
                     */
                    end = 1;
                }
                if (end == 1)
                    break;
            }
            fclose(fp);

            if (log.found_unbound == 1 && log.out_of_date == 0) {
                debug("\n");
                print_now_time();
                debug("found ");
                /** heuristic scheme */
                if (log.query_num >= 120000 || log.query_num < 60000) {
                    debug("low or high load, query_num=%d\n", log.query_num);
                    sleep_internel = 0;
                } else {
                    debug("medium load\n");
                    sleep_internel = 500;
                }
            } else {
                /** no unbound log info was found or no queriy was received */
                sleep_internel = 0;
            }
        }

        if (sleep_internel != 0) {
            /** execute a dummy vector instruction */
            warm_up_avx512();
        }

#ifdef DEBUG
        fflush(stdout);
#endif
        usleep(500);
    }

    return 0;
}

/**
 * @brief Convert the string in in_str to reverse order in line.
 *
 * @param in_str The input string
 * @param end If end=1, do not ignore the first line. Otherwise, ignore the first line
 * @param return The first line may be incomplete, so we return the length execluding the
 * first line
 * @param log_time Matched time of log
 * @param thread_num If -1, no unbound info is found. Otherwise, it equal to the matched
 * value.
 * @param query_num If -1, no unbound info is found. Otherwise, it equal to the matched
 * value.
 */
int get_lines(char *in_str, int end, log_line *log)
{
    char str[MAX_LINE_LENGTH + 1];
    char *invord_str[MAX_LINE_LENGTH];
    char *token, *last_token;
    int str_len = 0;
    int empty_line_num;
    int first_line = 1;
    int invord_idx = 0;
    regmatch_t match[4];

    memcpy(str, in_str, strlen(in_str));
    empty_line_num = get_empty_line_num(str);

    str_len += empty_line_num;
    token = strtok(str, "\n");
    while (token != NULL) {
        last_token = token;
        if (first_line && end != 1) {
            first_line = 0;
            // printf("the first line is: %s\n", last_token);
        } else {
            str_len += strlen(last_token) + 1;
            // printf("%s\n", last_token);
            /** store these lines in reverse order */
            invord_str[MAX_LINE_LENGTH - 1 - invord_idx] = last_token;
            invord_idx++;
        }
        token = strtok(NULL, "\n");
    }
    for (int i = MAX_LINE_LENGTH - invord_idx; i < MAX_LINE_LENGTH; i++) {
        // printf("%s\n", invord_str[i]);
        if (regexec(&regex, invord_str[i], 4, match, 0) == 0) {
            char tnum[10], qnum[10];
            int timelen = match[1].rm_eo - match[1].rm_so;
            int tlen = match[2].rm_eo - match[2].rm_so;
            int qlen = match[3].rm_eo - match[3].rm_so;

            strncpy(log->log_time, invord_str[i] + match[1].rm_so, timelen);
            log->log_time[timelen] = '\0';
            if (out_of_date(log->log_time)) {
                /** this log is out of date */
                log->found_unbound = 1;
                log->out_of_date = 1;
            } else {
                /** this log is valid */
                strncpy(tnum, invord_str[i] + match[2].rm_so, tlen);
                tnum[tlen] = '\0';
                log->thread_num = atoi(tnum);

                strncpy(qnum, invord_str[i] + match[3].rm_so, qlen);
                qnum[qlen] = '\0';
                log->query_num = atoi(qnum);

                log->found_unbound = 1;
                log->out_of_date = 0;
            }

            // debug("Time: %s\t Thread number: %d\t Queries: %d\t Out date: %d\n",
            //       log->log_time, log->thread_num, log->query_num, log->out_of_date);
            // debug("%s\n", invord_str[i]);
            return str_len;
        }
    }
    log->found_unbound = 0;
    return str_len;
}

/**
 * @brief Get the number of empty line
 */
int get_empty_line_num(char *str)
{
    int empty_lines = 0;

    char *pos = str;
    while (pos < str + strlen(str)) {
        if (*pos == '\n') {
            if (*(pos - 1) == '\n') {
                empty_lines++;
            }
        }
        pos++;
    }
    return empty_lines;
}

/**
 * |now_time - log_time| > log_internel, return 1.
 * Otherwise, return 0.
 */
int out_of_date(char *log_time)
{
    time_t nowtime;
    struct tm *nowtimeinfo;
    char nowtime_string[20];
    time_t target_time;
    double diff;

    /** a example: Apr 18 20:46:58 */
    const char *target_time_string = log_time;
    struct tm target_timeinfo = {0};
    if (strptime(target_time_string, "%b %d %H:%M:%S", &target_timeinfo) == NULL) {
        return 1;
    }

    time(&nowtime);
    nowtimeinfo = localtime(&nowtime);

    target_timeinfo.tm_year = nowtimeinfo->tm_year;
    target_time = mktime(&target_timeinfo);

    diff = difftime(mktime(nowtimeinfo), target_time);

    strftime(nowtime_string, sizeof(nowtime_string), "%b %d %H:%M:%S", nowtimeinfo);
    // printf("Current time: %s\n", nowtime_string);
    // printf("Time difference from %s: %f seconds\n", log_time, diff);
    if (diff > log_internel)
        return 1;
    else
        return 0;
}

void print_now_time()
{
    time_t nowtime;
    struct tm *nowtimeinfo;
    char nowtime_string[20];

    time(&nowtime);
    nowtimeinfo = localtime(&nowtime);
    strftime(nowtime_string, sizeof(nowtime_string), "%b %d %H:%M:%S", nowtimeinfo);

    debug("%s ", nowtime_string);
    fflush(stdout);
}

void warm_up_avx512()
{
    __asm__ __volatile__("vxorps %zmm0, %zmm0, %zmm0");
}
