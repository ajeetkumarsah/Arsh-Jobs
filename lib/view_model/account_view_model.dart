import 'dart:developer';

import 'package:cariera/services/login_service.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../utils/methods.dart';
import 'general_view_model.dart';

class AccountViewModel extends BaseViewModel {
  late SharedPreferences sp;
  String? image, firstName, lastName, email, id;
  final LoginService _loginService = LoginService();

  // String get image => image;
  // String get firstName => firstName;
  // String get lastName => lastName;
  // String get email => email;
  // String get id => id;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  initSP() async {
    sp = await SharedPreferences.getInstance();
    firstName = sp.getString(AppConstants.firstName);
    image = sp.getString(AppConstants.userImage);
    lastName = sp.getString(AppConstants.lastName);
    email = sp.getString(AppConstants.email);
    id = sp.getString(AppConstants.userID);
    firstController.text = firstName!;
    lastController.text = lastName!;
    phoneController.text = '';
    emailController.text = email!;
    notifyListeners();
  }

  Future updateUser() async {
    try {
      loading('Updating..');
      firstName = firstController.text;
      lastName = lastController.text;
      email = emailController.text;
      if (firstName!.isEmpty || lastName!.isEmpty || email!.isEmpty) {
        Method.showToast('Fields should not empty');
      } else {
        Map<String, dynamic> body = {
          'first_name': firstName,
          'last_name': lastName,
          'email': email
        };
        String url =
            "${AppConstants.updateUser}${sp.getString(AppConstants.userID)}?context=edit";
        String? token = sp.getString(AppConstants.authToken);
        Map<String, String> headers = {"Authorization": "Bearer $token"};
        var response =
            await _loginService.update(Uri.parse(url), body, headers);

        if (response.containsKey('error')) {
          dismissLoading();
          // Method.showToast(response['error']);
          Method.showToast(response['error']);
        } else {
          dismissLoading();

          GeneralViewModel.updateValue(sp, response);
          Method.showToast('Update successfully');
        }
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
      dismissLoading();
    }
  }
}
