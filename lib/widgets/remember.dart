import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class Remember extends StatelessWidget {
  Remember(
      {Key? key,
      this.onChanged,
      this.value,
      this.onPressed,
      this.buttonText,
      this.title,
      this.msg})
      : super(key: key);
  bool? value;
  Function? onChanged, onPressed;
  String? title, buttonText, msg;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: value, onChanged: onChanged as void Function(bool?)?),
            Text(
              msg!,
              style: onlyDark,
            ).translate(),
          ],
        ),
        TextButton(
          onPressed: onPressed as void Function()?,
          child: Text(
            '',
            style: si,
          ).translate(),
        )
      ],
    );
  }
}
