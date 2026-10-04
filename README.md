# CUDA Samples

![CUDA illustration](cuda-samples.svg)

This repository contains a couple of simple CUDA examples for vector operations on the GPU.

## Project files

| File | Description |
| --- | --- |
| `sum.cu` | Adds each element of vector `a` to the corresponding element of vector `b` on the GPU. |
| `mult.cu` | Multiplies each element of a vector by 2 on the GPU. |

## Requirements

- NVIDIA GPU with CUDA support
- CUDA Toolkit installed (`nvcc` available in your PATH)
- A Linux or compatible environment with a working CUDA driver

## Build

Compile the samples with `nvcc`:

```bash
cd /home/pedrolucas/CCUDA_SAMPLES

nvcc -o sum sum.cu
nvcc -o mult mult.cu
```

## Run

```bash
./sum
./mult
```

## What the programs do

### `sum.cu`

- Creates two integer vectors, `a` and `b`
- Copies them to device memory
- Launches a CUDA kernel that computes:

```c
b[i] = a[i] + b[i];
```

- Copies the result back to host memory and prints it

### `mult.cu`

- Creates one integer vector `a`
- Copies it to device memory
- Launches a CUDA kernel that computes:

```c
a[i] = a[i] << 1;
```

- Copies the result back to host memory and prints it

## Notes

- The sample programs are intentionally minimal and educational.
- The generated binaries `sum` and `mult` may already exist in the repository root, but recompiling from source is the safest way to ensure they reflect the current code.
