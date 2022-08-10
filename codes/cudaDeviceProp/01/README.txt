cmd.exe "/K" '"C:\Program Files (x86)\Intel\oneAPI\setvars.bat" && powershell'
cmake -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icx -DCMAKE_BUILD_TYPE=Release -GNinja ..
cmake --build .
mpiexec -n 4 .\testprj.exe

cmake .. -D CMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . --config Release

PS D:\work\cuda_work\ModernCuda\codes\cudaMPIOpenMP\01\build> mpiexec -n 4 .\Release\testprj.exe
Running on 4 nodes
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70882e+06 process id = 0 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70836e+06 process id = 1 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70802e+06 process id = 2 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70732e+06 process id = 3 nproc = 4
Average of square roots is: 0.667239
PASSED

PS D:\work\cuda_work\ModernCuda\codes\cudaMPIOpenMP\01\build> nvprof --profile-child-processes mpiexec -n 4 .\Release\testprj.exe
Running on 4 nodes
==103084== NVPROF is profiling process 103084, command: .\Release\testprj.exe
==174256== NVPROF is profiling process 174256, command: .\Release\testprj.exe
==174028== NVPROF is profiling process 174028, command: .\Release\testprj.exe
==160208== NVPROF is profiling process 160208, command: .\Release\testprj.exe
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70836e+06 process id = 1 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70882e+06 process id = 0 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70802e+06 process id = 2 nproc = 4
Starting addConstantGpu...

number of host CPUs:    16
number of CUDA devices: 1
   0: NVIDIA GeForce RTX 2060
---------------------------
CPU thread 0 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CPU thread 1 (of 2) uses CUDA device 0
block_size=128
grid_size=32
CHECK PASSED!
sumNode = 1.70732e+06 process id = 3 nproc = 4
Average of square roots is: 0.667239
PASSED
==174256== Profiling application: .\Release\testprj.exe
==174256== Warning: 1 API trace records have same start and end timestamps.
This can happen because of short execution duration of CUDA APIs and low timer resolution on the underlying operating system.
==174256== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   53.54%  1.3734ms         3  457.81us  2.1760us  1.3680ms  [CUDA memcpy DtoH]
                   42.47%  1.0895ms         3  363.16us  2.3050us  1.0844ms  [CUDA memcpy HtoD]
                    3.40%  87.104us         1  87.104us  87.104us  87.104us  sqrtKernel(float*, float*)
                    0.31%  7.9050us         2  3.9520us  3.9050us  4.0000us  [CUDA memset]
                    0.28%  7.1690us         2  3.5840us  3.5520us  3.6170us  kernelAddConstant(int*, int)
      API calls:   78.25%  263.09ms         4  65.773ms  53.100us  262.41ms  cudaMalloc
                   20.25%  68.085ms         1  68.085ms  68.085ms  68.085ms  cuDevicePrimaryCtxRelease
                    1.28%  4.3041ms         6  717.35us  43.200us  1.8737ms  cudaMemcpy
                    0.15%  515.10us         4  128.78us  100.30us  197.60us  cudaFree
                    0.03%  96.000us         3  32.000us  16.300us  59.800us  cudaLaunchKernel
                    0.02%  63.400us         2  31.700us  25.700us  37.700us  cudaMemset
                    0.01%  32.100us         1  32.100us  32.100us  32.100us  cuModuleUnload
                    0.00%  16.200us       101     160ns       0ns  2.0000us  cuDeviceGetAttribute
                    0.00%  4.5000us         3  1.5000us     200ns  3.5000us  cuDeviceGetCount
                    0.00%  4.3000us         2  2.1500us     200ns  4.1000us  cuDeviceGet
                    0.00%  4.1000us         2  2.0500us  1.9000us  2.2000us  cudaSetDevice
                    0.00%  2.4000us         1  2.4000us  2.4000us  2.4000us  cudaGetDeviceProperties
                    0.00%  1.1000us         2     550ns     400ns     700ns  cudaGetDevice
                    0.00%     600ns         1     600ns     600ns     600ns  cuDeviceGetName
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceTotalMem
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceGetLuid
                    0.00%     100ns         1     100ns     100ns     100ns  cuDeviceGetUuid
                    0.00%     100ns         1     100ns     100ns     100ns  cudaGetDeviceCount
==103084== Profiling application: .\Release\testprj.exe
==103084== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   48.46%  992.61us         3  330.87us  1.5360us  989.28us  [CUDA memcpy HtoD]
                   47.07%  964.10us         3  321.37us  2.6560us  958.27us  [CUDA memcpy DtoH]
                    3.91%  80.000us         1  80.000us  80.000us  80.000us  sqrtKernel(float*, float*)
                    0.30%  6.1760us         2  3.0880us  2.6560us  3.5200us  [CUDA memset]
                    0.26%  5.2480us         2  2.6240us  2.1120us  3.1360us  kernelAddConstant(int*, int)
      API calls:   76.38%  241.31ms         4  60.328ms  10.676ms  206.39ms  cudaMalloc
                   21.99%  69.467ms         1  69.467ms  69.467ms  69.467ms  cuDevicePrimaryCtxRelease
                    1.19%  3.7568ms         6  626.13us  13.100us  1.8026ms  cudaMemcpy
                    0.29%  911.80us         2  455.90us  312.00us  599.80us  cudaMemset
                    0.10%  301.00us         4  75.250us  4.7000us  105.70us  cudaFree
                    0.03%  83.700us         3  27.900us  15.300us  50.400us  cudaLaunchKernel
                    0.02%  62.800us         1  62.800us  62.800us  62.800us  cuModuleUnload
                    0.01%  18.400us       101     182ns     100ns  2.9000us  cuDeviceGetAttribute
                    0.00%  4.6000us         2  2.3000us     200ns  4.4000us  cuDeviceGet
                    0.00%  4.4000us         3  1.4660us     200ns  3.7000us  cuDeviceGetCount
                    0.00%  4.2000us         2  2.1000us  1.8000us  2.4000us  cudaSetDevice
                    0.00%  2.5000us         1  2.5000us  2.5000us  2.5000us  cudaGetDeviceProperties
                    0.00%  1.2000us         2     600ns     500ns     700ns  cudaGetDevice
                    0.00%     600ns         1     600ns     600ns     600ns  cuDeviceGetName
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceTotalMem
                    0.00%     300ns         1     300ns     300ns     300ns  cudaGetDeviceCount
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetLuid
==174028== Profiling application: .\Release\testprj.exe
==174028== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   47.96%  936.22us         3  312.07us  1.7920us  932.10us  [CUDA memcpy HtoD]
                   47.37%  924.74us         3  308.25us  2.6560us  919.42us  [CUDA memcpy DtoH]
                    4.06%  79.265us         1  79.265us  79.265us  79.265us  sqrtKernel(float*, float*)
                    0.33%  6.4640us         2  3.2320us  2.9440us  3.5200us  [CUDA memset]
                    0.29%  5.6000us         2  2.8000us  2.6560us  2.9440us  kernelAddConstant(int*, int)
      API calls:   78.79%  272.88ms         4  68.220ms  54.600us  272.62ms  cudaMalloc
                   20.12%  69.670ms         1  69.670ms  69.670ms  69.670ms  cuDevicePrimaryCtxRelease
                    0.92%  3.1938ms         6  532.30us  36.300us  1.6073ms  cudaMemcpy
                    0.09%  324.90us         4  81.225us  5.0000us  130.00us  cudaFree
                    0.03%  117.90us         2  58.950us  29.200us  88.700us  cudaMemset
                    0.03%  96.500us         3  32.166us  18.900us  48.300us  cudaLaunchKernel
                    0.01%  25.200us         1  25.200us  25.200us  25.200us  cuModuleUnload
                    0.00%  14.000us       101     138ns     100ns  1.8000us  cuDeviceGetAttribute
                    0.00%  4.3000us         3  1.4330us     200ns  3.0000us  cuDeviceGetCount
                    0.00%  4.2000us         2  2.1000us  1.9000us  2.3000us  cudaSetDevice
                    0.00%  3.7000us         2  1.8500us     300ns  3.4000us  cuDeviceGet
                    0.00%  2.8000us         1  2.8000us  2.8000us  2.8000us  cudaGetDeviceProperties
                    0.00%  1.1000us         2     550ns     400ns     700ns  cudaGetDevice
                    0.00%     700ns         1     700ns     700ns     700ns  cuDeviceGetName
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceTotalMem
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceGetLuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid
                    0.00%     100ns         1     100ns     100ns     100ns  cudaGetDeviceCount
==160208== Profiling application: .\Release\testprj.exe
==160208== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   58.26%  1.4672ms         3  489.06us  1.5690us  1.4638ms  [CUDA memcpy HtoD]
                   38.05%  958.08us         3  319.36us  2.6870us  952.70us  [CUDA memcpy DtoH]
                    3.13%  78.881us         1  78.881us  78.881us  78.881us  sqrtKernel(float*, float*)
                    0.30%  7.4560us         2  3.7280us  3.5520us  3.9040us  [CUDA memset]
                    0.26%  6.6240us         2  3.3120us  3.1360us  3.4880us  kernelAddConstant(int*, int)
      API calls:   78.62%  260.54ms         4  65.134ms  55.000us  260.01ms  cudaMalloc
                   19.93%  66.039ms         1  66.039ms  66.039ms  66.039ms  cuDevicePrimaryCtxRelease
                    1.23%  4.0913ms         6  681.88us  55.500us  2.2627ms  cudaMemcpy
                    0.14%  464.10us         4  116.03us  96.700us  153.00us  cudaFree
                    0.03%  93.600us         3  31.200us  15.400us  39.400us  cudaLaunchKernel
                    0.02%  61.500us         2  30.750us  26.200us  35.300us  cudaMemset
                    0.02%  54.700us         1  54.700us  54.700us  54.700us  cuModuleUnload
                    0.00%  13.700us       101     135ns     100ns  1.7000us  cuDeviceGetAttribute
                    0.00%  4.2000us         2  2.1000us  2.0000us  2.2000us  cudaSetDevice
                    0.00%  3.8000us         3  1.2660us     200ns  3.0000us  cuDeviceGetCount
                    0.00%  3.4000us         2  1.7000us     200ns  3.2000us  cuDeviceGet
                    0.00%  2.1000us         1  2.1000us  2.1000us  2.1000us  cudaGetDeviceProperties
                    0.00%  1.0000us         2     500ns     400ns     600ns  cudaGetDevice
                    0.00%     700ns         1     700ns     700ns     700ns  cuDeviceGetName
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceTotalMem
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceGetLuid
                    0.00%     300ns         1     300ns     300ns     300ns  cudaGetDeviceCount
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid