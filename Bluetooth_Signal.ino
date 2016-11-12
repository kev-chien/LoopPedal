/*
 * Bluetooth Signal 
 */

#include <C:/Intel/curie-ble.h>
 
const int bluetoothTx = 2;
const int bluetoothRx = 3;

const int switchPin = 4;     // the number of the switch pin
const int ledPin =  13;      // the number of the LED pin

int switchState = 0;         // variable for reading the switch status
int btSignal = 0;            // signal to send to bluetooth device

BLEPeripheral blePeripheral; // create peripheral instance
BLEService UUID("19B10010-E8F2-537E-4F6C-D104768A1214"); // create service

BLECharCharacteristic ledCharacteristic("19B10010-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite);
BLECharCharacteristic switchCharacteristic("19B10010-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);


void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(switchPin, INPUT);
  
  blePeripheral.setLocalName("ArduinoBluetooth");
  blePeripheral.setAdvertisedServiceUuid(ledService.uuid());

  blePeripheral.addAttribute(ledService);
  blePeripheral.addAttribute(ledCharacteristic);
  blePeripheral.addAttribute(switchCharacteristic);

  ledCharacteristic.setValue(0);
  switchCharacteristic.setValue(0);

  blePeripheral.begin();

  Serial.println("Bluetooth device active, waiting for connections...");
}


void loop() {
  blePeripheral.poll();
  
  char switchState = digitalRead(buttonPin);

  boolean switchChanged = (buttonCharacteristic.value() != switchState);

  if (switchChanged) {
    ledCharacteristic.setValue(switchValue);
    switchCharacteristic.setValue(switcbValue);
  }

  if (ledCharacteristic.written() || switchChanged) {
    // update LED, either central has written to characteristic or button state has changed
    if (ledCharacteristic.value()) {
      Serial.println("LED on");
      digitalWrite(ledPin, HIGH);
      btSignal = 1;
    } else {
      Serial.println("LED off");
      digitalWrite(ledPin, LOW);
      btSignal = 0;
    }
  }
}
