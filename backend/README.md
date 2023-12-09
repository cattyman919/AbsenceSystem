# Backend Attendance System

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest
  
  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>

  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->

## 🌟 Introduction

The backend of the AbsenceSystem is built using the Nest framework, a progressive Node.js framework ideal for building efficient and scalable server-side applications. This part of the system is responsible for handling the business logic, data processing, and interactions with the database.

## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```
## 🚀 Features

- **Modular Structure**: Organized into modules like absensi, dosen, kelas, and mahasiswa, each handling different aspects of the absence management system.
- **Database Integration**: A dedicated module for database interactions, ensuring efficient data management and retrieval.
- **RESTful API**: Provides a set of API endpoints for various operations related to absence management, accessible by the frontend.
- **Scalability and Efficiency**: Leveraging NestJS's capabilities for building scalable and efficient server-side applications.
  
## HTTP Methods and Endpoints

### Absensi Controller
- ``GET /absensi/kelas/:idKelas/minggu/:mingguKe``: Retrieves attendance for a class in a specific week.
- ``GET /absensi/kelas/:idKelas/minggu/:mingguKe/rfid/:rfid``: Retrieves individual attendance based on RFID.
- ``POST /absensi/absen-masuk``: Marks entry attendance.
- ``POST /absensi/absen-keluar``: Marks exit attendance.
- ``GET /absensi``: Retrieves all attendance records.
- ``DELETE /absensi/:id``: Deletes a specific attendance record.
  
### Dosen Controller
- ``POST /dosen/register``: Registers a new lecturer.
- ``POST /dosen/login``: Logs in a lecturer.
- ``GET /dosen``: Retrieves all lecturers.

### Kelas Controller
- ``POST /kelas``: Creates a new class.
- ``GET /kelas``: Retrieves all classes.
- ``DELETE /kelas/:id``: Deletes a specific class.

### Mahasiswa Controller
- ``POST /mahasiswa/register``: Registers a new student.
- ``GET /mahasiswa``: Retrieves all students.
- ``GET /mahasiswa/rfid/:rfid``: Retrieves a student by RFID.
