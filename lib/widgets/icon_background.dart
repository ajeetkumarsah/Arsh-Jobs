
import 'package:cariera/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconBackground extends StatelessWidget {
  IconBackground(
      {Key? key, this.l, this.b, this.r, this.t, this.icon, this.onTap})
      : super(key: key);
  double? l, t, b, r;
  IconData? icon;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.only(left: l!, right: r!, top: t!, bottom: b!),
        decoration: BoxDecoration(
            color: onPrimary, borderRadius: BorderRadius.circular(8)),
        child: Icon(
          icon,
        ),
      ),
    );
  }
}
