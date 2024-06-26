# TheCuda-HelloWorld
When I learned CUDA, I found that just about every tutorial and course starts with something that they call "Hello World". But, usually, that was not a "Hello World" program at all! "Hello world!" in Cuda should produce a string identical to "Hello World!", it should not print several strings, and it should not do other irrelevant things!

## How should it be?

The problem with "Hello World!" for CUDA is simply this: You can't just printf("Hello World!\n"), because then you are not running any CUDA at all it would just be a C example, "Hello World!" for CUDA must do something in parallel, with a kernel run in the GPU.
Here is my version: It takes the string "Hello ", and sends that sequel as an array (15, 10, 6, 0, -11, 1) to the kernel. The kernel adds the array elements to a string, which produces the array "World!". This string is passed back to the host and printed out.

Simple, parallel, relevant, and the output is Hello World!

## Execution in Linux
To compile the program, use `nvcc`:
```bash
nvcc HelloCuda.cu -o HelloCuda
```
To run the compiled program, execute:
```bash
./HelloCuda
```
Make sure you have NVIDIA CUDA Toolkit installed on your system to compile CUDA programs.
