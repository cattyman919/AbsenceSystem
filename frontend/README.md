# Frontend Attendance System


## 🌟 Introduction

Welcome to the frontend of the AbsenceSystem, an intuitive and user-friendly interface built with Flutter. This part of the project is designed to provide a seamless experience for managing absences in educational or organizational settings.

## 🚀 Features
- **Cross-Platform Compatibility**: Built with Flutter, the frontend is designed to run smoothly on both iOS and Android, as well as web platforms.
- **User-Friendly Interface**: Offers a clean and intuitive interface, making it easy for users to navigate and perform tasks.
- **Role-Based Views**: Tailored views for different user roles such as students, teachers, and administrators.
- **Real-Time Updates**: Integrated with the backend to provide real-time updates and notifications.
- **Secure and Reliable**: Implements best practices in security and data handling.

## Getting Started
These instructions will guide you through setting up the project on your local machine for development and testing purposes.

### Prerequisites
Ensure you have the following installed:

Flutter (See Flutter installation guide)
An IDE (Preferably Android Studio or VSCode)

### Instalation
Clone the Repository
```
git clone https://github.com/cattyman919/AbsenceSystem.git
cd AbsenceSystem/frontend
```
Install Dependencies
```
flutter pub get
```
Run the Application
```
flutter run
```
## Views
### Dosen Login Views
- ``dosen_login_view.dart``: This view provides the login interface for lecturers.
- ``dosen_login_view.form.dart``: This file might handle the form logic for the Dosen login view.
- ``dosen_login_viewmodel.dart``: The ViewModel for the Dosen login, handling the business logic and state management for this view.

### Dosen Register Views
- ``dosen_register_view.dart``: A view for lecturers to register or create an account.
- ``dosen_register_view.form.dart``: Manages the form logic for Dosen registration.
- ``dosen_register_viewmodel.dart``: The ViewModel for the Dosen registration process.
  
### Kelas Views
- ``kelas_view.dart``: A view related to class for managing or viewing attendance information.
- ``kelas_viewmodel.dart``: The ViewModel for the Kelas view.

### Kelas Dashboard Views
- ``kelasDashboard_view.dart``: A view to display and manage classes.
- ``kelasDashboard_viewmodel.dart``: ViewModel managing the state and logic of the Kelas Dashboard.

### Mahasiswa OTP Views
- ``mahasiswa_otp_view.dart``: A view for one-time password (OTP) system to mark attendance for students.
- ``mahasiswa_otp_view.form.dart``: Manages the OTP form logic for student authentication.
- ``mahasiswa_otp_viewmodel.dart``: ViewModel for the Mahasiswa OTP process.
  
### Mahasiswa Register Views
- ``mahasiswa_register_view.dart``: A registration view for students.
- ``mahasiswa_register_view.form.dart``: Handles the form logic for student registration.
- ``mahasiswa_register_viewmodel.dart``: The ViewModel for the student registration view.
