
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarBackground extends StatelessWidget {
  AppbarBackground({Key? key, this.height = appBarHeight}) : super(key: key);
  double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: appBarBG,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(defualtRadius * 2),
              bottomRight: Radius.circular(defualtRadius * 2))),
    );
  }
}
