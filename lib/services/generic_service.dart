// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cariera/utils/constant.dart';
import 'package:http/http.dart' as http;

class GenericService {
  static Future search(String api, String query) async {
    String url = api + query;
    var jsonData, error;
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        error = jsonDecode(response.body);
        if (error.containsKey('message')) {
          error = error['message'];
        } else {
          error = 'Something went wrong!';
        }
        jsonData = {'error': error};
        return [];
      }
    } on TimeoutException catch (_) {
      jsonData = {'error': 'request timeout!'};

      return [];
    } on SocketException catch (_) {
      jsonData = {'error': 'request not found!'};

      return [];
    }
  }

  static Future company(String id) async {
    String url = '${AppConstants.company}/$id?_embed=1';
    var jsonData, error;
    try {
      var response = await http.get(Uri.parse(url), headers: {
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
    } on TimeoutException catch (_) {
      jsonData = {'error': 'request timeout!'};
    } on SocketException catch (_) {
      jsonData = {'error': 'request not found!'};
    }

    return jsonData;
  }

  static getImageBytes(String url) async {
    var dataBytes;
    var request = await http.get(Uri.parse(url));
    // ignore: unused_local_variable
    var bytes = request.bodyBytes;
    // print(dataBytes.buffer.asUint8List());
    return dataBytes.buffer.asUint8List();
  }

  static Future delete(String api, var header) async {
    var jsonData, error;
    try {
      var response = await http
          .delete(Uri.parse(api), headers: header)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        error = jsonDecode(response.body);
        if (error.containsKey('message')) {
          error = error['message'];
        } else {
          error = 'Something went wrong!';
        }
        jsonData = {'error': error};
        return [];
      }
    } on TimeoutException catch (_) {
      jsonData = {'error': 'request timeout!'};

      return [];
    } on SocketException catch (_) {
      jsonData = {'error': 'request not found!'};

      return [];
    }
  }
}
