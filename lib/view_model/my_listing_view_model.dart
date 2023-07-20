import 'dart:async';

import 'package:cariera/services/my_listing_service.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../models/job_model.dart';
import '../services/generic_service.dart';

class MyListingViewModel extends BaseViewModel {
  final MyListingService _service = MyListingService();
  List<JobModel?>? _myListing = [];
  List<JobModel?>? get myListing => _myListing;
  late SharedPreferences sp;
  String? userID;
  int page = 0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get getRefresh => _refreshController;

  Future<List<JobModel?>?> getListing(url, {int page = 0}) async {
    _isLoading = true;
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    userID = sp.getString(AppConstants.userID);
    List data = await _service.listing(url + userID, page: page);

    if (data.isEmpty) {
      _myListing = [];
    } else {
      _myListing = data.map((job) => JobModel.fromMap(job)).toList();
    }
    _isLoading = false;

    notifyListeners();
    return _myListing;
  }

//REFRESH & PAGINATION
  onLoading(url) async {
    page++;
    List data = await _service.listing(url + userID, page: page);
    List<JobModel?> b = data.map((job) => JobModel.fromMap(job)).toList();
    _myListing!.addAll(b);
    _refreshController.loadComplete();
    notifyListeners();
  }

  onRefresh(url) async {
    _myListing = await getListing(url);
    _refreshController.refreshCompleted();
    page = 0;
    notifyListeners();
  }

  deleteListing(String id, String type, String url) async {
    String token = sp.getString(AppConstants.authToken)!;
    var header = {"Authorization": 'Bearer $token'};
    var response = await GenericService.delete(getAPI(id, type), header);
    if (response.containsKey('error')) {
      Method.showToast('Faild to delete');
    } else {
      Method.showToast('Delete successfully!');
      getListing(url);
    }
  }

  String getAPI(String id, String type) {
    late String api;
    if (type == 'job') {
      api = AppConstants.deleteJobs;
    } else if (type == 'company') {
      api = AppConstants.deleteCompany;
    } else if (type == 'resume') {
      api = AppConstants.deleteResume;
    }
    return api + id;
  }
}
