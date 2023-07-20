import 'dart:developer';
import 'package:cariera/models/user_model.dart';
import 'package:cariera/services/service_repo.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/general_view_model.dart';
import 'package:cariera/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../views/dashboard_view.dart';
import '../views/my_listing_view.dart';
import '../widgets/no_login_listing.dart';

class ProfileViewModel extends BaseViewModel {
  late SharedPreferences sp;
  String? _userID;
  String? get userID => _userID;
  String? _firstName;
  String? get firstName => _firstName;
  String? _username;
  String? get username => _username;
  String? _token;
  String? get token => _token;

  String? _role;
  String? get role => _role;
  User? _user;
  User? get user => _user;
  bool _isCandidate = false;
  bool get isCandidate => _isCandidate;
  initSP() async {
    sp = await SharedPreferences.getInstance();
    _userID = sp.getString(AppConstants.userID);
    _firstName = sp.getString(AppConstants.firstName);
    _firstName = sp.getString(AppConstants.firstName);
    _username = sp.getString(AppConstants.displayName);
    _role = sp.getString(AppConstants.role);
    _token = sp.getString(AppConstants.authToken);
    if (_role == 'candidate') {
      _isCandidate = true;
    }

    notifyListeners();
    if (_userID != null) {
      userDetails(_userID);
    }
  }

  userDetails(id) async {
    Map<String, dynamic>? response = await ServiceRepo.getData(
        api: AppConstants.user + id,
        headers: {'Authorization': 'Bearer ${_token!}'});
    log('$response');
    debugPrint('===========>Response:$response');
    if (response != null) {
      _user = User.fromMap(response);
    }

    notifyListeners();
  }

  loginLogout() {
    if (_userID != null) {
      GeneralViewModel.removeSPAuth();
      _userID = null;

      notifyListeners();
      Get.offAll(() => DashboardView());
    } else {
      Get.to(() => LoginView());
    }
  }

  gotoListing(title, type, url, user) {
    if (_userID != null) {
      Get.to(
          () => MyListingView(title: title, type: type, url: url, user: user));
    } else {
      Get.to(() => NoLoginListing());
    }
  }
}
