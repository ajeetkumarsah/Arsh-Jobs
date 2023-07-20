import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/job_model.dart';
import 'dashboard_service.dart';
import 'package:http/http.dart' as http;

class ServiceRepo {
  static DasgboardService jobService = DasgboardService();

  Future<List<List<JobModel>?>>? getListing(
      {int page = 0, required String url}) async {
    List data = await jobService.jobs(page, url);
    List<JobModel>? list, unFeatured = [], featured = [];
    if (data.isNotEmpty) {
      list = data.map((job) => JobModel.fromMap(job)).cast<JobModel>().toList();
    }
    if (list != null) {
      for (JobModel x in list) {
        if (x.featured == 0) {
          unFeatured.add(x);
        } else {
          featured.add(x);
        }
      }
    }
    return [featured, unFeatured];
  }

  static Future<Map<String, dynamic>?> getData(
      {required String api, Map<String, String>? headers}) async {
    headers ??
        {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
    Map<String, dynamic>? jsonData;
    String? message;
    try {
      var response = await http
          .get(Uri.parse(api), headers: headers)
          .timeout(const Duration(seconds: 30));
      jsonData = jsonDecode(response.body);
      log('$jsonData');
      if (response.statusCode != 200) {
        if (jsonData!.containsKey('message')) {
          message = jsonData['message'];
        } else {
          message = 'Something went wrong!';
        }
        jsonData = {'error': message};
      }
    } on TimeoutException catch (_) {
      jsonData = {'error': 'request timeout!'};
    } on SocketException catch (_) {
      jsonData = {'error': 'request not found!'};
    }
    return jsonData;
  }
}
