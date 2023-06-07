dotc_num=0
# big enough for benchmark
dot_query_num=5000000000
# 102 minutes
long_time=$((32*60))
# When will the benchmark start
start_time="2023-06-07 15:43:00"
start_time_p256=
end_time_p256=
start_time_x25519=
end_time_x25519=
start_time_x25519_eng25519=
end_time_x25519_eng25519=
start_time_x25519_AllOpenSSL=
end_time_x25519_AllOpenSSL=
# the id of cores
cores=(0 2 4 6 8 10 12 14 1 3 5 7 9 11 13 15)
# internel time between two different benchmark
internel=$((5*60))
# unbound always outputs its log to /var/log/syslog
unbound_log=/var/log/syslog
client_user=root
client_ip=$AL_2
client_port=222
current_time_path=$(date +"%Y-%m-%d-%H")
# cmake output log file
cmake_log_us="/root/eng25519_test/log/$current_time_path/cmake_out_eng25519.txt"
cmake_log_allopenssl="/root/eng25519_test/log/$current_time_path/cmake_out_allopenssl.txt"

# for debug
if (( 0 )); then
    long_time=120
    internel=120
fi

mecho() {
    echo -e "$*" >> log/$current_time_path/dot_bench.log
}

server_notify_to_bark() {
    content=$(echo "$*" | sed 's/\\n/%0a/g')
    curl -s -X GET https://api.day.app/86FBv5LaNpuni4MPaFpaVm/"DoT-benchmark Server"/"${content}"?group=DoT-"$current_time_path" &>/dev/null &
}

client_notify_to_bark() {
    content=$(echo "$*" | sed 's/\\n/%0a/g')
    # curl -s -X GET https://api.day.app/86FBv5LaNpuni4MPaFpaVm/"DoT-benchmark Clients"/"${content}"?group=DoT-"$current_time_path" &>/dev/null &
}

server_print_status() {
    output=""
    current_time=$(date +"%Y-%m-%d %H:%M:%S")
    output+="$current_time $*\n"
    # \\n for pushing the message to bark
    ps_out=$(ps -aux | awk '$11 ~ /^unbound/ {count++; printf "%-2d %-10s %-15s\\n", count, $2, $9}')
    if [[ -n "$ps_out" ]]; then
        # \\\\n for pushing the message to bark
        printf -v header_awk "%-2s %-10s %-15s\\\\n" "ID" "PID" "START-TIME"
        output+="$header_awk"
        output+="$ps_out"
    fi
    mecho "$output"
    server_notify_to_bark "$output"
}

client_print_status() {
    output=""
    current_time=$(date +"%Y-%m-%d %H:%M:%S")
    output+="$current_time, the number of DoT clients should be: $dotc_num; $*\n"
    # \\n for pushing the message to bark
    ps_out=$(ps -aux | awk '$11 ~ /dot_timer/ {count++; printf "%-2d %-10s %-15s\\n", count, $2, $9}')
    if [[ -n "$ps_out" ]]; then
        # \\\\n for pushing the message to bark
        printf -v header_awk "%-2s %-10s %-15s\\\\n" "ID" "PID" "START-TIME"
        output+="$header_awk"
        output+="$ps_out"
    fi
    mecho "$output"
    client_notify_to_bark "$output"
}

kill_unbound() {
    # kill unbound thread(s)
    ps -aux | awk '$11 ~ /unbound/ {print $2}' | xargs -r kill
    # kill timer_warmup thread
    ps -aux | awk '$11 ~ /timer_warmup/ {print $2}' | xargs -r kill
}

kill_dotcs() {
    # kill all of the dot clients
    ps -aux | awk '$11 ~ /dot_timer/ {print $2}' | xargs -r kill
}

start_unbound() {
    kill_unbound
    taskset -c 0 unbound -c /root/eng25519/test/unbound.conf
}

start_unbound_eng25519() {
    kill_unbound
    # warmup
    taskset -c 1 timer_warmup &
    taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
}

start_unbound_allopenssl() {
    kill_unbound
    taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
}

dot_timer_p256() {
    if [[ $# -ne 1 ]]; then
        mecho "dot_timer_p256 parameter error"
        return
    fi
    current_time=$(date +"%Y-%m-%d_%H-%M-%S")
    taskset -c $1 \
    dot_timer -bomb -n $dot_query_num -connect $PEER_LOCAL_AD:853 \
    -sigalgs ed25519 -client_sigalgs ed25519 -groups P-256 \
    -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> log/$current_time_path/dot_bench.log &
}

dot_timer_X25519() {
    if [[ $# -ne 1 ]]; then
        mecho "dot_timer_X25519 parameter error"
        return
    fi
    current_time=$(date +"%Y-%m-%d_%H-%M-%S")
    taskset -c $1 \
    dot_timer -bomb -n $dot_query_num -connect $PEER_LOCAL_AD:853 \
    -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 \
    -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> log/$current_time_path/dot_bench.log &
}

dot_timer_X25519_ENGINE() {
    if [[ $# -ne 1 ]]; then
        mecho "dot_timer_X25519 parameter error"
        return
    fi
    current_time=$(date +"%Y-%m-%d_%H-%M-%S")
    taskset -c $1 \
    env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" \
    dot_timer -bomb -n $dot_query_num -connect $PEER_LOCAL_AD:853 \
    -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 \
    -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> log/$current_time_path/dot_bench.log &
}

# usage: sleep_until "2023-06-03 10:00:00" or sleep_until "${start_time}"
sleep_until() {
    target_timestamp=$(date -d "$1" +%s)
    current_timestamp=$(date +%s)
    delay_seconds=$((target_timestamp - current_timestamp))
    if (( delay_seconds < 0 )); then
        echo "delay seconds < 0, the time you set seems bad ^_^!"
        exit
    fi
    mecho "I'm sleeping until $1, see you $delay_seconds seconds later ^~^!"
    sleep $delay_seconds
    mecho
}

# usage: X25519_bench_start_time=$(time_add_seconds "${start_time}" "$((60*60))")
time_add_seconds() {
    base_time="$1"
    seconds="$2"
    base_timestamp=$(date -d "$base_time" +"%s")
    final_timestamp=$((base_timestamp + seconds))
    final_time=$(date -d "@$final_timestamp" +"%Y-%m-%d %H:%M:%S")
    echo "$final_time"
}

# backup log file
server_backup_log_file() {
    mkdir -p log
    mkdir -p log/$current_time_path
    # if no this file, create it
    touch log/$current_time_path/dot_bench.log

    # backup the syslog file
    cat ${unbound_log} >> log/$current_time_path/syslog.bak
    # clear the syslog file
    > ${unbound_log}

    mkdir -p throughput
    mkdir -p throughput/$current_time_path
    for ((i=1; i<=${#cores[@]}; i++))
    do
        printf -v filename_P256 "throughput/$current_time_path/P256_dotc_%02d.txt" $i
        printf -v filename_X25519 "throughput/$current_time_path/X25519_dotc_%02d.txt" $i
        printf -v filename_X25519_ENG25519 "throughput/$current_time_path/X25519_ENG25519_dotc_%02d.txt" $i
        printf -v filename_X25519_AllOpenSSL "throughput/$current_time_path/X25519_AllOpenSSL_dotc_%02d.txt" $i
        > ${filename_P256}
        > ${filename_X25519}
        > ${filename_X25519_ENG25519}
        > ${filename_X25519_AllOpenSSL}
    done
}

# backup log file
client_backup_log_file() {
    mkdir -p log
    mkdir -p log/$current_time_path
    # if no this file, create it
    touch log/$current_time_path/dot_bench.log
    # create file
    > control_server
}

backup_unbound_log() {
    cat ${unbound_log} >> $1
    > ${unbound_log}
}

# compute and print the timeline
print_timeline() {
    output=""
    start_time_p256=${start_time}
    output+="The start time of P256 benchmark: ${start_time_p256}\n"
    end_time_p256=$(time_add_seconds "${start_time_p256}" "$((${#cores[@]}*${long_time}))")
    output+="The end time of P256 benchmark: ${end_time_p256}\n\n"

    start_time_x25519_eng25519=$(time_add_seconds "${end_time_p256}" "$internel")
    output+="The start time of X25519-ENG25519 benchmark: ${start_time_x25519_eng25519}\n"
    end_time_x25519_eng25519=$(time_add_seconds "${start_time_x25519_eng25519}" "$((${#cores[@]}*${long_time}))")
    output+="The end time of X25519-ENG25519 benchmark: ${end_time_x25519_eng25519}\n\n"

    start_time_x25519=$(time_add_seconds "${end_time_x25519_eng25519}" "$internel")
    output+="The start time of X25519 benchmark: ${start_time_x25519}\n"
    end_time_x25519=$(time_add_seconds "${start_time_x25519}" "$((${#cores[@]}*${long_time}))")
    output+="The end time of X25519 benchmark: ${end_time_x25519}\n\n"

    start_time_x25519_AllOpenSSL=$(time_add_seconds "${end_time_x25519_eng25519}" "$internel")
    output+="The start time of X25519-AllOpenSSL benchmark: ${start_time_x25519_AllOpenSSL}\n"
    end_time_x25519_AllOpenSSL=$(time_add_seconds "${start_time_x25519_AllOpenSSL}" "$((${#cores[@]}*${long_time}))")
    output+="The end time of X25519-AllOpenSSL benchmark: ${end_time_x25519_AllOpenSSL}\n"
    
    mecho $output
    client_notify_to_bark $output
}

# compile eng25519 with our optimized implementation
compile_eng25519_us() {
    original_dir=$(pwd)
    cd; cd eng25519
    rm -rf build; mkdir build; cd build
    cmake -DCMAKE_BUILD_TYPE=Release -Dprovider="batch_fast_lib" -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" .. &> ${cmake_log_us}
    make &>> ${cmake_log_us}
    make install &>> ${cmake_log_us}
    cd "$original_dir"
}

# compile eng25519 with all openssl implementation
compile_eng25519_allopenssl() {
    original_dir=$(pwd)
    cd; cd eng25519
    rm -rf build; mkdir build; cd build
    cmake -DCMAKE_BUILD_TYPE=Release -Dprovider="openssl_lib" -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" .. &> ${cmake_log_allopenssl}
    make &>> ${cmake_log_allopenssl}
    make install &>> ${cmake_log_allopenssl}
    cd "$original_dir"
}

wait_until() {
    while true; do
        message=$(ssh $client_user@$client_ip -p $client_port 'cat /root/eng25519_test/control_server')
        if [ "$message" = "$*" ]; then
            break
        fi
        sleep 5
    done
}

write_command() {
    echo "$*" > control_server
}