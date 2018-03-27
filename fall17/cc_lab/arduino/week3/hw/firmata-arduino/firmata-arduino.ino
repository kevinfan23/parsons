#include <Wire.h>
#include <Firmata.h>

char val;
int greenLedPin = 13;
int redLedPin = 12;

void setup() {
  pinMode(greenLedPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  while (Serial.available()) {
    val = Serial.read();
    Serial.print(val);
  }
//    val = Serial.read();
//    Serial.println(val);
  if (val == 'G') {
    digitalWrite(greenLedPin, HIGH);
    digitalWrite(redLedPin, LOW);
  }
  else if (val == 'R') {
    digitalWrite(redLedPin, HIGH);
    digitalWrite(greenLedPin, LOW);
  }
  else {
    digitalWrite(greenLedPin, LOW);
    digitalWrite(redLedPin, LOW);
  }
  delay(100);
}

