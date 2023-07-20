import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class searchFilterField extends StatelessWidget {
  searchFilterField(
      {Key? key,
      this.controller,
      this.hint,
      this.type,
      this.obscureText,
      this.sufix,
      this.prefix,
      this.onTap})
      : super(key: key);
  Function? onTap;
  TextEditingController? controller = TextEditingController();
  String? hint;
  bool? obscureText;
  TextInputType? type;
  IconData? prefix, sufix;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: p5),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(pr),
              ),
              child: TextFormField(
                  controller: controller,
                  keyboardType: type,
                  obscureText: obscureText!,
                  decoration: InputDecoration(
                    // labelText: hint,

                    hintText: hint,
                    filled: true,
                    fillColor: onPrimary,
                    prefixIcon: Icon(
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
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(pr),
            ),
            color: primary,
            shadowColor: primary,
            child: const Padding(
              padding: EdgeInsets.all(defualtPadding / 1.5),
              child: Icon(
                Icons.filter_list_outlined,
                color: onPrimary,
                size: defualtIcon * 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
