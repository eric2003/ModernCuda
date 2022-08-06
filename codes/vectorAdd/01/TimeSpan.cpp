#include "TimeSpan.h"
#include <iostream>
#include <thread>

TimeSpan::TimeSpan()
{
    //this->Start();
}

TimeSpan::~TimeSpan()
{
    ;
}

void TimeSpan::Start()
{
    std::cout << " TimeSpan::Restart() " << std::endl;
    this->time_old = std::chrono::system_clock::now();
    std::cout << "this->time_old.time_since_epoch().count() = " << this->time_old.time_since_epoch().count() << std::endl;
}

void TimeSpan::Stop()
{
    this->time_now = std::chrono::system_clock::now();
}

void TimeSpan::ShowTimeSpan( const std::string & title )
{
    this->time_now = std::chrono::system_clock::now();
    std::cout << "this->time_old.time_since_epoch().count() = " << this->time_old.time_since_epoch().count() << std::endl;
    std::cout << "this->time_now.time_since_epoch().count() = " << this->time_now.time_since_epoch().count() << std::endl;  
    std::chrono::steady_clock::duration time_span = time_now - time_old;
    std::chrono::system_clock::duration stime_span = time_now - time_old;
    std::cout << " TimeSpan::ShowTimeSpanMilliseconds : " << time_span << std::endl;
    std::cout << " TimeSpan::time_span.count() : " << std::chrono::duration_cast<std::chrono::milliseconds>(time_span).count() << std::endl;
    std::cout << " TimeSpan::stime_span.count() : " << std::chrono::duration_cast<std::chrono::milliseconds>(stime_span).count() << std::endl;
    
    std::cout << title << " TimeSpan::time elapsed : " 
              << std::chrono::duration_cast<std::chrono::milliseconds>(this->time_now - this->time_old).count()
              << " milliseconds" << std::endl;

    this->time_old = this->time_now;
}