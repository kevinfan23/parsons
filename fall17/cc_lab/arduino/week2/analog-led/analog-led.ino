int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 9;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor
int alpha;

void setup() {
  // setup serial monitor
  Serial.begin(9600); 
  
  // declare the ledPin as an OUTPUT:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  sensorValue = analogRead(sensorPin);
  //Serial.println("Top of loop");  

  // read value from the potentiometer
  Serial.println(sensorValue);
  // map the resistence to 
  alpha = map(sensorValue, 0, 1023, 0, 255);
  
  // turn the ledPin on with mapped alpha value
  digitalWrite(ledPin, alpha);
}
