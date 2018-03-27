import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;        // Data received from the serial port
boolean firstContact = false;

void setup()
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void draw() {
}

void serialEvent(Serial myPort) {
  val = myPort.readStringUntil('\n');

  if (val != null) {
    val = trim(val);
    println(val);
  }

  if (firstContact == false) {
    if (val.equals('A')) {
      myPort.clear();
      firstContact = true;
      myPort.write("A");
      println("contact");
    }
  }
  else {
    println(val);

    if (mousePressed == true) {
      myPort.write('1');
      println('1');
    }
    myPort.write('A');
  }
}