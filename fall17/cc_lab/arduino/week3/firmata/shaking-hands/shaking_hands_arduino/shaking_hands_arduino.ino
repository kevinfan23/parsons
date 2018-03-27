#include <Wire.h>
#include <Firmata.h>

char val;
int ledPin = 13;

// state to toggle led
boolean ledState = LOW;
boolean contacted = false;


void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  establishContact();
}

void loop() {

  if (!contacted) {
      establishContact();
  }
  
  if (Serial.available()) {
    val = Serial.read();
    //Serial.print(val);
    
    if (val == '1') {
      ledState = !ledState;
      digitalWrite(ledPin, ledState);
    }
    delay(100);
  }
  else {
    Serial.println("Hello what?");
    delay(50);
  }
}

void establishContact() {
  while (Serial.available()) {
    Serial.println("in loop");
    Serial.println("A");
    delay(300);
    contacted = true;
  }
}

