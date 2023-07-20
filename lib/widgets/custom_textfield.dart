import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.controller,
      this.hint,
      this.type,
      this.obscureText,
      this.sufix,
      this.prefix})
      : super(key: key);
  TextEditingController? controller = TextEditingController();
  String? hint;
  bool? obscureText;
  TextInputType? type;
  IconData? prefix, sufix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscureText!,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: hint,
        filled: true,
        fillColor: textfilled_color,
        suffixIcon: Icon(sufix),
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
      ),
    );
  }
}
