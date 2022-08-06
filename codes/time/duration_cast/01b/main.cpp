// duration_cast
#include <iostream>     // std::cout
#include <chrono>       // std::chrono::seconds, std::chrono::milliseconds
                        // std::chrono::duration_cast

int main ( int argc, char **argv )
{
    std::chrono::seconds ss (1);             // 1 second
    std::chrono::milliseconds ms = std::chrono::duration_cast<std::chrono::milliseconds> (ss);
	std::cout << " ss.count() = " << ss.count() << std::endl;
	
	std::chrono::microseconds mcs = std::chrono::duration_cast<std::chrono::microseconds> (ss);
	std::chrono::nanoseconds ns = std::chrono::duration_cast<std::chrono::nanoseconds> (ss);
    
    ms += std::chrono::milliseconds(2500);  // 2500 millisecond
	std::cout << " ms.count() = " << ms.count() << std::endl;
	std::cout << " mcs.count() = " << mcs.count() << std::endl;
	std::cout << " ns.count() = " << ns.count() << std::endl;
    
    std::chrono::seconds s = std::chrono::duration_cast<std::chrono::seconds> (ms);   // truncated
    
    std::cout << "ms: " << ms.count() << std::endl;
    std::cout << "s: " << s.count() << std::endl;
    
    return 0;
}
