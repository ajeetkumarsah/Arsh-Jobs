import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class RegisterCard extends StatelessWidget {
  RegisterCard(
      {Key? key,
      this.title,
      this.icon,
      this.isPress,
      this.onPressed,
      this.elevation = 5})
      : super(key: key);
  String? title;
  IconData? icon;
  void Function()? onPressed;
  bool? isPress;
  double elevation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: elevation,
        color: isPress! ? primary : bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defualtRadius),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: isPress! ? bg : primary,
                  size: fs20,
                ),
              if (icon != null)
                const SizedBox(
                  width: 8,
                ),
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: isPress! ? s6 : s5,
              ).translate(),
            ],
          ),
        ),
      ),
    );
  }
}
