// a simple sketch for toggle button state
// to controll servo output

#include <Servo.h>

Servo myservo;

const int buttonPin = 2;     // the number of the pushbutton pin
const int servoPin =  9;      // the number of the LED pin

// variables will change:
int buttonState;         // variable for reading the pushbutton status
int prevState = 0;         // variable for reading the previous pushbutton status

void setup() {
  myservo.attach(servoPin);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
}

void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);
  
  if (buttonState == HIGH) {
    if (prevState) {
     myservo.write(0);
     delay(1000);
    }
    else {
      myservo.write(90);
      delay(1000);
    }
    
    prevState = !prevState;
  }

  //prevState = buttonState;
  
//  if (buttonState != prevState) {
//    myservo.write(0);
//    buttonState != prevState;
//    prevState = buttonState;
//  }
//  else {
//    myservo.write(90);
//  }
}
