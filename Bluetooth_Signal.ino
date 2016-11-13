/*
 * Bluetooth Signal 
 */

#include <SoftwareSerial.h>
 
const int bluetoothTx = 2;
const int bluetoothRx = 3;

const int switchPin = 7;     // the number of the switch pin
const int ledPin =  13;      // the number of the LED pin

int switchState = 0;         // variable to detect state of switch
int btSignal = 0;            // signal to send to bluetooth device

SoftwareSerial bluetooth(bluetoothTx, bluetoothRx);   //the bluetooth serial

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(switchPin, INPUT);
  
  //Setup Bluetooth serial connection to iOS
  bluetooth.begin(115200);
  bluetooth.print("$$$");
  delay(100);
  bluetooth.println("U,9600,N");
  bluetooth.begin(9600);

  Serial.println("Bluetooth device active, waiting for connections...");
}


void loop() {
  
  switchState = digitalRead(switchPin);

  if (switchState == HIGH){
  digitalWrite(ledPin, HIGH);
  btSignal = 1;
  }else{
    digitalWrite(ledPin, LOW);
    btSignal = 0;
  }
  
  bluetooth.print(btSignal);
}

