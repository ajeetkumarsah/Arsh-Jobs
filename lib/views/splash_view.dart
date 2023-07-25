import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/login_view.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import '../widgets/rounded_network_image.dart';
import 'dashboard_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController controller;
  SharedPreferences? sp;
  @override
  void initState() {
    super.initState();
    anim();
    Future.delayed(const Duration(seconds: 3), () {
      initSP();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  anim() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          });
    controller.repeat(reverse: false);
  }

  initSP() async {
    sp = await SharedPreferences.getInstance();
    String? token = sp?.getString(AppConstants.authToken);
    if (token != null) {
      Get.offAll(() => DashboardView());
    } else {
      Get.offAll(() => LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: onPrimary,
        body: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedNetworkImage(
                      radius: 0,
                      defaultImage: AppConstants.icon,
                      height: 100,
                      width: 150,
                      fit: BoxFit.fitWidth,
                    ),
                    sbH10(),
                    Text(
                      AppConstants.appName,
                      style: s1,
                    ).translate(),
                    sbH10(),
                    SizedBox(
                      width: 80,
                      child: LinearProgressIndicator(
                        value: controller.value,
                        backgroundColor: onPrimary,
                        color: primary,
                      ),
                    )
                  ],
                ),
                const Text(
                  AppConstants.version,
                  style: TextStyle(color: Colors.black87),
                ).translate(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
