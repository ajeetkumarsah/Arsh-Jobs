import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../view_model/account_view_model.dart';
import '../widgets/account_field.dart';
import '../widgets/appbar_background.dart';
import '../widgets/circular_image_avatar.dart';
import '../widgets/custom_button.dart';
import '../widgets/top_appbar_btn.dart';

// ignore: must_be_immutable
class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);
  double? top;
  @override
  Widget build(BuildContext context) {
    top = MediaQuery.of(context).size.height * 0.22;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AccountViewModel(),
        // ignore: deprecated_member_use
        onViewModelReady: (dynamic model) {
          model.initSP();
        },
        builder: (context, dynamic model, child) {
          return WillPopScope(
            onWillPop: () {
              dismissLoading();
              Get.back(result: 'refresh');
              // ignore: null_argument_to_non_null_type
              return Future.value();
            },
            child: SafeArea(
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(
                      left: defualtPadding, right: defualtPadding),
                  child: CustomButton(
                    title: 'Save',
                    onPressed: () async {
                      await model.updateUser();
                    },
                  ),
                ),
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    AppbarBackground(
                      height: top,
                    ),
                    TopAppbarBtn(
                      title: 'Save Profile',
                      leftIcon: Icons.arrow_back_ios,
                      textStyle: sww20,
                      leftFun: () {
                        dismissLoading();
                        Get.back(result: 'refresh');
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: top! - 50,
                          left: defualtPadding,
                          right: defualtPadding),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CircularImageAvatar(
                            image: model.image,
                            height: 100,
                            width: 100,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  sbH20(),
                                  AccountField(
                                    hint: '',
                                    controller: model.firstController,
                                    title: 'First name',
                                  ),
                                  sbH20(),
                                  AccountField(
                                    hint: '',
                                    controller: model.lastController,
                                    title: 'Last name',
                                  ),
                                  sbH20(),
                                  AccountField(
                                    hint: '',
                                    controller: model.emailController,
                                    title: 'Email',
                                  ),
                                  sbH80()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
