// adapted from the ofBox2d basic examples
// https://github.com/vanderlin/ofxBox2d

#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup() {
    
    ofDisableAntiAliasing();
    ofBackgroundHex(0xffffff);
    ofSetLogLevel(OF_LOG_NOTICE);
    ofSetVerticalSync(true);
    
    // initiating box2d world
    box2d.init();
    box2d.setGravity(0, 30);
    box2d.createGround();
    box2d.setFPS(60.0);
    
    // load images
    space_station.load("img/001-international-space-station.png");
    satellite.load("img/002-sputnik.png");
    ufo.load("img/003-big-ufo.png");
    pace_capsule.load("img/004-space-capsule.png");
    venus.load("img/005-venus-with-satellite.png");
    saturn.load("img/006-saturn.png");
    sun.load("img/007-big-sun-shining.png");
    jupiter.load("img/008-jupiter-with-satellite.png");
    earth.load("img/009-earth-and-moon.png");
    uranus.load("img/010-uranus-with-satellite.png");
    moon.load("img/011-big-moon.png");
    rocket.load("img/012-rocket.png");
    
    trash_can.load("img/trash-can.png");
    
    // load lines
    lineBuilder();
    
    // initialize the position of trash can
    trashX = round(ofRandom(5, ofGetWindowWidth() - 50));
    trashCanBuilder();
    
    // and draw edges
    edgeLine_left.addVertex(trashX, ofGetWindowHeight() - 65);
    edgeLine_left.addVertex(trashX + 3, ofGetWindowHeight());
    edgeLine_left.setPhysics(0.0, 0.5, 0.5);
    edgeLine_left.create(box2d.getWorld());
    
    edgeLine_right.addVertex(trashX + 50, ofGetWindowHeight() - 65);
    edgeLine_right.addVertex(trashX + 47, ofGetWindowHeight());
    edgeLine_right.setPhysics(0.0, 0.5, 0.5);
    edgeLine_right.create(box2d.getWorld());
    
    // initialize time
    last_time = 0;
}

//--------------------------------------------------------------
void ofApp::update() {
    // add some circles every so often
    if((int)ofRandom(0, 15) == 0) {
        auto c = std::make_shared<ofxBox2dCircle>();
        c.get()->setPhysics(0.2, 0.2, 0.002);
        c.get()->setup(box2d.getWorld(), ofRandom(20, 50), -20, ofRandom(3, 10));
        c.get()->setVelocity(0, 15); // shoot them down!
        circles.push_back(c);
    }
    
    box2d.update();
}

//--------------------------------------------------------------
void ofApp::draw() {
    
    // some circles
    for (int i=0; i<circles.size(); i++) {
        ofNoFill();
        circles[i].get()->draw();
    }
    
    ofSetHexColor(0x000000);
    ofNoFill();
    for (int i=0; i<lines.size(); i++) {
        lines[i].draw();
    }
    for (int i=0; i<edges.size(); i++) {
        edges[i].get()->draw();
    }
    
    // write info
    float time = ofGetElapsedTimef() - last_time;
    string info = "Draw shape with the mouse\n";
    info += "Press c to clear everything\n";
    info += "Press r to restart the game\n";
    info += "Time spent: " + std::to_string(time) + "s";
    
    ofSetHexColor(0x444342);
    ofDrawBitmapString(info, 10, 15);
    
    // draw trash can edges
    edgeLine_left.draw();
    edgeLine_right.draw();
    
    // draw images
    space_station.draw(100, 200, 75, 75);
    satellite.draw(300, 50, 50, 50);
    ufo.draw(400, 400, 40, 40);
    ufo.draw(500, 550, 40, 40);
    pace_capsule.draw(600, 500, 50, 50);
    venus.draw(850, 275, 60, 60);
    saturn.draw(230, 530, 75, 75);
    sun.draw(700, 175, 75, 75);
    jupiter.draw(500, 275, 80, 80);
    earth.draw(20, 455, 50, 50);
    uranus.draw(920, 645, 30, 30);
    moon.draw(550, 145, 50, 50);
    rocket.draw(800, 540, 50, 50);
    rocket.draw(205, 435, 50, 50);
    
    // draw trash can
    trashCanBuilder();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    
    if(key == 'c') {
        lines.clear();
        edges.clear();
        circles.clear();
        
        lineBuilder();
        
        last_time = ofGetElapsedTimef();
    }
    
    if(key == 'r') {
        lines.clear();
        edges.clear();
        circles.clear();
        trashX = round(ofRandom(5, ofGetWindowWidth() - 50));
        
        edgeLine_left.clear();
        edgeLine_right.clear();
        
        edgeLine_left.addVertex(trashX, ofGetWindowHeight() - 65);
        edgeLine_left.addVertex(trashX + 3, ofGetWindowHeight());
        edgeLine_left.setPhysics(0.0, 0.5, 0.5);
        edgeLine_left.create(box2d.getWorld());
        
        edgeLine_right.addVertex(trashX + 50, ofGetWindowHeight() - 65);
        edgeLine_right.addVertex(trashX + 47, ofGetWindowHeight());
        edgeLine_right.setPhysics(0.0, 0.5, 0.5);
        edgeLine_right.create(box2d.getWorld());
        
        last_time = ofGetElapsedTimef();

    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
    
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {
    lines.back().addVertex(x, y);
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    lines.push_back(ofPolyline());
    lines.back().addVertex(x, y);
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {
    
    auto edge = std::make_shared<ofxBox2dEdge>();
    lines.back().simplify();
    
    for (auto i=0; i<lines.back().size(); i++) {
        edge.get()->addVertex(lines.back()[i]);
    }
    
    edge.get()->create(box2d.getWorld());
    edges.push_back(edge);
}

void ofApp::lineBuilder() {
    // load the line shapes
    
    ofBuffer buffer = ofBufferFromFile("lines.txt");
    
    for (auto line: buffer.getLines()) {
        vector <string> pts = ofSplitString(line, ",");
        if(pts.size() > 0) {
            auto edge = std::make_shared<ofxBox2dEdge>();
            for (auto j=0; j<pts.size(); j+=2) {
                if(pts[j].size() > 0) {
                    float x = ofToFloat(pts[j]);
                    float y = ofToFloat(pts[j+1]);
                    edge.get()->addVertex(x, y);
                }
            }
            edge.get()->create(box2d.getWorld());
            edges.push_back(edge);
        }
    }
}

void ofApp::trashCanBuilder() {
    trash_can.draw(trashX, ofGetWindowHeight() - 65, 50, 65);
    //306, 768
}

