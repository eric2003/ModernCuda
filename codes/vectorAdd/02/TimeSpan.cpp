#include "TimeSpan.h"
#include <iostream>
#include <thread>

TimeSpan::TimeSpan()
{
}

TimeSpan::~TimeSpan()
{
    ;
}

void TimeSpan::Start()
{
    //std::cout << " TimeSpan::Restart() " << std::endl;
    this->time_old = std::chrono::system_clock::now();
    //std::cout << "this->time_old.time_since_epoch().count() = " << this->time_old.time_since_epoch().count() << std::endl;
}

void TimeSpan::Stop()
{
    this->time_now = std::chrono::system_clock::now();
}

void TimeSpan::ShowTimeSpan( const std::string & title )
{
    this->time_now = std::chrono::system_clock::now();
    std::cout << title << " TimeSpan::time elapsed : " 
              << std::chrono::duration_cast<std::chrono::milliseconds>(this->time_now - this->time_old).count()
              << " milliseconds" << std::endl;

    this->time_old = this->time_now;
}