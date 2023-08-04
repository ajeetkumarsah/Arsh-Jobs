import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/widgets/custom_button.dart';
import 'package:cariera/widgets/custom_textfield.dart';
import 'package:cariera/widgets/login_register.dart';
import 'package:cariera/widgets/register_card.dart';
import 'package:cariera/widgets/remember.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';

import '../widgets/custom_password_textfield.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegisterView({Key? key, this.isBack = false}) : super(key: key);
  bool agree = false;
  bool isBack;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, RegisterViewModel model, child) {
          return GetBuilder<AppController>(
            init: AppController(sharedPreferences: Get.find()),
            initState: (_) {},
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
                              : SizedBox(height: size.height * 0.02),
                          Image.asset(
                            AppConstants.logo,
                            width: size.width * 0.5,
                          ),
                          SizedBox(height: size.height * 0.04),
                          Text(
                            'Sign up',
                            style: s1,
                          ).translate(),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: RegisterCard(
                                  elevation: 0,
                                  title: 'Candidate',
                                  icon: Icons.people,
                                  isPress: model.isCandidate,
                                  onPressed: () {
                                    model.isCheckRole(true, false);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: RegisterCard(
                                  title: 'Employer',
                                  elevation: 0,
                                  isPress: model.isEmployer,
                                  icon: Icons.business_center_rounded,
                                  onPressed: () {
                                    model.isCheckRole(false, true);
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                            controller: usernameController,
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
                            type: TextInputType.name,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextField(
                            controller: emailController,
                            hint: ctlr.locale.languageCode.startsWith('ar')
                                ? 'بريدك الالكتروني'
                                : ctlr.locale.languageCode.startsWith('hi')
                                    ? 'आपका ईमेल'
                                    : ctlr.locale.languageCode.startsWith('bn')
                                        ? 'তোমার ইমেইল'
                                        : ctlr.locale.languageCode
                                                .startsWith('ur')
                                            ? 'آپ کا ای میل'
                                            : ctlr.locale.languageCode
                                                    .startsWith('mr')
                                                ? 'आपला ई - मेल'
                                                : 'Your Email',
                            obscureText: false,
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            hint: ctlr.locale.languageCode.startsWith('ar')
                                ? 'هاتف'
                                : ctlr.locale.languageCode.startsWith('hi')
                                    ? 'फ़ोन'
                                    : ctlr.locale.languageCode.startsWith('bn')
                                        ? 'ফোন'
                                        : ctlr.locale.languageCode
                                                .startsWith('ur')
                                            ? 'فون'
                                            : ctlr.locale.languageCode
                                                    .startsWith('mr')
                                                ? 'फोन'
                                                : 'Phone',
                            obscureText: false,
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomPasswordTextField(
                            controller: passwordController,
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
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Remember(
                            value: model.isAgree,
                            onChanged: (v) => model.agree(v),
                            msg: 'Agree to privacy policy',
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomButton(
                            title: 'Sign up',
                            onPressed: () {
                              if (usernameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                Method.showToast(
                                    'Username, Password or Email required!');
                              } else {
                                if (isLoading()) {
                                  Method.showToast('Please wait..');
                                } else {
                                  model.register(
                                    usernameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text,
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          LoginRegister(
                            msg: "Already register?",
                            title: 'Sign in',
                            onPressed: model.gotoLogin,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
