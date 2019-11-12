#include <ESP8266WiFi.h>                                                // esp8266 library
#include <FirebaseArduino.h>                                             // firebase library

#define FIREBASE_HOST "areyouokey-4eb83.firebaseio.com"
#define FIREBASE_AUTH "8LIylwafgJubtZha3xSLL5JoAKnDfeNpwxnRTAmM"
#define WIFI_SSID "BabaFingo"
#define WIFI_PASSWORD "yaskopolo26"                                 //password of wifi ssid

String fireStatus = "";    
float enlem = 0.000;                                               // led status received from firebase
float boylam = 0.000;
int led = D3;                                                                // for external led
void setup() {
  Serial.begin(9600);
  delay(1000);
  pinMode(LED_BUILTIN, OUTPUT);      
  pinMode(led, OUTPUT);                 
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                      //try to connect with wifi
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected to ");
  Serial.println(WIFI_SSID);
  Serial.print("IP Address is : ");
  Serial.println(WiFi.localIP());                                                      //print local IP address
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);                                       // connect to firebase
 
}

void loop() {

  enlem =  Firebase.getFloat("Latitude");
  Serial.print("Enlem : ");
  Serial.println(enlem,6);
  boylam = Firebase.getFloat("Longitude");
  Serial.print("Boylam : ");
  Serial.println(boylam,5);

}
