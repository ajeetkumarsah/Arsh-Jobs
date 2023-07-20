// ignore_for_file: must_be_immutable

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
                            : SizedBox(height: size.height * 0.15),
                        Image.asset(AppConstants.logo, width: size.width * 0.5),
                        SizedBox(height: size.height * 0.1),
                        Text('Sign in', style: s1).translate(),
                        Text('Sign in to continue', style: s2).translate(),
                        SizedBox(height: size.height * 0.04),
                        CustomTextField(
                          controller: model.usernameController,
                          hint: 'Username',
                          obscureText: false,
                          prefix: Icons.person,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomPasswordTextField(
                          controller: model.passwordController,
                          hint: 'Password',
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
                        SizedBox(height: size.height * 0.05),
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
        });
  }
}
