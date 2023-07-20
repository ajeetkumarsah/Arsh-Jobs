
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class searchTextField extends StatelessWidget {
  searchTextField(
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(pr),
      ),
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: obscureText!,
          decoration: InputDecoration(
            prefixIcon: Icon(prefix),
            // labelText: hint,

            hintText: hint,
            filled: true,
            fillColor: onPrimary,
            suffixIcon: Icon(
              sufix,
              color: primary,
              size: fs25,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(pr),
              borderSide: const BorderSide(
                color: bg,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(pr),
              borderSide: const BorderSide(
                color: onPrimary,
                width: 2.0,
              ),
            ),
          )),
    );
  }
}
