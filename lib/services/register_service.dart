// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cariera/utils/constant.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  Future register(String username, String email, String password, String role,
      String phone) async {
    String url = AppConstants.register;
    var jsonData, error, body;
    body = {
      'username': username,
      'email': email,
      'password': password,
      'user_url': phone,
      'role': role
    };
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
      } else {
        error = jsonDecode(response.body);
        if (error.containsKey('message')) {
          error = error['message'];
        } else {
          error = 'Something went wrong!';
        }
        jsonData = {'error': error};
      }

      return jsonData;
    } on TimeoutException catch (_) {
      jsonData = {'error': 'request timeout!'};

      return jsonData;
    } on SocketException catch (_) {
      jsonData = {'error': 'request not found!'};

      return jsonData;
    }
  }
}
