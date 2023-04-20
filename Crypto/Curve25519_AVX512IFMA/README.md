# Curve25519_AVX512IFMA

This project is developed based on the [source code](https://gitlab.uni.lu/APSIA/AVXECC) of the paper "High-Throughput Elliptic Curve Cryptography Using AVX2 Vector Instructions".

## Machine information

The machines for our benchmarks are obtained from Alibaba Cloud.

The details of the machine are as follows.\
Family: Compute Optimized Type c7. \
Instance Type: ecs.c7.2xlarge. \
vCPUs: 8 vCPUs. Memory: 16 GiB. \
Internal Network Bandwidth: Up to 10Gbps.\
Physical Processor: Intel Xeon(Ice Lake) Platinum 8369B.

If you want to use other machines for testing, make sure they support AVX-512IFMA instructions; see [CPUs with AVX-512 from wikipedia](https://en.wikipedia.org/wiki/AVX-512#CPUs_with_AVX-512).

If you just want to reproduce the experimental results of the cryptographic performance of the paper, one machine is enough.
If you want to reproduce the experimental results of the DoT (DNS over TLS) of the paper as accurately as possible, you should rent two machines with the same configuration in an internal network. When you purchase two machines on Alibaba Cloud at the same time, they are often in an internal network.

## Reproduction

Note that we use OpenSSL for computing SHA512, so we need to install OpenSSL before building the project. On Ubuntu, the command `sudo apt install libssl-dev` can be used to install OpenSSL, but we do not recommend doing so. Our experiment is based on `openssl 1.1.1q`, so we recommend following the steps below to install OpenSSL.

```bash
### <Step 1: Prerequisites>
sudo apt install -y git wget build-essential cmake pkg-config
# The openssl will be installed into this path. CMake will find related headers and libraries from this path.
export ENG25519_PREFIX=$HOME/local-eng25519
# Bash will find the openssl executable tool from this path.
export PATH=$ENG25519_PREFIX/bin:$PATH
### </Step 1: Prerequisites>

### <Step 2: Install OpenSSL>
cd
# We use the latest openssl-1.1.1q, which contains the x86-64 assembly implementation of X25519.
wget https://www.openssl.org/source/openssl-1.1.1q.tar.gz
tar -xf openssl-1.1.1q.tar.gz
cd openssl-1.1.1q
./config shared --prefix=$ENG25519_PREFIX --openssldir=$ENG25519_PREFIX -Wl,-rpath=$ENG25519_PREFIX/lib
make update
make -j4
make test
make install_sw
### </Step 2: Install OpenSSL>

### <Step 3: Build this project>
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" ..
make
./benchmark
### </Step 3: Build this project>
```

You will get the performance results of our optimized implementation using AVX-512IFMA and the OpenSSL implementation using x86-64 assembly language.