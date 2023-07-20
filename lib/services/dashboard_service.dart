// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cariera/utils/constant.dart';

class DasgboardService {
  Future jobs(int page, url) async {
    page = jobsPerPage * page;
    // ignore: no_leading_underscores_for_local_identifiers
    final _url = url + '&per_page=$jobsPerPage&offset=$page';
    var jsonData, error;
    try {
      var response = await http.get(Uri.parse(_url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 30));
      // ignore: avoid_print
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

  texonomy(String url) async {
    var jsonData, error;
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 30));
      // ignore: avoid_print
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
