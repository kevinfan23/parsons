// ---------------------------------------------------------------------------
// Adapted from the NewPing library example
// ---------------------------------------------------------------------------

#include <NewPing.h>

int RED_PIN = 3;
int GREEN_PIN = 5;
int BLUE_PIN = 6;

/***brightness control variables***/
int redBrightness = 247;
int greenBrightness = 143;
int blueBrightness = 166;
#define TRIGGER_PIN  12 
#define ECHO_PIN     11
#define MAX_DISTANCE 200

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup() {
  Serial.begin(9600);
}

void loop() {
  delay(50); 
  unsigned int uS = sonar.ping(); // Send ping, get ping time in microseconds (uS).
  Serial.print("Distance: ");
  Serial.print(uS / US_ROUNDTRIP_CM); // Convert ping time to distance in cm and print result (0 = outside set distance range)
  Serial.println("cm");

  int cm = uS / US_ROUNDTRIP_CM;

  if (cm <= 50) {

    int br = map(cm, 0, 50, 255, 0);
//    analogWrite(RED_PIN, br);
//    analogWrite(GREEN_PIN, 0);
//    analogWrite(BLUE_PIN, 0);

//
//    analogWrite(RED_PIN, 255);
//    analogWrite(GREEN_PIN, 255);
//    analogWrite(BLUE_PIN, 0);

    analogWrite(RED_PIN, 0);
    analogWrite(GREEN_PIN, 255);
    analogWrite(BLUE_PIN, 0);
  }
  else {
    analogWrite(RED_PIN, 0);
    analogWrite(GREEN_PIN, 0);
    analogWrite(BLUE_PIN, 0);
  }

//  delay(300);
  delay(cm*10);
    if (cm >= 10) {
      analogWrite(RED_PIN, 0);
      analogWrite(GREEN_PIN, 0);
      analogWrite(BLUE_PIN, 0);
    }
}

long microsecondsToCentimeters(long microseconds) {
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the object we
  // take half of the distance travelled.
  return microseconds / 29 / 2;
}

//#include <Wire.h>
//#include <Firmata.h>
//
///***declaring RGB pins in PWM mode***/
//int RED_PIN = 3;
//int GREEN_PIN = 5;
//int BLUE_PIN = 6;
//
///***brightness control variables***/
//int redBrightness = 247;
//int greenBrightness = 143;
//int blueBrightness = 166;
////247, 143, 166
//char * val;
//char data[] = "";
//
//  
//void setup() {
//
//  Serial.begin(9600);         //initialising serial monitor
//
//  /***Pin mode declaration***/
//  pinMode(RED_PIN, OUTPUT);
//  pinMode(GREEN_PIN, OUTPUT);
//  pinMode(BLUE_PIN, OUTPUT);
//}
//
//void loop() {
////    while (Serial.available()) {
//////      for (int n = 0; n < 3; n++) {
//////         val[n] = Serial.read();
//////      }
////////      Serial.print(val);
////    int num = Serial.readBytesUntil('\n', 80);
////    val = strtok (data, ","); 
////    }
//
//  /***sending variable voltages to RGB led***/
//  analogWrite(RED_PIN, redBrightness);
//  analogWrite(GREEN_PIN, greenBrightness);
//  analogWrite(BLUE_PIN, blueBrightness);
//  delay(3000);
//}
