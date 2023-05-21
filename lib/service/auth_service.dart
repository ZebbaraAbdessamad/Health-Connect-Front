import 'dart:convert';
import 'package:health_connect/config/global.params.dart';
import 'package:http/http.dart' as http;

import '../model/token_manager.dart';

class AuthService {
  static const String loginUrl = '$api_url/auth/authenticate'; // Replace with your actual login endpoint URL

  Future<void> login(String email, String password, String role) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      final tokenResponse = json.decode(response.body);
      final accessToken = tokenResponse['access_token'];
      final refreshToken = tokenResponse['refresh_token'];
      TokenManager.setTokens(accessToken, refreshToken);
      print('Access token set: ${TokenManager.accessToken}');
    } else {
      throw Exception('Login failed with status code: ${response.statusCode}');
    }
  }
}
