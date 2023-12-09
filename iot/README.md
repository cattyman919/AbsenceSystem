# ESP32 IoT Attendance System

## Introduction
DanceRTOS is a project developed for the Internet of Things and Real-Time Operating Systems course at Universitas Indonesia. It aims to provide a convenient and efficient way to track attendance using ESP32 microcontroller.

## ✨ Features
📊 Real-time attendance tracking

🌐 Web-based administration panel

🔌 Blynk integration to choose class and week

## 📚 Libraries

This project uses the following libraries:

- **SPI.h**: A library that provides communication via the Serial Peripheral Interface (SPI).
- **MFRC522.h**: A library for using RFID module MFRC522.
- **WiFiManager.h**: A library that allows you to manage Wi-Fi connections.
- **LiquidCrystal_I2C.h**: A library for the Liquid Crystal LCDs connected to an I2C bus.
- **PubSubClient.h**: A client library for MQTT messaging.
- **HTTPClient.h**: A library to send HTTP requests.
- **BlynkSimpleEsp32.h**: A library for Blynk to run on ESP32.
- **ArduinoJson.h**: A library to easily serialize and deserialize JSON documents.

Please ensure you have these libraries installed. If not, you can install them via the Library Manager in the Arduino IDE.

## 🚀 Tasks

The program is divided into several tasks that run concurrently:

- **vTaskCardRead**: This task is responsible for reading taps from a student's card.

- **vTaskBlynkRun**: This task is related to the Blynk daemon ensuring that connection is kept alive throughout the program.

- **vTaskWiFiConnection**: This task handles the WiFi connection for the ESP device throughout the lifecycle of the device. It ensures connectivity remains, such as reconnecting when disconnected.

- **vTaskMQTTConnection**: This task is responsible for establishing a connection with an MQTT broker. It involves tasks like connecting to the broker and subscribing to a topic.

These tasks allow the ESP device to efficiently handle multiple operations simultaneously. Each task runs independently, allowing the system to perform various tasks concurrently without blocking or delaying other operations.
