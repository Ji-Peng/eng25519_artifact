# Verify_Curve25519IFMA

This project verifies the correctness of finite field implementation of X25519 and Ed25519 in Curve25519_AVX512IFMA project using the [CryptoLine toolkit](https://github.com/fmlab-iis/cryptoline). The Curve25519_AVX512IFMA project is a high-performance implementation of the X25519 and Ed25519 with AVX-512IFMA instructions.

In the context of formal verification for cryptographic programs, two approaches are commonly used. The first approach adopts the correct-by-construction method to generate a correct implementation, such as HACL, Jasmin, and Fiat, while the second approach uses formal verification tools to assess the correctness of the existing programs, such as CryptoLine-related work (see papers "Signed cryptographic program verification with typed cryptoline" and Verifying arithmetic in cryptographic C programs).

The main purpose of this work is to optimize the implementation of ECC arithmetic using assembly or Intel inline assembly languages with subsequent verification of the implementation. To fulfill this purpose, we utilize the CryptoLine tool that is intended for verifying the underlying arithmetic implementations in cryptographic primitives, including the finite field implementation of ECC and the polynomial multiplication implementation of post-quantum cryptography (PQC).

Our verification focuses on finite field implementation, excluding point arithmetic and scalar multiplication. There are a couple of reasons for this decision. First, the CryptoLine toolkit does not support verifying the implementation of point arithmetic and scalar multiplication automatically or semi-automatically. Second, it is more challenging to manually review the lower-level finite field implementation than point arithmetic and scalar multiplication. Therefore, we ensured the correctness of the finite field implementation via formal verification and reduced the likelihood of errors in point arithmetic and scalar multiplication by manual review and testing against known results.

We verify both the computational and input-output range correctness of our finite field implementation. The first step of the verification using the CryptoLine toolkit is to extract execution traces by running the programs in the GDB debugger environment, using the `itrace.py` script. The extracted traces are saved to a file with the suffix `gas`. We manually define translation rules and then translate the assembly instructions in the `gas` file to CryptoLine language with the `to_zdsl.py` script. Then, we obtain a file with the suffix `cl`. We also need to edit the `cl` file manually to improve the readability of input-output arguments, assign values to memory variables, and write assertive sentences to judge the computational and input-output range correctness of the verified subroutine. Finally, we confirm both the computational and input-output range correctness of the verified subroutine by running the executable program `cv` using the `cl` file as the input parameter.

## How to reproduce the results?

### Prerequisites

If you are are new to `CryptoLine`, we recommend you to read the [Prerequisites of CryptoLine](https://github.com/fmlab-iis/cryptoline#prerequisite) for building and installing it.

For linux platforms, such as Ubuntu 22.04, running the following commands will build and install `CryptoLine`. For other platforms, please see the [Prerequisites of CryptoLine](https://github.com/fmlab-iis/cryptoline#prerequisite).
```bash
git clone https://github.com/fmlab-iis/cryptoline.git
cd cryptoline
# We use checkout to switch to a specific version, ensuring reproducibility within that version. Updated versions may introduce potential compatibility issues.
git checkout 441274950ac068cf3ceb75fc57a3cd70835e0d18
sudo apt -y install \
     build-essential ocaml ocaml-dune libzarith-ocaml-dev liblwt-ocaml-dev \
     curl git bc cmake libreadline-dev boolector singular opam
./scripts/install-boolector.sh
dune build
dune install
```

Compiling `CryptoLine` in different environments may lead to different issues. Fortunately, the `CryptoLine` repository provides some scripts that can fix related dependencies to certain versions to aid in reproduction. Please refer to `script/update-build-environments`. If you encounter problems during the compilation process, we recommend trying to run this script and then switching to a specific environment using `opam switch`, for example, `opam switch ocaml4.13.1-coq8.15.0-ssr1.14.0; eval $(opam env)`.

For more information on using CryptoLine, see:
- [CryptoLine language tutorial provided by CryptoLine project](https://github.com/fmlab-iis/cryptoline/blob/master/doc/cryptoline.pdf),
- [A tutorial provided by CryptoLine project](https://github.com/fmlab-iis/cryptoline/blob/master/doc/tutorial.pdf), and
- [Reference provided by CryptoLine project](https://github.com/fmlab-iis/cryptoline#reference).

### Steps to reproduce

Use the following commands one by one to reproduce our results.
```bash
cv -v -disable_safety adc_fp255_8x1w.cl
cv -v -disable_safety add_fp255_8x1w.cl
cv -v -disable_safety carry_fp255_8x1w.cl
cv -v -disable_safety final_modp_fp255_8x1w.cl
cv -v -disable_safety mul_x_fp255_8x1w.cl
cv -v -disable_safety mul51_fp255_8x1w.cl
cv -v -disable_safety sbc_fp255_8x1w.cl
cv -v -disable_safety sqr_x_fp255_8x1w.cl
```
Each command verifies a subroutine related to the finite field implementation.
For instance, the first command verifies `adc_fp255_8x1w` subroutine that computes 8x1-way addition with carry in $F_p$ where $p=2^{255}-19$.

For the specific function of each subroutine (e.g., adc_fp255_8x1w), we recommend reading the annotations of each subroutine in Curve25519_AVX512IFMA project.

After running the commands, you should see an output similar to the following:
```
Parsing CryptoLine file:              [OK]    0.001717 seconds
Checking well-formedness:             [OK]    0.000545 seconds
Transforming to SSA form:             [OK]    0.000199 seconds
Normalizing specification:            [OK]    0.000207 seconds
Rewriting assignments:                [OK]    0.000309 seconds
Verifying range assertions:           [OK]    0.077246 seconds
Verifying range specification:        [OK]    0.087141 seconds
Rewriting value-preserved casting:    [OK]    0.000030 seconds
Verifying algebraic assertions:       [OK]    0.000028 seconds
Verifying algebraic specification:    [OK]    0.022886 seconds
Verification result:                  [OK]    0.190914 seconds
```
Here, each "[OK]" represents a successful verification step. And the output of each command is placed at the beginning of the corresponding `cl` file and wrapped by "(\*" and "\*)".

If you are interested in the details of the source code in the `*.cl` and `*.gas` files, please refer to the following sections.

### More details about the source code

There are two main points that need to be verified: (1) the correctness of the computation and (2) the allowable input range and the promised output range.

In this section, we will give more details to answer the following questions:
- How to obtain the `*.gas` and `*.cl` files?
- How are the two main points mentioned above reflected in the source code?

#### How to obtain the `*.gas` and `*.cl` files?

Our verification process consists of the following steps:

1. Use the `itrace.py` script to extract traces from running the cryptographic programs in GDB. For example, running the command `itrace.py batch_avx512_test adc_fp255_8x1w adc_fp255_8x1w.gas` generate the `adc_fp255_8x1w.gas` file. The `batch_avx512_test` is an executed program obtained from Curve25519_AVX512IFMA project. We obtain other `*.gas` files in a similar manner.
2. Write some translation rules manually. These rules can translate assembly instructions into CryptoLine language. The translation rules can be found at the beginning of the `*.gas` files in this project and start with `#!`.
3. Use the `to_zdsl.py` script to translate the assembly instructions in a `gas` file to CryptoLine language. For example, running the command `to_zdsl.py adc_fp255_8x1w.gas > adc_fp255_8x1w.cl` generate the `adc_fp255_8x1w.cl` file. We obtain other `*.cl` files in a similar manner.
4. Manually edit the `cl` file to improve the readability of input-output arguments, assign values to memory variables, and write assertive sentences to judge the computational correctness and range correctness of the verified subroutine. To accomplish this step, it is necessary to understand the source code of the verified subroutine (in the format of C language or assembly language).
5. Run the commands mentioned in [Steps to reproduce](#steps-to-reproduce).

CryptoLine is a semi-automated tool. In the following, we will provide information about the manual actions performed during the verification process.

We need manual actions in two steps: Step 2 - writing translation rules, and Step 4 - making necessary modifications to the generated CryptoLine code (i.e., the `cl` file).

As an example, let's consider the translation rule in `adc_fp255_8x1w.gas`.
```
#! vmovdqa64 $1ea, $2zmm -> mov $2zmm_000 $1ea;\nmov $2zmm_001 $1ea[+8];\nmov $2zmm_010 $1ea[+16];\nmov $2zmm_011 $1ea[+24];\nmov $2zmm_100 $1ea[+32];\nmov $2zmm_101 $1ea[+40];\nmov $2zmm_110 $1ea[+48];\nmov $2zmm_111 $1ea[+56]
```
This rule translates the AVX512 instruction `vmovdqa64 (%rsi),%zmm7` in `adc_fp255_8x1w.gas` into the following CryptoLine instructions (you can find them in `adc_fp255_8x1w.cl`).
```
mov zmm7_000 L0x7fffffffd500;
mov zmm7_001 L0x7fffffffd508;
mov zmm7_010 L0x7fffffffd510;
mov zmm7_011 L0x7fffffffd518;
mov zmm7_100 L0x7fffffffd520;
mov zmm7_101 L0x7fffffffd528;
mov zmm7_110 L0x7fffffffd530;
mov zmm7_111 L0x7fffffffd538;
```

To understand the manual actions performed in Step 4, we recommend running the command `to_zdsl.py adc_fp255_8x1w.gas > adc_fp255_8x1w_1.cl` to obtain the original `cl` file and comparing it with the modified `adc_fp255_8x1w.cl` file.

#### How are the two main points mentioned above reflected in the source code?

To understand this question, we need to analyze the `cl` file in detail.

The `adc_fp255_8x1w.cl` file, which is part of this project, begins with the following code:
```
proc main (uint64 a00, uint64 a10, ... , uint64 a60, uint64 a70,
           ...
           uint64 a04, uint64 a14, ... , uint64 a64, uint64 a74,
           uint64 b00, uint64 b10, ... , uint64 b60, uint64 b70,
           ...
           uint64 b04, uint64 b14, ... , uint64 b64, uint64 b74,
           uint64 c00, uint64 c10, ... , uint64 c60, uint64 c70,
           ...
           uint64 c04, uint64 c14, ... , uint64 c64, uint64 c74,
           uint268 p) =
{
  and [
    p = 0x007fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed
  ]
  &&
  and [
        p = 0x07fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed@268,
        a00 <=u 0xfffffffffffff@64, a01 <=u 0xfffffffffffff@64, 
        a02 <=u 0xfffffffffffff@64, a03 <=u 0xfffffffffffff@64, 
        a04 <=u 0xfffffffffffff@64, 
        ...
        a70 <=u 0xfffffffffffff@64, a71 <=u 0xfffffffffffff@64, 
        a72 <=u 0xfffffffffffff@64, a73 <=u 0xfffffffffffff@64, 
        a74 <=u 0xfffffffffffff@64, 
        b00 <=u 0xfffffffffffff@64, b01 <=u 0xfffffffffffff@64, 
        b02 <=u 0xfffffffffffff@64, b03 <=u 0xfffffffffffff@64, 
        b04 <=u 0xfffffffffffff@64, 
        ...
        b70 <=u 0xfffffffffffff@64, b71 <=u 0xfffffffffffff@64, 
        b72 <=u 0xfffffffffffff@64, b73 <=u 0xfffffffffffff@64, 
        b74 <=u 0xfffffffffffff@64
      ]
}
```
In the above code, the `uint64 axy` and `uint64 bxy` represent the input variables, while `uint64 cxy` represents the output variables, where $x \in [0,7],y \in [0,4]$. It's important to note that our implementation is 8x1-way, so the `uint64 ax0-ax4` can be viewed as a one-way input.

The code contains instructions like `a00 <=u 0xfffffffffffff@64`, which define the allowable input range of this subroutine.

For more information on the allowable input range and promised output range, please refer to the annotation of the corresponding subroutine in the `Curve25519_AVX512IFMA` project.

The ending part of `adc_fp255_8x1w.cl` is as follows.
```
{
  and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
            limbs 51 [a00, a01, a02, a03, a04] + limbs 51 [b00, b01, b02, b03, b04]
            p,
      ...
      eqmod limbs 51 [c70, c71, c72, c73, c74]
            limbs 51 [a70, a71, a72, a73, a74] + limbs 51 [b70, b71, b72, b73, b74]
            p
  ]
  &&
  and [
      c00 <=u 0x8000000000080@64, c01 <=u 0x8000000000000@64, 
      c02 <=u 0x8000000000005@64, c03 <=u 0x8000000000000@64, 
      c04 <=u 0x8000000000005@64,
      ...
      c70 <=u 0x8000000000080@64, c71 <=u 0x8000000000000@64, 
      c72 <=u 0x8000000000005@64, c73 <=u 0x8000000000000@64, 
      c74 <=u 0x8000000000005@64
  ]
}
```
The `eqmod` instruction is used to verify the computational correctness.
The instructions like `c00 <=u 0x8000000000080@64` represent the promised output range.