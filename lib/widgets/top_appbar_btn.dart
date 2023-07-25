import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../utils/constant.dart';
import 'icon_background.dart';

// ignore: must_be_immutable
class TopAppbarBtn extends StatelessWidget {
  TopAppbarBtn(
      {Key? key,
      this.leftFun,
      this.rightFun,
      this.rightIcon,
      this.leftIcon,
      this.title,
      this.textStyle})
      : super(key: key);
  Function? leftFun, rightFun;
  IconData? leftIcon, rightIcon;
  String? title;
  TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defualtPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon != null
              ? IconBackground(
                  onTap: () {
                    leftFun!();
                  },
                  icon: leftIcon,
                  l: 10,
                  r: 0,
                  b: 5,
                  t: 5,
                )
              : const SizedBox(
                  width: 10,
                ),
          Text(title!, style: textStyle).translate(),
          rightIcon != null
              ? IconBackground(
                  onTap: () {
                    rightFun!();
                  },
                  icon: rightIcon,
                  l: 5,
                  r: 5,
                  b: 5,
                  t: 5,
                )
              : const SizedBox(
                  width: 10,
                )
        ],
      ),
    );
  }
}
