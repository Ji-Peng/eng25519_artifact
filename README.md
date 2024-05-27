# ENG25519 Artifact

This is the artifact of the paper titled ["ENG25519: Faster TLS 1.3 handshake using optimized X25519 and Ed25519"](https://ji-peng.github.io/uploads/usenix_security2024/paper.pdf), which has been accepted to [Usenix Security 2024](https://www.usenix.org/conference/usenixsecurity24/). There are three subfolders included in this repository:
- `Crypto/`: This folder focuses on cryptographic implementations without OpenSSL ENGINE related code, i.e. the reported results in Section 3 of our paper. If you wish to reproduce the cryptographic performance under warm-start conditions, please refer to the projects in this folder.
  - `Curve25519_AVX512IFMA`: This project contains the optimized X25519/Ed25519 implementations using AVX-512IFMA as presented in this paper, and the X25519/Ed25519 implementations using x86-64 assembly language in OpenSSL. Further details on this project can be found in the `README.md` file.
  - `Hisil_AVX512`: This project contains the implementation of Hisil et al's X25519-Derive, which computes the shared secret for communicating parties. The original implementation by Hisil et al. could not run on our machine, so we modified it. Further details on this project can be found in the `README.md` file.
  - Note: In addition to the above two projects, the Table 2 in the paper also includes comparisons with Faz-H et al, Nath et al, and Cheng et al implementations. These projects are readily available for compilation and execution, therefore, we did not include copies of their implementations. Further details on these projects and implementing the comparisons can be found in the following links: [Faz-H et al. project](https://github.com/armfazh/fld-ecc-vec), [Nath et al. project](https://github.com/kn-cs/vec-ladder), and [Cheng et al. project](https://gitlab.uni.lu/APSIA/AVXECC).
- `ENG25519/`: This folder contains several projects to reproduce the TLS handshake and DNS over TLS (DoT) results presented in Section 4 of our paper.
  - `DoT_timer`: This project contains two tools, `tls_timer` for measuring the performance of TLS 1.3 handshakes, and `dot_timer` for measuring the performance of DNS over TLS (DoT) queries. Further details on this project can be found in the `README.md` file.
  - `eng25519`: This project implements the `eng25519` ENGINE of this paper, corresponding to the `ENG25519` legend in the Figure 3 of the paper. When building this project, two cryptographic backend providers are available: `batch_fast_lib` (the optimized implementation presented in this paper) and `openssl_lib` (the cryptographic implementation in OpenSSL). This project also includes the implementation of our heuristic warm-up scheme. Further details on this project can be found in the `README.md` file.
  - `eng25519-results`: This project contains the raw experimental data for the TLS 1.3 handshake and DoT queries. Further details on this project can be found in the `README.md` file.
- `Verify/`: This project formally verifies the finite field implementation of this paper using the `CryptoLine` toolkit. Further details on this project can be found in the `README.md` file.

