#include <Wire.h>
#include "MAX30105.h"
#include <Adafruit_MLX90614.h>
#include "heartRate.h"
#include <WiFi.h>
#include <FirebaseESP32.h>

// WiFi Credentials
#define WIFI_SSID "HipoTofu"
#define WIFI_PASSWORD "paloadnaka"
// #define WIFI_SSID "Tom and Beth Wifi"
// #define WIFI_PASSWORD "Tomandbeth123321"
// Firebase Credentials
#define FIREBASE_HOST "pawlse-420c0-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "AIzaSyDybbgwlVTc0vWD6G-YaIBQ9ZHrHGMGm6s"

#define SDA_PIN 21
#define SCL_PIN 22

MAX30105 particleSensor;
Adafruit_MLX90614 mlx = Adafruit_MLX90614();

const byte RATE_SIZE = 4;
byte rates[RATE_SIZE];
byte rateSpot = 0;
long lastBeat = 0;
float bpm = random(117, 124);

int beatAvg;

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("Starting...");

  // I2C
  Wire.begin(SDA_PIN, SCL_PIN);
  Wire.setClock(100000);

  // Temp Sensor
  if (!mlx.begin(0x5A, &Wire)) {
    Serial.println("Error: MLX90614 not found!");
    while (1);
  }
  Serial.println("MLX90614 initialized.");

  // Heart Rate Sensor
  if (!particleSensor.begin(Wire, 0x57)) {
    Serial.println("Error: MAX30102 not found!");
    while (1);
  }
  Serial.println("MAX30102 initialized.");
  particleSensor.setup();
  particleSensor.setPulseAmplitudeRed(0x3F);
  particleSensor.setPulseAmplitudeGreen(0);

  // WiFi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" connected!");

  // Firebase setup
  config.host = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

}

void loop() {
  long irValue = particleSensor.getIR();

  if (checkForBeat(irValue)) {
    long delta = millis() - lastBeat;
    lastBeat = millis();
    beatsPerMinute = 60 / (delta / 1000.0);

    if (beatsPerMinute < 255 && beatsPerMinute > 20) {
      rates[rateSpot++] = (byte)beatsPerMinute;
      rateSpot %= RATE_SIZE;

      beatAvg = 0;
      for (byte x = 0; x < RATE_SIZE; x++) beatAvg += rates[x];
      beatAvg /= RATE_SIZE;
    }
  }

  float ambientTemp = mlx.readAmbientTempC();
  float objectTemp = mlx.readObjectTempC();

  Serial.print("IR="); Serial.print(irValue);
  Serial.print(", BPM="); Serial.print(beatsPerMinute);
  Serial.print(", Avg BPM="); Serial.print(beatAvg);
  Serial.print(", Ambient="); Serial.print(ambientTemp);
  Serial.print("*C, Object="); Serial.print(objectTemp); Serial.print("*C");

  if (irValue < 50000) Serial.println("                     No finger?");
  Serial.println();

  // Upload to Firebase
  Firebase.setInt(fbdo, "/Monitor/heartRate", beatAvg);
  // Firebase.RTDB.setFloat(&fbdo, "/dogMonitor/temperature/ambient", ambientTemp);
  Firebase.setFloat(fbdo, "/Monitor/temperature", objectTemp);

  delay(5000); // Send every 5 seconds
}