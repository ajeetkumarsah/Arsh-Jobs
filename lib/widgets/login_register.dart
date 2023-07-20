import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class LoginRegister extends StatelessWidget {
  LoginRegister({Key? key, this.title, this.msg, this.onPressed})
      : super(key: key);
  String? title, msg;
  Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg!,
          style: dark13,
        ).translate(),
        TextButton(
            onPressed: onPressed as void Function()?,
            child: Text(title!, style: bts1).translate())
      ],
    );
  }
}
