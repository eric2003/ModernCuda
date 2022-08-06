#include <iostream>
#include <chrono>

int main ( int argc, char **argv )
{
    {
        typedef std::chrono::steady_clock Clock;
        Clock::time_point clock_begin = Clock::now();
        
        std::cout << "printing out 1000 stars...\n";
        for (int i=0; i<1000; ++i) std::cout << "*";
        std::cout << std::endl;
        
        Clock::time_point clock_end = Clock::now();
        
        Clock::duration time_span = clock_end - clock_begin;
        
        std::cout << "std::chrono::steady_clock:period::num= " << Clock::period::num << " period::den = " << Clock::period::den << std::endl;
        
        double nseconds = double(time_span.count()) * Clock::period::num / Clock::period::den;
        std::cout << "time_span.count()= " << time_span.count() << std::endl;
        
        std::cout << "It took me " << nseconds << " seconds.";
        std::cout << std::endl;
		
        std::chrono::seconds ss (1);             // 1 second
        std::chrono::seconds t1 = std::chrono::duration_cast<std::chrono::seconds> ( time_span );       
        std::chrono::milliseconds t2 = std::chrono::duration_cast<std::chrono::milliseconds> ( time_span );     
        std::cout << "t1.count() = " << t1.count() << " seconds." << std::endl;
        std::cout << "t2.count() = " << t2.count() << " milliseconds." << std::endl;
    }
    {
        using SClock = std::chrono::system_clock;
        SClock::time_point clock_begin = SClock::now();
        
        std::cout << "printing out 1000 stars...\n";
        for (int i=0; i<1000; ++i) std::cout << "*";
        std::cout << std::endl;
        SClock::time_point clock_end = SClock::now();
        std::cout << "std::chrono::system_clock:period::num= " << SClock::period::num << " period::den = " << SClock::period::den << std::endl;
        
        SClock::duration time_span = clock_end - clock_begin;
        std::cout << "time_span.count()= " << time_span.count() << std::endl;
        
        double nseconds = double(time_span.count()) * SClock::period::num / SClock::period::den;
        
        std::cout << "It took me " << nseconds << " seconds.";
        std::cout << std::endl;
    }

    return 0;
}
