import 'package:cariera/widgets/rounded_textfield_simple.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../utils/constant.dart';

// ignore: must_be_immutable
class AccountField extends StatelessWidget {
  AccountField({Key? key, this.title, this.hint, this.controller})
      : super(key: key);
  String? title, hint;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: grey15).translate(),
        RoundedTextfieldSimple(
          hint: hint,
          controller: controller,
        ),
      ],
    );
  }
}
