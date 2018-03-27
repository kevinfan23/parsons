int vertical = A0;
int horizontal = A1;
int x = 0;
int y = 0;
int TOPMARGIN = 700;
int BOTTOMMARGIN = 200;

void setup() {
  Serial.begin(9600);
}

void loop() {
  x = analogRead(vertical);
  y = analogRead(horizontal);

  delay(100);

  if(x > 600){
      Serial.println("r");
   }

   if( x< 424 ){
      Serial.println("l");
    }

   if ( y < 424 ){
      Serial.println("u");
    }

   if ( y > 600 ){
      Serial.println("d");
    }
}

