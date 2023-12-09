# 🚀 DanceRTOS - FreeRTOS ESP32 Attendance System

> Advanced RFID & FreeRTOS Based Attendance System with Blynk

<div align="center">
  <img src="others/images/Banner DanceRTOS.png" alt="Banner Image: DanceRTOS"/>
</div>

## 🌟 About The Project

Leveraging FreeRTOS ESP32 and RFID technology, this project offers a sophisticated attendance system integrated with a web server for efficient tracking and management, while also offering Blynk to be used by officers responsible for changing class and week the device is installed.

### 🛠️ Tech Stack

<div align="center">
  <img src="https://user-images.githubusercontent.com/25181517/186150365-da1eccce-6201-487c-8649-45e9e99435fd.png" alt="Flutter" width="50"/>
  <img src="https://user-images.githubusercontent.com/25181517/192106073-90fffafe-3562-4ff9-a37e-c77a2da0ff58.png" alt="C++" width="50"/>
  <img src="https://user-images.githubusercontent.com/25181517/183890598-19a0ac2d-e88a-4005-a8df-1ee36782fde1.png" alt="TypeScript" width="50"/>
  <img src="https://github.com/marwin1991/profile-technology-icons/assets/136815194/519bfaf3-c242-431e-a269-876979f05574" alt="NestJS" width="50"/>
  <img src="https://avatars.githubusercontent.com/u/11541426?v=4" alt="Blynk" width="50"/>
</div>

## ⚙️ Features

- 📡 RFID integration for quick attendance recording.
- 💻 Web server functionality for remote management by lecturers. Students can also register their card and do OTP verification for attendance.
- ⏱️ Real-Time Data Processing with FreeRTOS.
- 📱 Blynk for modular positioning and weekly management

## 🚀 Getting Started

```bash
# Depends on which repository you're cloning from
# Main Repository
git clone https://github.com/cattyman919/AbsenceSystem
# OR Official Fork
git clone https://github.com/styxnanda/RTOS32-Attendance.git

# To run backend, refer to the README.md located inside ./backend
cd backend
cat README.md

# To run the frontend, refer to the README.md located inside ./frontend
cd ../frontend # Relative to ./backend
cat README.md

# To run the ESP code, open Arduino IDE and open the ./iot/ESP/ESP.ino file
cd ../iot/ESP
```

## 💡Explanation
### Hardware Design and Implementation
<div align="center">
  <img src="others/images/Hardware Implementation.png" alt="Hardware Design: DanceRTOS"/>
</div>

For implementation of the hardware code, please refer to the [IOT directory](./iot/) . RFC522 module is used to scan the RFID cards. LCD I2C Adapter Module is used to make pin usage more efficient, by multiplexing the LCD pins into simple 4 pins.

### Network Infrastructure
<div align="center">
  <img src="others/images/Network Scenario.png" alt="Network Infrastructure"/>
</div>

### Software Implementation Details
For details regarding the mobile application, please check the [frontend README.md](./frontend/README.md), while the features can be seen at the [backend README.md](./backend/README.md). The mobile application is used by the students to enter the class by verifying a random OTP given by the ESP32. This OTP is transported via MQTT between the student's phone and ESP32. Lecturers use the mobile application to observer the attendance log and also have the right to delete a student's attendance record. This is useful if lecturers catch a student who skips the class. Administrators can use a dedicated Blynk app to change the class and week setting of the ESP32. It can be modular if DanceRTOS is to be distributed to different classes/courses. The following image is the mobile app used by lecturer to monitor attendance.

The following images are the mobile app for lecturer to monitor attendance (left) and for student to enter OTP when entering a class (right).

<div style="display: flex">
  <img src="others/images/App1.png" alt="Monitor Image"/>
  <img src="others/images/App2.png" alt="OTP Image"/>
</div>

While the following is the Blynk app used by administrator to change class and week setting of the ESP32.

<div align="center">
  <img src="others/images/Blynk1.png" alt="Blynk App">
</div>

### Test Results
All acceptance criterias (refer to Powerpoint) are passed, however the performance is definitely a parameter to be heavily optimized. The HTTP requests take simply too long using even higher bandwidth Wi-Fi, including 100 Mbps. This leads to a slow response of the device.

## 📸 Device in Action

### When tapping the first time ever (student hasn't owned an account)

<div align="center">
  <img src="others/images/LCD First Ever Tap.png" alt="LCD Unregistered">
</div>

### When tapping the first time to enter class (student owns an account)
Student is asked to enter the given OTP in LCD at the mobile app.
<div align="center">
  <img src="others/images/LCD-OTP.png" alt="LCD Display OTP">
</div>

If student enters the correct OTP, the following message appears (Name and NPM).

<div align="center">
  <img src="others/images/LCD-OTP-Verified.png" alt="LCD OTP Verified">
</div>

### When tapping the second time to leave class
<div align="center">
  <img src="others/images/LCD-Leave.png" alt="LCD Leave Class">
</div>