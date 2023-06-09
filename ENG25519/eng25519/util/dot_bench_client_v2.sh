#!/bin/bash

. utils_v2.sh

client_backup_log_file
kill_dotcs
print_timeline

# align the start time
sleep_until "${start_time}"

client_print_status P256 benchmark start
write_command P256
for i in "${cores[@]}"; do
    dot_timer_p256 $i
    dotc_num=$(($dotc_num+1))
    if (($dotc_num == 7)); then
        client_print_status
        break
    fi
done
sleep $long_time
kill_dotcs
dotc_num=0
client_print_status P256 benchmark end
write_command P256-END
mecho

sleep $internel

client_print_status X25519 benchmark start
write_command X25519
for i in "${cores[@]}"; do
    dot_timer_X25519 $i
    dotc_num=$(($dotc_num+1))
    if (($dotc_num == 7)); then
        client_print_status
        break
    fi
done
sleep $long_time
kill_dotcs
dotc_num=0
client_print_status X25519 benchmark end
write_command X25519-END
mecho

sleep $internel

# before X25519-ALL-OpenSSL benchmark, the server needs to re-compile ENG25519 and restart unbound with corresponding ENGINE
compile_eng25519_allopenssl
client_print_status X25519-AllOpenSSL benchmark start
write_command X25519-AllOpenSSL
for i in "${cores[@]}"; do
    dot_timer_X25519_ENGINE $i
    dotc_num=$(($dotc_num+1))
    if (($dotc_num == 7)); then
        client_print_status
        break
    fi
done
sleep $long_time
kill_dotcs
dotc_num=0
client_print_status X25519-AllOpenSSL benchmark end
write_command X25519-AllOpenSSL-END
mecho

# sleep 10 minutes and start another benchmark
sleep $internel

# before X25519-ENG25519 benchmark, the server needs to restart unbound with ENG25519
compile_eng25519_us
client_print_status X25519-ENG25519 benchmark start
write_command X25519-ENG25519
for i in "${cores[@]}"; do
    dot_timer_X25519_ENGINE $i
    dotc_num=$(($dotc_num+1))
    client_print_status
    sleep $long_time
    if (($dotc_num == 10)); then
        break
    fi
done
kill_dotcs
dotc_num=0
client_print_status X25519-ENG25519 benchmark end
write_command X25519-ENG25519-END
mecho

sleep $internel

# The server will run without warmup operations
compile_eng25519_us
client_print_status X25519-ENG25519-COLD benchmark start
write_command X25519-ENG25519-COLD
for i in "${cores[@]}"; do
    dot_timer_X25519_ENGINE $i
    dotc_num=$(($dotc_num+1))
    client_print_status
    sleep $long_time
    if (($dotc_num == 10)); then
        break
    fi
done
kill_dotcs
dotc_num=0
client_print_status X25519-ENG25519-COLD benchmark end
write_command X25519-ENG25519-COLD-END
mecho

compile_eng25519_us
