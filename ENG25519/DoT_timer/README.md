# `DoT_timer`: a benchmark tool for DNS over TLS (DoT) queries

This tool is developed based on [tls_timer](https://opensslntru.cr.yp.to/tls_timer-20210608.tar.gz) which was proposed in [OpenSSLNTRU project](https://opensslntru.cr.yp.to/).
See [tls_timer](https://opensslntru.cr.yp.to/tls_timer-20210608.tar.gz) for the main design ideas.

The main difference between `dot_timer` and `tls_timer` is that after the TLS connection is successfully established:
- the `tls_timer` will directly close this connection.
- the `dot_timer` will send a DoT query request, receive the corresponding response, and then close the connection.

The file `DoT_timer.c` is the source code of `dot_timer` and `tls_timer.c` is the source code of `tls_timer`.

## Installation

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

### <Step 3: Build and install dot_timer and tls_timer>
cd DoT_timer
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="${ENG25519_PREFIX}" ..
make && make install
### </Step 3: Build and install dot_timer and tls_timer>
```

We can run `dot_timer` or `tls_timer` with `OpenSSL` command line configurations; see [SSL_CONF_cmd](https://www.openssl.org/docs/man1.1.1/man3/SSL_CONF_cmd.html) for the details about `OpenSSL` command line configurations.

The basic usage in this work is as follows:
```bash
dot_timer -n 10000 -connect $PEER_LOCAL_AD:853 -sigalgs ed25519 -client_sigalgs ed25519 -groups X25519 -no_ssl3 -no_tls1 -no_tls1_1 -no_tls1_2
```
where `$PEER_LOCAL_AD:853` is the IP address of the peer and the corresponding port.
