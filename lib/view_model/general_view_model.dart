

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constant.dart';

class GeneralViewModel {
  static removeSPAuth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(AppConstants.userID);
    sp.remove(AppConstants.userID);
    sp.remove(AppConstants.role);
    sp.remove(AppConstants.email);
    sp.remove(AppConstants.authToken);
    sp.remove(AppConstants.firstName);
    sp.remove(AppConstants.lastName);
    sp.remove(AppConstants.displayName);
  }

  static setSession(SharedPreferences sp, var data) {
    sp.setString(AppConstants.userID, '${data['id']}');
    sp.setString(AppConstants.role, data['role']);
    sp.setString(AppConstants.email, data['email']);
    sp.setString(AppConstants.authToken, data['token']);
    sp.setString(AppConstants.firstName, data['firstName']);
    sp.setString(AppConstants.lastName, data['lastName']);
    sp.setString(AppConstants.displayName, data['displayName']);
    sp.setString(AppConstants.userImage, data['user_avatar']);
  }

  static updateValue(SharedPreferences sp, var data) {
    sp.setString(AppConstants.email, data['email']);
    sp.setString(AppConstants.firstName, data['first_name']);
    sp.setString(AppConstants.lastName, data['last_name']);
  }

  static getUsername(SharedPreferences sp) {
    return sp.getString(AppConstants.displayName);
  }
}
