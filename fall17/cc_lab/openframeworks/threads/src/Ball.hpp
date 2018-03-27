//
//  Ball.hpp
//  threads
//
//  Created by Kevin Fan on 11/6/17.
//

#ifndef Ball_hpp
#define Ball_hpp

#include <stdio.h>

#endif /* Ball_hpp */

class Ball {
    
public:
    Ball();
    
    void display(float x, float y);
    
private:
    float X;
    float Y;
    float Xv;
    float Yv;
    float pX;
    float pY;
    float w;
};
