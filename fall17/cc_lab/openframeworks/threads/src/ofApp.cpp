#include "ofApp.h"
//#include "global.h"

//const int big = 500;
float mX;
float mY;

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetFullscreen(true);
    ofSetFrameRate(60);
    ofEnableSmoothing();
    ofBackground(0);
    ofSetBackgroundAuto(false);
    ofEnableAlphaBlending();
    
    for(int i = 0; i < big; i++) {
        bodies[i] = Ball();
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    mX += 0.3 * (mouseX - mX);
    mY += 0.3 * (mouseY - mY);
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(0, 0, 0, 10);
    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
//    float time = ofGetElapsedTimef();
//    float amp = 50;
//    float freq = 0.5;
//
//    float x;
//
//    if (time > ofGetWidth()) {
//        x = 0;
//    }
//    else {
//        x = time * 100;
//    }
//    float y = amp * sin(x * freq) + ofGetHeight()/2;
//
    for(int i = 0; i < big; i++) {
        bodies[i].display(mX, mY);
    }

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
