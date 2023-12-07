import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/models/kelas.model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();

  final _dialogService = locator<DialogService>();
  final localhostIP = "http://10.0.2.2:3000";
  final deployURL = "https://absence-system.vercel.app";

  String get currentURL => deployURL;
  final Duration timeoutDuration = const Duration(seconds: 10);

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$currentURL/dosen/login'),
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(timeoutDuration);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 201) {
        await storage.write(
          key: 'username',
          value: responseJson['username'],
        );
      } else if (response.statusCode == 400)
        throw responseJson['message'];
      else {
        throw Exception('Wrong Credentials');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Kelas>> fetchKelas() async {
    try {
      List<Kelas> kelasList = [];
      final response = await http
          .get(
            Uri.parse('$currentURL/kelas'),
          )
          .timeout(timeoutDuration);
      final body = jsonDecode(response.body);

      for (var i = 0; i < body.length; i++) {
        var kelas = Kelas.fromJson(body[i] as Map<String, dynamic>);
        kelasList.add(kelas);
      }

      return kelasList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createKelas(String nama) async {
    try {
      final response = await http.post(Uri.parse('$currentURL/kelas/'),
          body: {'nama': nama}).timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteKelas(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('$currentURL/kelas/$id'))
          .timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<AbsenKelas> fetchAbsenKelas(int idKelas, int mingguKe) async {
    try {
      AbsenKelas absenKelas = AbsenKelas(hadir: [], tidakHadir: []);
      final response = await http
          .get(
            Uri.parse('$currentURL/absensi/kelas/$idKelas/minggu/$mingguKe'),
          )
          .timeout(timeoutDuration);
      final body = jsonDecode(response.body);

      absenKelas = AbsenKelas.fromJson(body);

      return absenKelas;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAbsensi(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('$currentURL/absensi/$id'))
          .timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$currentURL/dosen/register'),
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(timeoutDuration);

      if (response.statusCode == 201) return;

      final responseJson = json.decode(response.body);

      if (response.statusCode == 400) {
        throw responseJson['message'];
      } else {
        throw "Failed to create account";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerMahasiswa(
      String nama, String npm, String rfidTag, List<int> kelasIds) async {
    var bodyData = {
      'nama': nama,
      'npm': npm,
      'rfid_tag': rfidTag,
    };
    for (int i = 0; i < kelasIds.length; i++) {
      bodyData.addAll({'kelasIds[$i]': kelasIds[i].toString()});
    }
    try {
      final response = await http
          .post(Uri.parse('$currentURL/mahasiswa/register'), body: bodyData)
          .timeout(timeoutDuration);

      if (response.statusCode == 201) return;

      final responseJson = json.decode(response.body);

      if (response.statusCode == 400) {
        throw responseJson['message'];
      } else {
        throw "Failed to create account";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'username');
  }

  Future<bool> isLoggedIn() async {
    final username = await storage.read(key: 'username');

    return (username != null);
  }
}
