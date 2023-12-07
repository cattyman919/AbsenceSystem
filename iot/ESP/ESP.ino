#define BLYNK_TEMPLATE_ID "TMPL6rBMwxzs8"
#define BLYNK_TEMPLATE_NAME "AttendanceSystem"
#define BLYNK_AUTH_TOKEN "AJYj8CL2dzZCCrxpF7EBER7ar7WnXXC1"
//****************************^BLYNK TOKENS*******************************
//*******************************libraries********************************
//RFID-----------------------------
#include <SPI.h>
#include <MFRC522.h>
//ESP32--------------------------
#include <WiFiManager.h>
#include <LiquidCrystal_I2C.h>
#include <PubSubClient.h>
#include <HTTPClient.h>
#include <BlynkSimpleEsp32.h>

//************************************************************************
#define SS_PIN 5    // GPIO5
#define RST_PIN 27  // GPIO27
//************************************************************************
MFRC522 RFC(SS_PIN, RST_PIN);  // Create MFRC522 instance.
HTTPClient HTTP;
WiFiClient ESPClient;
PubSubClient ClientMQTT(ESPClient);

String getData, Link;
String OldCardID = "";
unsigned long previousMillis = 0;
static int lcdColumns = 18;                               // 18 columns LCD
static int lcdRows = 2;                                   // 2 rows LCD
static LiquidCrystal_I2C LCD(0x27, lcdColumns, lcdRows);  // LCD object
const char* ESP_AP_PASSWORD = "AP-ESP32";                 // Customizable ESP AP password
const char* SSID = "ADJUST-SSID";
const char* PASSWORD = "ADJUST-PASSWORD";
const char* mqtt_server = "broker.hivemq.com";
const int mqtt_port = 1883;
const static String serverName = "https://absence-system.vercel.app/";
const static int interval = 30000;
static String lastGeneratedOTP = "";
unsigned long otpValidityTime = 0;
static int classID = 0;     // Default IDLE machine
static int weekNumber = 0;  // Default IDLE machine

BLYNK_WRITE(V0) {
  switch(param.asInt()){
    case 1:
      classID = 1; // RPL ID
      break;
    case 2:
      classID = 2; // Probstok ID
      break;
    case 3:
      classID = 19; // Matek ID
      break;
    case 4:
      classID = 20; // Progdas ID
      break;
    case 5:
      classID = 21; // Kemjar ID
      break;
    default:
      classID = 0; // Default invalid class
      break;
  }
}

BLYNK_WRITE(V1) {
  weekNumber = param.asInt();
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.println(topic);
  Serial.print("Message: ");
  String receivedMsg;
  for (int i = 0; i < length; i++) {
    receivedMsg += (char)payload[i];
  }

  Serial.println(receivedMsg);

  if (String(topic) == "esp32/otpEntered") {
    if (verifyOTP(receivedMsg)) {
      Serial.println("OTP Verified.");
      LCD.clear();
      LCD.setCursor(0, 0);
      LCD.print(OldCardID);
      LCD.setCursor(0, 1);
      LCD.print("Tapped in");
      ClientMQTT.publish("esp32/otpVerificationResult", "Success");
    } else {
      Serial.println("OTP Verification Failed.");
      LCD.clear();
      LCD.setCursor(0, 0);
      LCD.print("OTP Failed.");
      ClientMQTT.publish("esp32/otpVerificationResult", "Failed");
    }
  }
}

String generateOTP() {
  String otp = "";
  for (int i = 0; i < 4; i++) {
    otp += String(random(0, 10));
  }
  return otp;
}

bool verifyOTP(String receivedOTP) {
  if (millis() - otpValidityTime <= 30000) {
    // Valid OTP under 30 seconds
    return receivedOTP == lastGeneratedOTP;
  }
  // Expired OTP
  return false;
}

void mqtt_reconnect() {
  while (!ClientMQTT.connected()) {
    Serial.println("Attempting MQTT connection...");
    String connectionID = "ESPA5" + String(random(0, 10000));
    if (ClientMQTT.connect(connectionID.c_str())) {
      Serial.println("connected");
      ClientMQTT.subscribe("esp32/otpEntered");
    } else {
      Serial.print("failed, rc=");
      Serial.print(ClientMQTT.state());
      Serial.println("Trying again in 5 seconds");
      delay(5000);
    }
  }
}

void vTaskMQTTConnection(void* params) {
  while (1) {
    if (!ClientMQTT.connected()) {
      mqtt_reconnect();
    }
    ClientMQTT.loop();
    vTaskDelay(50 / portTICK_PERIOD_MS);
  }
}

void vTaskWiFiConnection(void* params) {
  while (1) {
    unsigned long currentMillis = millis();
    // if WiFi is down, try reconnecting every 30 seconds
    if ((WiFi.status() != WL_CONNECTED) && (currentMillis - previousMillis >= interval)) {
      Serial.print(millis());
      Serial.println("Reconnecting to WiFi...");
      WiFi.disconnect();
      WiFi.reconnect();
      previousMillis = currentMillis;
    }
    vTaskDelay(100 / portTICK_PERIOD_MS);
  }
}

bool checkDBRFID(String ID) {
  String checkerURL = serverName + "mahasiswa/rfid/" + ID;

  HTTP.begin(checkerURL.c_str());

  int responseCode = HTTP.GET();
  if (responseCode == 200) {
    Serial.println("RFID exists");
    HTTP.end();
    return true;
  } else if (responseCode == 404) {
    Serial.println("RFID doesn't exist");
    HTTP.end();
    return false;
  }
}

void vTaskReadCard(void* params) {
  while (1) {
    
    if(classID == 0 || weekNumber == 0){
      Serial.println("Class/week is invalid");
      vTaskDelay(1000 / portTICK_PERIOD_MS);
      continue;
    } 
    if (millis() - previousMillis >= 15000) {
      previousMillis = millis();
      OldCardID = "";
    }
    vTaskDelay(50 / portTICK_PERIOD_MS);

    // Look for a new card
    if (!RFC.PICC_IsNewCardPresent() || !RFC.PICC_ReadCardSerial()) {
      continue;  // Get to the start of the loop if there is no card present
    }

    String CardID = "";

    // Create a string to hold the hex representation of the UID
    for (byte i = 0; i < RFC.uid.size; i++) {
      if (RFC.uid.uidByte[i] < 0x10) {
        CardID += "0";  // Add leading zero for single digit
      }
      CardID += String(RFC.uid.uidByte[i], HEX);
    }

    // Convert to uppercase
    CardID.toUpperCase();
    if (CardID == OldCardID) {
      continue;
    } else {
      OldCardID = CardID;
    }

    LCD.clear();
    if (checkDBRFID(CardID)) {
      String tapInURL = serverName + "absensi/absen-masuk?idKelas=" + String(classID) + "&rfid_mahasiswa=" + CardID + "&minggu_ke=" + String(weekNumber);
      HTTP.begin(tapInURL.c_str());
      int responseCode = HTTP.POST();

      if (responseCode == 200) {
        lastGeneratedOTP = generateOTP();
        otpValidityTime = millis();

        LCD.setCursor(0, 0);
        LCD.print("ID: ");
        LCD.print(CardID);
        LCD.setCursor(0, 1);
        LCD.print("OTP: ");
        LCD.print(lastGeneratedOTP);

        // Publish the card ID to MQTT
        String payload = CardID;
        ClientMQTT.publish("esp32/cardDetected", payload.c_str());

        Serial.println("Card ID: " + CardID + ", OTP: " + lastGeneratedOTP);
        vTaskDelay(15000 / portTICK_PERIOD_MS);
        LCD.clear();
      } else if (responseCode == 400) {
        String tapOutURL = serverName + "absensi/absen-masuk?idKelas=" + String(classID) + "&rfid_mahasiswa=" + CardID + "&minggu_ke=" + String(weekNumber);
        HTTP.begin(tapOutURL.c_str());
        int httpCode = HTTP.POST();
        if (httpCode == 200) {
          Serial.println("Student tapped out");
          LCD.clear();
          LCD.setCursor(0, 0);
          LCD.print(OldCardID);
          LCD.setCursor(0, 1);
          LCD.print("Tapped out");
        } else {
          Serial.println("Tapping out error.");
          LCD.clear();
          LCD.setCursor(0, 0);
          LCD.print("ERROR");
          LCD.setCursor(0, 1);
          LCD.print("Contact Admin");
        }
        vTaskDelay(5000 / portTICK_PERIOD_MS);
        LCD.clear();
      }
    } else {
      String payloadRegister = CardID;
      ClientMQTT.publish("esp32/cardDetected", payloadRegister.c_str());
      Serial.println("Continue registration in Mobile App");
      LCD.setCursor(0, 0);
      LCD.print("Register in App");
      vTaskDelay(3000 / portTICK_PERIOD_MS);
      LCD.clear();
    }
  }
}

void setup() {
  randomSeed(analogRead(0));
  Serial.begin(115200);
  while (!Serial)
    ;
  LCD.init();       // Initialize LCD
  LCD.backlight();  // Turn on LCD backlight
  SPI.begin();      // ESP32 SPI Configuration
  RFC.PCD_Init();   // Initialize MFRC522 card
  WiFi.begin(SSID, PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(". ");
  }
  Serial.println("");
  Serial.println("Wi-Fi Connected!");
  ClientMQTT.setServer(mqtt_server, mqtt_port);  // Setup MQTT server
  ClientMQTT.setCallback(callback);              // Setup callback function for MQTT
  xTaskCreatePinnedToCore(vTaskMQTTConnection, "Handle MQTT Connection Task", 2 * 1024, NULL, 3, NULL, 1);
  xTaskCreatePinnedToCore(vTaskWiFiConnection, "Handle Wi-Fi Connection Task", 1 * 1024, NULL, 2, NULL, 1);
  xTaskCreatePinnedToCore(vTaskReadCard, "Read Card Task", 4 * 1024, NULL, 1, NULL, 0);
  /*
  // WiFi Manager: Secure non-hardcoded approach for wi-fi connection
  WiFiManager wm;                                                // Local initialization of WiFi Manager object
  bool res = wm.autoConnect("AP ESP Group 5", ESP_AP_PASSWORD);  // Connect to Wi-Fi

  // If connection fails
  if (!res) {
    Serial.println("Failed to connect!");
  } else {  // If connectiond doesn't fail
    Serial.println("Connected to Wi-Fi!");
    ClientMQTT.setServer(mqtt_server, mqtt_port);  // Setup MQTT server
    ClientMQTT.setCallback(callback);              // Setup callback function for MQTT
    mqtt_reconnect();                              // Connect to MQTT
    xTaskCreatePinnedToCore(vTaskMQTTConnection, "Handle MQTT Connection Task", 1 * 1024, NULL, 2, NULL, 1);
    xTaskCreatePinnedToCore(vTaskReadCard, "Read Card Task", 2 * 1024, NULL, 1, NULL, 0);
  }
  */

  vTaskDelete(NULL);  // Delete loop
  /* 
  // HTTP Test Connection
  HTTP.begin(serverName.c_str());

  if (HTTP.GET() > 0) {
    Serial.println(HTTP.getString());
  }
  HTTP.end();
  */
}


void loop() {
  // Empty
}
