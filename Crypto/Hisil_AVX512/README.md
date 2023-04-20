# Hisil_AVX512

This project is a copy of the [Hisil project](https://github.com/crypto-ninjaturtles/montgomery4x/tree/master/avx512-5limb-4x2) from the paper "Fast 4 way vectorized ladder for the complete set of Montgomery curves", with some minor modifications to allow it to run on my machine.

```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
./hisil_avx512_test
```
