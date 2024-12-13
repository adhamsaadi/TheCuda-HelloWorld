#include <stdio.h>

const int N = 13; // Number of elements in the arrays
const int blocksize = 6; // Number of threads per block

__global__ 
void hello(char* a, int* b) 
{
    // Ensure threads only access valid indices
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if (idx < N) {
        a[idx] += b[idx];
    }
}

int main()
{
    char a[N] = "Hello \0\0\0\0\0\0";
    int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0};

    char* device_a;
    int* device_b;
    const int csize = N * sizeof(char);
    const int isize = N * sizeof(int);

    // Print the initial string
    printf("%s\n", a);

    // Allocate memory on the device
    cudaMalloc((void**)&device_a, csize);
    cudaMalloc((void**)&device_b, isize);

    // Copy data from host to device
    cudaMemcpy(device_a, a, csize, cudaMemcpyHostToDevice);
    cudaMemcpy(device_b, b, isize, cudaMemcpyHostToDevice);

    // Configure the grid and block dimensions
    dim3 dimBlock(min(N, blocksize));
    dim3 dimGrid((N + blocksize - 1) / blocksize);

    // Launch the kernel
    hello<<<dimGrid, dimBlock>>>(device_a, device_b);

    // Copy the result back to the host
    cudaMemcpy(a, device_a, csize, cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(device_a);
    cudaFree(device_b);

    // Print the modified string
    printf("%s\n", a);

    return 0;
}
