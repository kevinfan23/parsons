#pragma once
#include "ofMain.h"
#include "ofxBox2d.h"

// ------------------------------------------------- App
class ofApp : public ofBaseApp {
    
public:
    
    void setup();
    void update();
    void draw();
    
    void keyPressed(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    
    void lineBuilder();
    void trashCanBuilder();
    
    int trashX;


    vector <ofPolyline>                  lines;
    ofxBox2d                             box2d;
    vector <shared_ptr<ofxBox2dCircle> > circles;
    vector <shared_ptr<ofxBox2dEdge> >   edges;
    
    ofxBox2dEdge edgeLine_left;
    ofxBox2dEdge edgeLine_right;
    
    float last_time;
    
    ofImage trash_can;
    ofImage space_station;
    ofImage satellite;
    ofImage ufo;
    ofImage pace_capsule;
    ofImage venus;
    ofImage saturn;
    ofImage sun;
    ofImage jupiter;
    ofImage earth;
    ofImage uranus;
    ofImage moon;
    ofImage rocket;
};
