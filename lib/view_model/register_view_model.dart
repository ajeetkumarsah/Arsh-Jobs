
import 'package:cariera/services/login_service.dart';
import 'package:cariera/services/register_service.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/utils/routes.dart';
import 'package:cariera/view_model/general_view_model.dart';
import 'package:cariera/views/login_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  final RegisterService _registerService = RegisterService();
  final LoginService _loginService = LoginService();
  bool isAgree = false, isCandidate = true, isEmployer = false;
  late SharedPreferences sp;

  void agree(bool isAgree) {
    this.isAgree = isAgree;
    notifyListeners();
  }

  void gotoLogin() {
    Get.off(() => LoginView());
  }

  void isCheckRole(bool candidate, bool employer) {
    isCandidate = candidate;
    isEmployer = employer;
    notifyListeners();
  }

  Future register(String username, String email, String password) async {
    sp = await SharedPreferences.getInstance();
    loading('Registering..');
    var response = await _registerService.register(
        username, email, password, isCandidate ? 'candidate' : 'employer');
    if (response.containsKey('error')) {
      dismissLoading();
      Method.showToast(response['error']);
    } else {
      dismissLoading();

      response = await _loginService.login(username, password);
      if (response.containsKey('error')) {
        Method.showToast(response['error']);
      } else {
        GeneralViewModel.setSession(sp, response['data']);

        gotoDashboard();
      }
    }
  }
}
