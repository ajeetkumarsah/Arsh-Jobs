import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.title, this.onPressed}) : super(key: key);
  String? title;
  Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed as void Function()?,
            style: ElevatedButton.styleFrom(
              foregroundColor: onPrimary,
              backgroundColor: primary,
              padding: const EdgeInsets.only(top: pb13, bottom: pb13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(pr), // <-- Radius
              ),
            ),
            child: Text(title ?? '', style: bts).translate(),
          ),
        ),
      ],
    );
  }
}
