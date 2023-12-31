import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:skywallet/Modules/Models/Auth/Commands/commands.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCommandsService {
  final String baseUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<Map<String, dynamic>>> addLogin(LoginModel data) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/v1/login"),
      headers: {
        "content-type": "application/json",
        'Accept': 'application/json'
      },
      body: LoginModelToJson(data),
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_key', responseData['token']);
      await prefs.setString('username_key', responseData['result']['username']);

      return [
        {
          "message": "success",
          "body": responseData['result'],
          "token": responseData['token']
        }
      ];
    } else if (response.statusCode == 422 || response.statusCode == 401) {
      // Validation failed
      return [
        {"message": "failed", "body": responseData['result'], "token": null}
      ];
    } else {
      return [
        {"message": "failed", "body": "Unknown error", "token": null}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> getsignout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
      'content-type': 'application/json',
    };
    final response = await client.get(
      Uri.parse("$baseUrl/api/v1/keuangan/count_history"),
      headers: header,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      return [
        {
          "status": "success",
          "message": responseData['message'],
        }
      ];
    } else if (response.statusCode == 401) {
      var responseData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return [
        {"status": "success", "message": responseData['message']}
      ];
    } else {
      return [
        {
          "status": "failed",
          "message": "Unknown error",
        }
      ];
    }
  }
}
