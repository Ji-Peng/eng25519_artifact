#!/bin/bash

. utils.sh

server_backup_log_file
print_timeline

sleep_until "${start_time}"
start_unbound
# wait the client really start P256
wait_until P256
server_print_status P-256 benchmark start
for ((i=1; i<=${#cores[@]}; i++))
do
    printf -v filename "throughput/$current_time_path/P256_dotc_%02d.txt" $i
    for ((j=1; j<=10; j++))
    do
        sleep $(($long_time / 10))
        backup_unbound_log $filename
    done
    server_notify_to_bark "We got $(basename "$filename")"
done
wait_until P256-END
server_print_status P-256 benchmark end
mecho

sleep $(($internel - 60))
compile_eng25519_us
start_unbound_eng25519
wait_until X25519-ENG25519
server_print_status X25519-ENG25519 benchmark start
for ((i=1; i<=${#cores[@]}; i++))
do
    printf -v filename "throughput/$current_time_path/X25519_ENG25519_dotc_%02d.txt" $i
    for ((j=1; j<=10; j++))
    do
        sleep $(($long_time / 10))
        backup_unbound_log $filename
    done
    server_notify_to_bark "We got $(basename "$filename")"
done
wait_until X25519-ENG25519-END
server_print_status X25519-ENG25519 benchmark end
mecho

sleep $(($internel - 60))
start_unbound
# wait the client really start X25519
wait_until X25519
server_print_status X25519 benchmark start
for ((i=1; i<=${#cores[@]}; i++))
do
    printf -v filename "throughput/$current_time_path/X25519_dotc_%02d.txt" $i
    for ((j=1; j<=10; j++))
    do
        sleep $(($long_time / 10))
        backup_unbound_log $filename
    done
    server_notify_to_bark "We got $(basename "$filename")"
done
wait_until X25519-END
server_print_status X25519 benchmark end
mecho

sleep $(($internel - 60))
compile_eng25519_allopenssl
start_unbound_allopenssl
wait_until X25519-AllOpenSSL
server_print_status X25519-AllOpenSSL benchmark start
for ((i=1; i<=${#cores[@]}; i++))
do
    printf -v filename "throughput/$current_time_path/X25519_AllOpenSSL_dotc_%02d.txt" $i
    for ((j=1; j<=10; j++))
    do
        sleep $(($long_time / 10))
        backup_unbound_log $filename
    done
    server_notify_to_bark "We got $(basename "$filename")"
done
wait_until X25519-AllOpenSSL-END
server_print_status X25519-AllOpenSSL benchmark end
mecho

compile_eng25519_us
kill_unbound
server_notify_to_bark "ALL Done"
