int sensorPin = A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int analogValue = analogRead(sensorPin)/4;
  Serial.write(analogValue);
}
