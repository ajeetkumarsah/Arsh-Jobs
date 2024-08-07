import 'package:cariera/services/login_service.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/utils/routes.dart';
import 'package:cariera/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'general_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final LoginService _loginService = LoginService();
  bool isRemember = false;
  late SharedPreferences sp;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login(String username, String password, context) async {
    sp = await SharedPreferences.getInstance();
    final language = sp.getString(AppConstants.LANGUAGE_CODE) ?? '';
    loading(language.contains('ur')
        ? 'تصدیق کر رہا ہے...'
        : language.contains('bn')
            ? 'প্রমাণীকরণ হচ্ছে...'
            : language.contains('ar')
                ? 'مصادقة ...'
                : language.contains('hi')
                    ? 'प्रमाणित किया जा रहा है...'
                    : 'Authenticating..');

    var response = await _loginService.login(username, password);

    if (response.containsKey('error')) {
      dismissLoading();
      dialog(context, 'Login Failed', response['error']);
      // Method.showToast(response['error']);
    } else {
      dismissLoading();

      var data = response['data'];
      GeneralViewModel.setSession(sp, data);
      gotoDashboard();
    }
  }

  void remember(bool remember) {
    isRemember = remember;
    notifyListeners();
  }

  void gotoRegister(isBack) {
    Get.to(() => RegisterView(isBack: isBack));
  }
}
