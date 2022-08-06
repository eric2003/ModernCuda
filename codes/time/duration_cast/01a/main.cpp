// duration_cast
#include <iostream>     // std::cout
#include <chrono>       // std::chrono::seconds, std::chrono::milliseconds
                        // std::chrono::duration_cast

int main ( int argc, char **argv )
{
    std::chrono::seconds ss (1);             // 1 second
    std::chrono::milliseconds ms = std::chrono::duration_cast<std::chrono::milliseconds> (ss);
    
    ms += std::chrono::milliseconds(2500);  // 2500 millisecond
    
    std::chrono::seconds s = std::chrono::duration_cast<std::chrono::seconds> (ms);   // truncated
    
    std::cout << "ms: " << ms.count() << std::endl;
    std::cout << "s: " << s.count() << std::endl;
    
    return 0;
}
