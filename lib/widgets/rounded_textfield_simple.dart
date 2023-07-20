
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class RoundedTextfieldSimple extends StatelessWidget {
  RoundedTextfieldSimple({Key? key, this.hint, this.controller})
      : super(key: key);
  TextEditingController? controller;
  String? hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(pr),
            borderSide: BorderSide(
              color: primary.withOpacity(0.25),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(pr),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hint,
          fillColor: Colors.white70),
    );
  }
}
