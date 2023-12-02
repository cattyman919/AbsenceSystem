import 'dart:convert';

import 'package:iot/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _dialogService = locator<DialogService>();
  final localhostIP = "http://10.0.2.2:3000";
  final deployURL = "https://jaga-backend.vercel.app";

  String get currentURL => localhostIP;
  final Duration timeoutDuration = const Duration(seconds: 15);

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
}
