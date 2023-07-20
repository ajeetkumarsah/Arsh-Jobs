
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedColorContainer extends StatelessWidget {
  RoundedColorContainer(
      {Key? key, this.padding, this.margin, this.color, this.child, this.radius})
      : super(key: key);

  EdgeInsetsGeometry? padding, margin;
  Widget? child;
  Color? color;
  double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius!))),
        child: child);
  }
}
