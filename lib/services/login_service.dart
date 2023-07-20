
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cariera/utils/constant.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future login(String username, String password) async {
    String url = AppConstants.login;
    Map<String, dynamic> body = {'username': username, 'password': password};
    var jsonData, error;
    try {
      var response = await http
          .post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 30));

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

  Future update(
      Uri url, Map<String, dynamic> body, Map<String, String> headers) async {
    var jsonData, error;
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));

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
