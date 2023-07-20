
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatelessWidget {
  PasswordTextField(
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
  bool? obscureText, isSufix;
  TextInputType? type;
  IconData? prefix, sufix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscureText!,
        decoration: InputDecoration(
          suffix: Icon(sufix),
          prefixIcon: Icon(prefix),
          labelText: hint,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 2.0,
            ),
          ),
        ));
  }
}
