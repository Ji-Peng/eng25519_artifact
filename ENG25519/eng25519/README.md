# eng25519

This ENGINE is developed based on [engntru](https://opensslntru.cr.yp.to/) (see paper "OpenSSLNTRU") and [libsuola](https://github.com/romen/libsuola) (see paper "Start Your ENGINEs: Dynamically Loadable Contemporary Crypto"). We reuse a lot of their template code regarding OpenSSL ENGINE APIs, but the backend providers are completely different from theirs.

The `eng25519` consists of our X25519/Ed25519 backend implementation (see `providers/batch_fast_lib` folder) and OpenSSL ENGINE template code.
This project also includes the implementation of our heuristic warm-up scheme.

```
.
├── cmake/                  // includes a script for finding OpenSSL-related headers and libraries
├── CMakeLists.sources      // source files for compiling this ENGINE
├── CMakeLists.txt          // CMake support
├── COPYING
├── COPYING.LESSER
├── debug/                  // useful utils for debugging
├── DESCRIPTION             // the description of eng25519
├── eng25519.c              // main file of eng25519
├── meths/                  // X25519/Ed25519-related interfaces for ENGINE
├── ossl/                   // includes the handling of error codes, OIDs, and compatibility
├── providers/              // our X25519/Ed25519 backend providers
├── README.md
├── test/                   // for correctness test
├── util/                   // the implementation of our heuristic warm-up scheme and a Perl script for generating error codes
└── VERSION                 // the version of eng25519
```

## Machine information

The machines for our benchmarks are obtained from Alibaba Cloud.\
The details of the machine are as follows.\
Family: Compute Optimized Type c7.\
Instance Type: ecs.c7.2xlarge.\
vCPUs: 8 vCPUs. Memory: 16 GiB.\
Internal Network Bandwidth: Up to 10Gbps.\
Physical Processor: Intel Xeon (Ice Lake) Platinum 8369B.

If you want to use other machines for testing, make sure they support AVX-512IFMA instructions; see [CPUs with AVX-512 from wikipedia](https://en.wikipedia.org/wiki/AVX-512#CPUs_with_AVX-512).

If you just want to reproduce the experimental results of the cryptographic performance part of the paper, one machine is enough.
If you want to reproduce the experimental results of the DoT (DNS over TLS) part of the paper as accurately as possible, you should rent two machines with the same configuration in an internal network. When you purchase two machines on Alibaba Cloud at the same time, they are often in an internal network.

Important Notice Regarding Ubuntu Versions:
We only recommend using Ubuntu 20.04 for reproducing experiments related to DNS over TLS (DoT). This is because we have observed exceptionally low throughput issues with the DoT server `unbound` on newer versions of Ubuntu. For more details, please refer to [unbound-issues-1045](https://github.com/NLnetLabs/unbound/issues/1045).

## Compile and test `eng25519`

In the following, we will install OpenSSL into a custom directory (i.e., `$ENG25519_PREFIX` path) and we will tell `CMake` to search that path for OpenSSL headers and libraries. Our `eng25519` project is placed into the `/root/` path and we use absolute path in some commands (e.g., `/root/eng25519/test/eng25519.cnf`). Therefore, you should modify those commands according to the path on your machine. Note that we use the `root` user when doing these experiments. If you use a normal user, you may encounter permission issues (such as when using port 853).

```bash
### <Step 1: Prerequisites>
sudo apt install -y git wget build-essential cmake pkg-config flex byacc libexpat-dev
# The openssl will be installed into this path. CMake will find related headers and libraries from this path.
export ENG25519_PREFIX=$HOME/local-eng25519
# Bash will find the openssl executable tool from this path.
export PATH=$ENG25519_PREFIX/bin:$PATH
### </Step 1: Prerequisites>

### <Step 2: Install OpenSSL>
cd
# We use the openssl-1.1.1q, which contains the x86-64 assembly implementation of X25519.
wget https://www.openssl.org/source/openssl-1.1.1q.tar.gz
tar -xf openssl-1.1.1q.tar.gz
cd openssl-1.1.1q
./config shared --prefix=$ENG25519_PREFIX --openssldir=$ENG25519_PREFIX -Wl,-rpath=$ENG25519_PREFIX/lib
make update
make -j4
make test
make install_sw
### </Step 2: Install OpenSSL>

### <Step 3: Compile and install eng25519>
# Assume that we are in the eng25519 path.
mkdir build
cd build
# CMAKE_PREFIX_PATH: Cmake will search OpenSSL-related files from the specified path.
# Use -Dprovider="batch_fast_lib" for ENG25519 configuration and -Dprovider="openssl_lib" for ALL_OpenSSL configuration.
cmake -DCMAKE_BUILD_TYPE=Release -Dprovider="batch_fast_lib" -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" ..
make && make install
### </Step 3: Compile and install eng25519>

### <Step 4: Some tests>
# A simple test using our engine
openssl engine -vvv -c -t eng25519
# A correctness test of x25519
env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" ./evp_test /root/eng25519/test/rfc7748.txt
# A correctness test of ed25519
env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" ./evp_test /root/eng25519/test/gnugpg_t-ed25519.txt
### </Step 4: Some tests>
```

## Cryptographic performance reproduction

There are two methods to measure the performance of cryptographic operations.

### 1. Using [OpenSSL speed apps](https://www.openssl.org/docs/man1.1.1/man1/openssl-speed.html)

```bash
# A performance test of our x25519 using OpenSSL speed apps
env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" openssl speed -engine eng25519 ecdhx25519
# A performance test of our ed25519 using OpenSSL speed apps
env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" openssl speed -engine eng25519 eddsa
```

For comparison with the X25519/Ed25519 implementation in OpenSSL.
```bash
openssl speed ecdhx25519
openssl speed eddsa
```

The results reported by OpenSSL speed apps only involve the number of executions per second. The CPU cycle counts are not reported.

### 2. Using `Curve25519_AVX512IFMA` project

To get detailed performance results including CPU cycles, see `Curve25519_AVX512IFMA` project.

## Raw experimental results of TLS handshake and DoT query

See `eng25519-results` for the raw experimental results (of Section 4 in our paper) and corresponding auxiliary processing script.

## Regarding the heuristic warm-up scheme

Our heuristic warm-up scheme is implemented by `util/heuristic_warmup.c` and the corresponding executable program is `heuristic_warmup`.
In our case, `unbound` prints statistical information to the `/var/log/syslog` file every 60 seconds, with each record resembling the following.
```
Apr 20 11:45:00 localhost unbound: [120655:0] info: server stats for thread 0: 110000 queries, 0 answers from cache, 0 recursions, 0 prefetch, 0 rejected by ip ratelimiting
```

Our `heuristic_warmup` continuously searches for the latest record from this file, determines whether it is outdated, extracts the number of DoT requests received by `unbound` within 60 seconds, and performs the wake-up action based on this information.
Because `heuristic_warmup` relies on the statistical information reported by unbound, the wake-up action may be delayed at startup due to the need to wait for unbound to report.

In the reproduction process below, we recommend using `util/timer_warmup.c`, corresponding to `timer_warmup` program, which performs the wake-up action every 500 microseconds.
Of course, if you insist on using `heuristic_warmup` for the reproduction below, it is also possible. However, you need to manually discard the data generated in the first minute after startup to avoid the aforementioned wake-up delay.
In the following text, we use `timer_warmup` by default.

Intel CPUs commonly support hyper-threading technology, wherein two logical threads can run on one physical core, with independent registers but shared execution units. Our auxiliary threads utilize this technology.
The usage pattern of our auxiliary thread is as following.
```
taskset -c 1 timer_warmup &
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" openssl s_server -port 853 -cert ed25519.pem -key ed25519.key -tls1_3 -quiet
```
We bind the auxiliary thread to `thread 1` while binding the TLS or DoT server to `thread 0`. Note that threads 0 and 1 are hyper-threads that reside on the same physical core. Computing activities carried out by the auxiliary thread are minimal and have a negligible impact on the physical core's execution unit allocation. Moreover, by executing a vector instruction to initiate a wakeup action, the auxiliary thread can warm up the vector unit of the physical core, thereby mitigating the cold-start problem associated with another hyper-thread.

## TLS handshake performance reproduction

Please install `dot_timer` and `tls_timer` before following the steps below; see `DoT_timer` project.

We use two machines for the benchmark of TLS handshakes. The first machine is the `client` used for sending TLS handshake requests. The second machine is the `server` used for parsing and responding to client requests. On the `server` side we use [openssl s_server](https://www.openssl.org/docs/man1.1.1/man1/openssl-s_server.html) as the TLS handshake server. On the `client` side we use `tls_timer` as the TLS handshake client.

Two backend providers of the `eng25519` project are involved, i.e., `batch_fast_lib` and `openssl_lib`.
The backend cryptographic provider `batch_fast_lib` adopts our 8x1-way X25519-KeyGen, Hisil et al. 1x4-way X25519-Derive, our 1x8-way Ed25519-Sign, and our 1x2-way Ed25519-Verify.
The backend cryptographic provider `openssl_lib` adopts X25519/Ed25519 implementation from OpenSSL project for knowing the impact of the OpenSSL ENGINE APIs.
In our paper, there are four configurations (see Figure 3). Let's reproduce them one by one.

Regarding the files and environment variables that will be used in the following commands.
- `eng25519.cnf`: The configuration file used by OpenSSL. This file is placed in the `eng25519/test` path.
- `ed25519.pem`: The certificate file used by the `server`. This file is placed in the `eng25519/test` path.
- `ed25519.key`: The private key corresponding to the certificate. This file is placed in the `eng25519/test` path.
- `PEER_LOCAL_AD`: The IP address of the `server`. You can set it using `export PEER_LOCAL_AD=xx.xx.xx.xx` command on ubuntu where `xx.xx.xx.xx` is the IP address of the `server`.

### 1. `P256`

On the `server` side.
```bash
# Assume that we are in the eng25519 path
cd test
taskset -c 0 openssl s_server -port 853 -cert ed25519.pem -key ed25519.key -tls1_3 -quiet
```

On the `client` side.
```bash
for i in {1..100}; do taskset -c 0 tls_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups P-256 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> server_p256.txt; done
```

### 2. `X25519`

On the `server` side.
```bash
# Assume that we are in the eng25519/test path
taskset -c 0 openssl s_server -port 853 -cert ed25519.pem -key ed25519.key -tls1_3 -quiet
```

On the `client` side.
```bash
for i in {1..100}; do taskset -c 0 tls_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> server_x25519.txt; done
```

### 3. `ENG25519`

On the `server` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="batch_fast_lib"` before running the following commands.
```bash
# Assume that we are in the eng25519/test path
# Start our auxiliary thread. The program timer_warmup is installed into /usr/local/bin path on our machine.
taskset -c 1 timer_warmup &
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" openssl s_server -port 853 -cert ed25519.pem -key ed25519.key -tls1_3 -quiet
```

On the `client` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="batch_fast_lib"` before running the following commands.
```bash
for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" tls_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> server_swarm_ccold.txt; done
```

It is essential to terminate not only the TLS server (i.e. `openssl s_server`) after performing the above steps but also our auxiliary thread (i.e. `timer_warmup`).

### 4. `ALL-OpenSSL`

On the `server` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="openssl_lib"` before running the following commands.
```bash
# Assume that we are in the eng25519 path
cd test
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" openssl s_server -port 853 -cert ed25519.pem -key ed25519.key -tls1_3 -quiet
```

On the `client` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="openssl_lib"` before running the following commands.
```bash
for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" tls_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> server_all_openssl.txt; done
```

Now you should obtain four files, i.e., `server_p256.txt`, `server_x25519.txt`, `server_swarm_ccold.txt`, and `server_all_openssl.txt`, where each line looks like: 
```json
{ "connections": 10000, "wallclock_usec": 7386729, "key_type": "X25519", "key_bits": 253 }.
```
You can use these files to plot the cumulative distribution of TLS handshakes (i.e., Figure 3 in our paper).

## DNS over TLS (DoT) query performance reproduction

Please install `dot_timer` and `tls_timer` before following the steps below; see `DoT_timer` project.

We use two machines for the benchmark of DoT queries. The first machine is the `client` used for sending DoT queries. The second machine is the `server` used for parsing and responding to client queries. On the `server` side we use [unbound](https://github.com/NLnetLabs/unbound) as the DoT server. On the `client` side we use `DoT_timer` as the DoT client.

Two backend providers of the `eng25519` project are involved, i.e., `batch_fast_lib` and `openssl_lib`. In our paper, there are four configurations (see Figure 3). Let's reproduce them one by one.

Regarding the files and environment variables that will be used in the following commands.
- `eng25519.cnf`: The configuration file used by OpenSSL. This file is placed in the `eng25519/test` path.
- `unbound.conf`: The configuration file used by `unbound`. This file is placed in the `eng25519/test` path. Note that you need to modify the `tls-service-key` and `tls-service-pem` options according to your file path.
- `PEER_LOCAL_AD`: The IP address of the `server`. You can set it using `export PEER_LOCAL_AD=xx.xx.xx.xx` command on ubuntu where `xx.xx.xx.xx` is the IP address of the `server`.

See [unbound](https://github.com/NLnetLabs/unbound) for the compilation and installation of `unbound`. During the configuration phase of `unbound` you can use the command `./configure --with-ssl=/root/local-eng25519` to specify the OpenSSL installation path.
Note that you should `kill` `unbound`'s main process before restarting `unbound`. The command `ps -aux | grep unbound` may be helpful.

### 1. `P256`

On the `server` side.
```bash
taskset -c 0 unbound -c /root/eng25519/test/unbound.conf
```

On the `client` side.
```bash
for i in {1..100}; do taskset -c 0 dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups P-256 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> unbound_p256.txt; done
```

### 2. `X25519`

On the `server` side.
```bash
taskset -c 0 unbound -c /root/eng25519/test/unbound.conf
```

On the `client` side.
```bash
for i in {1..100}; do taskset -c 0 dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> unbound_x25519.txt; done
```

### 3. `ENG25519`

On the `server` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="batch_fast_lib"` before running the following commands.
```bash
# Assume that we are in the eng25519/test path
# Start our auxiliary thread. The program timer_warmup is installed into /usr/local/bin path on our machine.
taskset -c 1 timer_warmup &
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
```

On the `client` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="batch_fast_lib"` before running the following commands.
```bash
for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> unbound_swarm_ccold.txt; done
```

It is essential to terminate not only the DoT server (i.e. `unbound`) after performing the above steps but also our auxiliary thread (i.e. `timer_warmup`).

### 4. `ALL-OpenSSL`

On the `server` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="openssl_lib"` before running the following commands.
```bash
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
```

On the `client` side, you should finish the `<Step3: Compile and install eng25519>` with `-Dprovider="openssl_lib"` before running the following commands.
```bash
for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> unbound_all_openssl.txt; done
```

Now you should obtain four files, i.e., `unbound_p256.txt`, `unbound_x25519.txt`, `unbound_swarm_ccold.txt`, and `unbound_all_openssl.txt`, where each line looks like: 
```json
{ "connections": 10000, "wallclock_usec": 10193472, "key_type": "X25519", "key_bits": 253 }.
```
You can use these files to plot the cumulative distribution of DoT queries (i.e., Figure 3 in our paper).

## DNS over TLS (DoT) query peak throughput reproduction

This test is rather complex. To establish a basic understanding, let's briefly describe the fundamental steps of the test: For different ENG25519 configurations, the client needs to start the DoT Timer to continuously send query requests to the server. To explore how many clients can maximize the server throughput, we incrementally increase the number of clients. For example, we start with one client executing a 102-minute test and then steadily increase the client count. Consequently, the entire testing process is time-consuming. For convenience, we've developed some Bash scripts to assist in these tests.

Our helper scripts come in two versions, namely V1 and V2.
- V1: `util/dot_bench_client_v1.sh, util/dot_bench_server_v1.sh, util/utils_v1.sh`
- V2: `util/dot_bench_client_v2.sh, util/dot_bench_server_v2.sh, util/utils_v2.sh`
- These three files represent scripts executed on the client, scripts executed on the server, and configuration variables along with auxiliary functions.

For the V1 version, we incrementally increase the client count to determine how many clients can maximize the server throughput. After obtaining the corresponding client count, we proceed with more comprehensive testing using the V2 version.

It's important to note that these scripts are not plug-and-play; you need to make minor modifications. The main modifications are concentrated in `utils_v1.sh` and `utils_v2.sh`, where variables such as `start_time, client_user, client_ip, client_port` must be adjusted based on your testing goals and different client-server configurations.

To help you better understand the working principles of our helper scripts, let's briefly describe their design logic:
We specify the script's start time in the `start_time` variable; both the client and server will wait until the specified time. When the client starts executing, it writes a simple command, such as the string `P256`, to a file. This signals to the server that we are conducting tests corresponding to the `P256` configuration, and the server can start running the relevant commands upon reading this command. After the client completes the required tests, it writes a command to the control file, such as `P256-END`, indicating to the server that we have finished testing the `P256` configuration, and so forth. After completing the testing for a particular configuration, the server's helper script backs up the log files generated by unbound, facilitating subsequent throughput statistics.

## Regarding the cold-start performance of cryptographic primitives in DoT scenario

Let's reproduce the cold start performance of the cryptographic primitives (in Table 6 of our paper) under the DoT scenario. First, you need to recompile and reinstall `eng25519` with different compilation options.

```bash
### <Recompile and reinstall eng25519>
cd eng25519/build
# CMAKE_PREFIX_PATH: Cmake will search OpenSSL-related files from the specified path.
cmake -DCMAKE_BUILD_TYPE=Release -Dprovider="batch_fast_lib" -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" -DPRINT_CC=1 ..
make && make install
### </Recompile and reinstall eng25519>
```

Note that we use the `-DPRINT_CC` option when executing the `cmake` command; this option defines the `PRINT_CC` macro at compile time, enabling the report of CPU cycles (cc) under cold start conditions.

Then rerun the DoT query test.

On the `server` side.
```bash
taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
```

On the `client` side.
```bash
for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> temp.txt; done
```

Then, in the path where you ran the commands on both of the `server` and `client`, you will get the `eng25519.log` file, which reports CPU cycles under cold start conditions.

The raw experimental data required to reproduce Table 6 of our paper is located in the `eng25519-results/cc_unbound` directory. It includes four files: `c_unbound.txt`, `c_unbound_helper.txt`, `s_unbound.txt`, and `s_unbound_helper.txt`. Here, `c_` indicates the log generated by ENG25519 when running `dot_timer` on the client, `s_` indicates the log generated by ENG25519 when running `unbound` on the server, and `helper` indicates the experiment with an auxiliary thread for the client or server.

To obtain the aforementioned four files, the following experimental steps should be performed:

1. Recompile eng25519 on both the client and server with the `-DPRINT_CC` option.
2. Ensure `unbound` and `timer_warmup` are killed before running the server. Start the server without an auxiliary thread and start the client without an auxiliary thread.
3. This will generate `c_unbound.txt` and `s_unbound.txt`.
4. Ensure `unbound` and `timer_warmup` are killed before running the server. Restart the server with an auxiliary thread and restart the client with an auxiliary thread. Starting the server/client with the auxiliary thread means first running the command `taskset -c 1 timer_warmup &` and then starting the server/client.
5. This will generate `c_unbound_helper.txt` and `s_unbound_helper.txt`.

Once you have obtained these four files, you can reproduce Table 6 using `cc.ipynb`.

## Regarding the selection of X25519-KeyGen batch size

Table 7 in our paper presents the amortized overhead of X25519-KeyGen with different batch sizes. The original experimental data is located in the `eng25519-results/batch_keygen` directory. Here, `s_` indicates that the data was obtained from testing on the server side, and `_helper` indicates that an auxiliary thread was used.

Since these data were obtained during development, reproducing them requires slight modifications to the source code.

The definition `#define X25519_KEYGEN_BATCH_NUM 16` in `ENG25519/eng25519/providers/batch_fast_lib/batch.c` sets the batch size to 16.

To reproduce the data in `batch_keygen`, modify the batch size on the server side, recompile eng25519, and restart unbound with/without the auxiliary thread. Any client configuration can be used, as we only need to collect logs on the server.

### Reproducing `s_b1.txt`

1. Modify the batch size to 1.

   Change the batch size to 1 in `ENG25519/eng25519/providers/batch_fast_lib/batch.c`:

   ```c
   #define X25519_KEYGEN_BATCH_NUM 1
   ```

   Optional: Comment out lines 68-72 in `ENG25519/eng25519/meths/eng25519_x25519_meth.c`, lines 123-127 and 162-166 in `ENG25519/eng25519/meths/eng25519_ed25519_meth.c` to avoid printing overhead for other cryptographic primitives.

2. Recompile and reinstall eng25519 on the server with `-DPRINT_CC=1`.

   ```bash
   ### <Recompile and reinstall eng25519>
   cd eng25519/build
   # CMAKE_PREFIX_PATH: Cmake will search OpenSSL-related files from the specified path.
   cmake -DCMAKE_BUILD_TYPE=Release -Dprovider="batch_fast_lib" -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" -DPRINT_CC=1 ..
   make && make install
   ### </Recompile and reinstall eng25519>
   ```

3. Ensure `unbound` and `timer_warmup` are killed before running the server.

4. Run the server.

   ```bash
   taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" unbound -c /root/eng25519/test/unbound.conf
   ```

5. Run the client.

   ```bash
   for i in {1..100}; do taskset -c 0 env OPENSSL_CONF="/root/eng25519/test/eng25519.cnf" dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2 >> temp.txt; done
   ```

6. The content of `eng25519.log` in the `unbound` running path on the server is the content of `s_b1.txt`.

### Reproducing `s_b1_helper.txt`

Most steps are the same as reproducing `s_b1.txt`. The only difference is to start the auxiliary thread using `taskset -c 1 timer_warmup &` before running `unbound`.
