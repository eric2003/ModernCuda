cmd.exe "/K" '"C:\Program Files (x86)\Intel\oneAPI\setvars.bat" && powershell'
cmake -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icx -DCMAKE_BUILD_TYPE=Release -GNinja ..
cmake --build .
mpiexec -n 4 .\testprj.exe

cmake .. -D CMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . --config Release

PS D:\work\cuda_work\ModernCuda\codes\cudaDeviceProp\01\build> .\Release\testprj.exe
 --- General Information for device 0 ---
Device Name: NVIDIA GeForce RTX 2060
Compute capability: 7.5
Clock rate: 1695000
Device copy overlap: Enabled
Kernel execition timeout : Enabled
 --- Memory Information for device 0 ---
Total global mem: 6442123264
Total constant Mem: 65536
Max mem pitch: 2147483647
Texture Alignment: 512
 --- MP Information for device 0 ---
Multiprocessor count: 30
Shared mem per mp: 49152
Registers per mp: 65536
Threads in warp: 32
Max threads per block: 1024
Max thread dimensions[0 - 2]: (1024, 1024, 64)
Max grid dimensions[0 - 2]: (2147483647, 65535, 65535)