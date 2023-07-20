import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPasswordTextField extends StatefulWidget {
  CustomPasswordTextField(
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
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: hide,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefix),
        labelText: widget.hint,
        filled: true,
        fillColor: textfilled_color,
        suffixIcon: InkWell(
          onTap: _visible,
          child: const Icon(
            Icons.visibility,
          ),
        ),
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

  void _visible() {
    setState(() {
      hide = !hide;
    });
  }
}
