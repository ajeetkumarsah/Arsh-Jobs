import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {Key? key,
      this.title = '',
      this.elevation = 0,
      this.centerTitle = true,
      this.rightIcon,
      this.rightPress})
      : super(key: key);
  String? title;
  double elevation;
  bool centerTitle;
  IconData? rightIcon;
  Function? rightPress;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(title ?? '', style: appBarStyle).translate(),
      backgroundColor: bg,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: dark,
          )),
      actions: [
        if (rightIcon != null)
          IconButton(
              onPressed: () {
                rightPress!();
              },
              icon: Icon(
                rightIcon,
                color: dark,
              ))
      ],
    );
  }
}
