#include <Wire.h>
#include <Firmata.h>

char val;
int ledPin = 13;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  while (Serial.available()) {
    val = Serial.read();
    Serial.print(val);
  }
//    val = Serial.read();
//    Serial.println(val);
  if (val == 'H') {
    digitalWrite(ledPin, HIGH);
  }
  else {
    digitalWrite(ledPin, LOW);
  }
  delay(100);
}

