

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
import 'package:stacked/stacked.dart';

import '../widgets/custom_password_textfield.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  RegisterView({Key? key, this.isBack = false}) : super(key: key);
  bool agree = false;
  bool isBack;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, dynamic model, child) {
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
                            : SizedBox(height: size.height * 0.1),
                        Image.asset(
                          AppConstants.logo,
                          width: size.width * 0.5,
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Text(
                          'Sign up',
                          style: s1,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
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
                          hint: 'Username',
                          obscureText: false,
                          prefix: Icons.person,
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hint: 'Your Email',
                          obscureText: false,
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomPasswordTextField(
                          controller: passwordController,
                          hint: 'Password',
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
              ));
        });
  }
}
