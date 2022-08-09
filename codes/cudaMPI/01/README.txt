cmd.exe "/K" '"C:\Program Files (x86)\Intel\oneAPI\setvars.bat" && powershell'
cmake -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icx -DCMAKE_BUILD_TYPE=Release -GNinja ..
cmake --build .
mpiexec -n 4 .\testprj.exe

cmake .. -D CMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . --config Release

PS D:\work\cuda_work\ModernCuda\codes\cudaMPI\01\build> mpiexec -n 4 .\Release\testprj.exe
Running on 4 nodes
sumNode = 1.70802e+06 process id = 2 nproc = 4
sumNode = 1.70836e+06 process id = 1 nproc = 4
sumNode = 1.70882e+06 process id = 0 nproc = 4
sumNode = 1.70732e+06 process id = 3 nproc = 4
Average of square roots is: 0.667239
PASSED

PS D:\work\cuda_work\ModernCuda\codes\cudaMPI\01\build> nvprof --profile-child-processes mpiexec -n 4 .\Release\testprj.exe
Running on 4 nodes
==39592== NVPROF is profiling process 39592, command: .\Release\testprj.exe
==109072== NVPROF is profiling process 109072, command: .\Release\testprj.exe
==133044== NVPROF is profiling process 133044, command: .\Release\testprj.exe
==28280== NVPROF is profiling process 28280, command: .\Release\testprj.exe
sumNode = 1.70802e+06 process id = 2 nproc = 4
sumNode = 1.70882e+06 process id = 0 nproc = 4
sumNode = 1.70732e+06 process id = 3 nproc = 4
sumNode = 1.70836e+06 process id = 1 nproc = 4
Average of square roots is: 0.667239
PASSED
==109072== Profiling application: .\Release\testprj.exe
==109072== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   56.13%  3.3641ms         1  3.3641ms  3.3641ms  3.3641ms  [CUDA memcpy HtoD]
                   42.47%  2.5452ms         1  2.5452ms  2.5452ms  2.5452ms  [CUDA memcpy DtoH]
                    1.40%  83.648us         1  83.648us  83.648us  83.648us  sqrtKernel(float*, float*)
      API calls:   84.17%  429.93ms         2  214.97ms  106.20us  429.82ms  cudaMalloc
                   13.86%  70.802ms         1  70.802ms  70.802ms  70.802ms  cuDevicePrimaryCtxRelease
                    1.79%  9.1683ms         2  4.5842ms  3.4947ms  5.6736ms  cudaMemcpy
                    0.09%  454.90us         1  454.90us  454.90us  454.90us  cuModuleUnload
                    0.06%  329.70us         2  164.85us  146.60us  183.10us  cudaFree
                    0.01%  60.800us         1  60.800us  60.800us  60.800us  cudaLaunchKernel
                    0.00%  16.000us       101     158ns     100ns  2.1000us  cuDeviceGetAttribute
                    0.00%  5.5000us         2  2.7500us     100ns  5.4000us  cuDeviceGet
                    0.00%  4.6000us         3  1.5330us     100ns  3.9000us  cuDeviceGetCount
                    0.00%     600ns         1     600ns     600ns     600ns  cuDeviceGetName
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceTotalMem
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceGetLuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid
==133044== Profiling application: .\Release\testprj.exe
==133044== Warning: 1 API trace records have same start and end timestamps.
This can happen because of short execution duration of CUDA APIs and low timer resolution on the underlying operating system.
==133044== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   56.35%  2.0690ms         1  2.0690ms  2.0690ms  2.0690ms  [CUDA memcpy DtoH]
                   41.29%  1.5160ms         1  1.5160ms  1.5160ms  1.5160ms  [CUDA memcpy HtoD]
                    2.36%  86.496us         1  86.496us  86.496us  86.496us  sqrtKernel(float*, float*)
      API calls:   83.11%  398.11ms         2  199.06ms  89.400us  398.02ms  cudaMalloc
                   15.42%  73.887ms         1  73.887ms  73.887ms  73.887ms  cuDevicePrimaryCtxRelease
                    1.19%  5.6958ms         2  2.8479ms  2.8184ms  2.8774ms  cudaMemcpy
                    0.10%  466.50us         1  466.50us  466.50us  466.50us  cuModuleUnload
                    0.09%  434.80us         2  217.40us  162.40us  272.40us  cudaFree
                    0.09%  415.60us         1  415.60us  415.60us  415.60us  cudaLaunchKernel
                    0.00%  14.600us       101     144ns       0ns  1.8000us  cuDeviceGetAttribute
                    0.00%  7.5000us         3  2.5000us     300ns  6.5000us  cuDeviceGetCount
                    0.00%  4.6000us         2  2.3000us     200ns  4.4000us  cuDeviceGet
                    0.00%     800ns         1     800ns     800ns     800ns  cuDeviceGetName
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceTotalMem
                    0.00%     400ns         1     400ns     400ns     400ns  cuDeviceGetLuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid
==28280== Profiling application: .\Release\testprj.exe
==28280== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   56.12%  3.3321ms         1  3.3321ms  3.3321ms  3.3321ms  [CUDA memcpy HtoD]
                   42.52%  2.5247ms         1  2.5247ms  2.5247ms  2.5247ms  [CUDA memcpy DtoH]
                    1.36%  80.704us         1  80.704us  80.704us  80.704us  sqrtKernel(float*, float*)
      API calls:   83.77%  429.65ms         2  214.83ms  119.80us  429.53ms  cudaMalloc
                   14.25%  73.098ms         1  73.098ms  73.098ms  73.098ms  cuDevicePrimaryCtxRelease
                    1.82%  9.3322ms         2  4.6661ms  3.4095ms  5.9227ms  cudaMemcpy
                    0.09%  455.00us         1  455.00us  455.00us  455.00us  cuModuleUnload
                    0.05%  262.40us         2  131.20us  111.30us  151.10us  cudaFree
                    0.01%  51.700us         1  51.700us  51.700us  51.700us  cudaLaunchKernel
                    0.00%  14.900us       101     147ns     100ns  1.5000us  cuDeviceGetAttribute
                    0.00%  4.2000us         3  1.4000us     200ns  3.2000us  cuDeviceGetCount
                    0.00%  3.2000us         2  1.6000us     200ns  3.0000us  cuDeviceGet
                    0.00%     500ns         1     500ns     500ns     500ns  cuDeviceGetName
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceGetLuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceTotalMem
                    0.00%     100ns         1     100ns     100ns     100ns  cuDeviceGetUuid
==39592== Profiling application: .\Release\testprj.exe
==39592== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   56.13%  3.3172ms         1  3.3172ms  3.3172ms  3.3172ms  [CUDA memcpy HtoD]
                   42.48%  2.5106ms         1  2.5106ms  2.5106ms  2.5106ms  [CUDA memcpy DtoH]
                    1.39%  82.431us         1  82.431us  82.431us  82.431us  sqrtKernel(float*, float*)
      API calls:   83.99%  428.39ms         2  214.19ms  205.30us  428.18ms  cudaMalloc
                   14.03%  71.540ms         1  71.540ms  71.540ms  71.540ms  cuDevicePrimaryCtxRelease
                    1.82%  9.3044ms         2  4.6522ms  3.2817ms  6.0227ms  cudaMemcpy
                    0.09%  483.20us         1  483.20us  483.20us  483.20us  cuModuleUnload
                    0.05%  267.80us         2  133.90us  106.30us  161.50us  cudaFree
                    0.01%  44.300us         1  44.300us  44.300us  44.300us  cudaLaunchKernel
                    0.00%  13.300us       101     131ns     100ns  1.5000us  cuDeviceGetAttribute
                    0.00%  4.7000us         3  1.5660us     100ns  4.2000us  cuDeviceGetCount
                    0.00%  2.6000us         2  1.3000us     100ns  2.5000us  cuDeviceGet
                    0.00%     500ns         1     500ns     500ns     500ns  cuDeviceGetName
                    0.00%     300ns         1     300ns     300ns     300ns  cuDeviceTotalMem
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetUuid
                    0.00%     200ns         1     200ns     200ns     200ns  cuDeviceGetLuid