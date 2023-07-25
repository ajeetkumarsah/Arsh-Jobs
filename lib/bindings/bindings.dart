import 'package:cariera/controller/app_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> dependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => AppController(sharedPreferences: Get.find()));
  return true;
}
