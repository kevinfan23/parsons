//
//  Ball.cpp
//  threads
//
//  Created by Kevin Fan on 11/6/17.
//

#include "Ball.hpp"
#include "ofMain.h"

float thold = 5;
float spifac = 1.05;
float drag = 0.01;

Ball::Ball() {
    X = ofRandom(ofGetWidth());
    Y = ofRandom(ofGetHeight());
    w = ofRandom(1 / thold, thold);
}

void Ball::display(float x, float y) {
    if(!ofGetMousePressed()) {
        Xv /= spifac;
        Yv /= spifac;
    }
    Xv += drag * (x - X) * w;
    Yv += drag * (y - Y) * w;
    X += Xv;
    Y += Yv;
    ofSetColor(255, 255, 255, 5);
    ofDrawLine(X, Y, pX, pY);
    pX = X;
    pY = Y;
}
