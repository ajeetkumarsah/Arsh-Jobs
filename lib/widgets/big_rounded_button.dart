import 'package:cariera/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

// ignore: must_be_immutable
class BigRoundedButton extends StatelessWidget {
  BigRoundedButton(
      {Key? key,
      this.title,
      this.radius,
      this.onPress,
      this.buttonColor = primary,
      this.textColor = onPrimary})
      : super(key: key);
  String? title;
  Function? onPress;
  double? radius;
  Color buttonColor, textColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(left: defualtPadding, right: defualtPadding),
        child: ElevatedButton(
          onPressed: () {
            onPress!();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: buttonColor,
            fixedSize: const Size(double.infinity, roundedBigButtonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
            ),
          ),
          child: Text(title!),
        ),
      ),
    );
  }
}
