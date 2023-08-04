// ignore_for_file: must_be_immutable

import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/widgets/custom_button.dart';
import 'package:cariera/widgets/custom_textfield.dart';
import 'package:cariera/widgets/login_register.dart';
import 'package:cariera/widgets/remember.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_password_textfield.dart';

class LoginView extends StatelessWidget {
  bool isBack;
  LoginView({Key? key, this.isBack = false}) : super(key: key);
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, LoginViewModel model, child) {
        return GetBuilder<AppController>(
          init: AppController(sharedPreferences: Get.find()),
          builder: (ctlr) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(p10),
                      child: Column(
                        children: [
                          isBack
                              ? SizedBox(
                                  height: size.height * 0.15,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_back_ios))
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(height: size.height * 0.05),
                          Image.asset(AppConstants.logo,
                              width: size.width * 0.5),
                          SizedBox(height: size.height * 0.05),
                          Text('Sign in', style: s1).translate(),
                          Text('Sign in to continue', style: s2).translate(),
                          SizedBox(height: size.height * 0.04),
                          CustomTextField(
                            controller: model.usernameController,
                            hint: ctlr.locale.languageCode.startsWith('ar')
                                ? 'اسم المستخدم'
                                : ctlr.locale.languageCode.startsWith('hi')
                                    ? 'उपयोगकर्ता नाम'
                                    : ctlr.locale.languageCode.startsWith('bn')
                                        ? 'ব্যবহারকারীর নাম'
                                        : ctlr.locale.languageCode
                                                .startsWith('ur')
                                            ? 'صارف نام'
                                            : ctlr.locale.languageCode
                                                    .startsWith('mr')
                                                ? 'वापरकर्तानाव'
                                                : 'Username',
                            obscureText: false,
                            prefix: Icons.person,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomPasswordTextField(
                            controller: model.passwordController,
                            hint: ctlr.locale.languageCode.startsWith('ar')
                                ? 'كلمة المرور'
                                : ctlr.locale.languageCode.startsWith('hi')
                                    ? 'पासवर्ड'
                                    : ctlr.locale.languageCode.startsWith('bn')
                                        ? 'পাসওয়ার্ড'
                                        : ctlr.locale.languageCode
                                                .startsWith('ur')
                                            ? 'پاس ورڈ'
                                            : ctlr.locale.languageCode
                                                    .startsWith('mr')
                                                ? 'पासवर्ड'
                                                : 'Password',
                            obscureText: true,
                            prefix: Icons.security,
                            sufix: Icons.remove_red_eye,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Remember(
                            value: model.isRemember,
                            onChanged: (v) => model.remember(v),
                            msg: 'Keep me signed in',
                          ),
                          SizedBox(height: size.height * 0.05),
                          CustomButton(
                              title: 'Sign in',
                              onPressed: () {
                                if (model.usernameController.text.isEmpty ||
                                    model.passwordController.text.isEmpty) {
                                  Method.showToast(
                                      'Username or Password required!');
                                } else {
                                  if (isLoading()) {
                                    Method.showToast('Please wait..');
                                  } else {
                                    model.login(model.usernameController.text,
                                        model.passwordController.text, context);
                                  }
                                }
                              }),

                          SizedBox(height: size.height * 0.02), //
                          TextButton(
                            onPressed: () => _launchURL(
                                'https://arshjobs.ae/pages/login-register/'),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child:
                                Text('Forgot Password?', style: s2).translate(),
                          ),
                          LoginRegister(
                            msg: "Don't have an account?",
                            title: 'Sign up',
                            onPressed: () {
                              model.gotoRegister(isBack);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  _launchURL(url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
