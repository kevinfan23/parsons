// the setup function runs once when you press reset or power the board
const int motorPin = 13;

void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(motorPin, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(motorPin, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(200);                       // wait for a second
  digitalWrite(motorPin, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
