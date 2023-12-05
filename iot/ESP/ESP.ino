//*******************************libraries********************************
//RFID-----------------------------
#include <SPI.h>
#include <MFRC522.h>
//ESP32--------------------------
#include <WiFiManager.h>
#include <LiquidCrystal_I2C.h>
#include <PubSubClient.h>
#include <HTTPClient.h>

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
const char* SSID = "ADJUST-YOUR-SSID";
const char* PASSWORD = "ADJUST-YOUR-PASSWORD";
const char* mqtt_server = "broker.hivemq.com";
const int mqtt_port = 1883;
const String validOTP = "1234";
const static String serverName = "https://absence-system.vercel.app/";
const static int interval = 30000;


void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.println(topic);
  Serial.print("Message: ");
  String receivedMsg;
  for (int i = 0; i < length; i++) {
    receivedMsg += (char)payload[i];
  }

  Serial.println(receivedMsg);

  if (String(topic) == "esp32/otpRequest") {
    bool isVerified = verifyOTP(receivedMsg);
    if (isVerified) {
      Serial.println("Success");
      ClientMQTT.publish("esp32/otpResponse", "Success");
    } else {
      Serial.println("Failed");
      ClientMQTT.publish("esp32/otpResponse", "Failed");
    }
  }
}

bool verifyOTP(String receivedOTP) {
  return receivedOTP == validOTP;
}

void mqtt_reconnect() {
  while (!ClientMQTT.connected()) {
    Serial.println("Attempting MQTT connection...");
    if (ClientMQTT.connect("ESPTesting")) {
      Serial.println("connected");
      ClientMQTT.subscribe("esp32/otpRequest");
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

void vTaskReadCard(void* params) {
  while (1) {
    if (millis() - previousMillis >= 15000) {
      previousMillis = millis();
      OldCardID = "";
    }
    vTaskDelay(50 / portTICK_PERIOD_MS);

    // Look for a new card
    if (!RFC.PICC_IsNewCardPresent()) {
      continue;  // Get to the start of the loop if there is no card present
    }
    // Select one of the cards
    if (!RFC.PICC_ReadCardSerial()) {
      continue;  // If read card serial(0) returns 1, the uid struct contains the ID of the read card.
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

    Serial.println(CardID);
    LCD.setCursor(0, 0);
    LCD.print(CardID);
    LCD.setCursor(0, 1);
    LCD.print("Tapped");
    vTaskDelay(5000 / portTICK_PERIOD_MS);
    LCD.clear();
  }
}

void setup() {
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
  xTaskCreatePinnedToCore(vTaskMQTTConnection, "Handle MQTT Connection Task", 2 * 1024, NULL, 3, NULL, 1);
  xTaskCreatePinnedToCore(vTaskWiFiConnection, "Handle Wi-Fi Connection Task", 1 * 1024, NULL, 2, NULL, 1);
  xTaskCreatePinnedToCore(vTaskReadCard, "Read Card Task", 2 * 1024, NULL, 1, NULL, 0);
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
