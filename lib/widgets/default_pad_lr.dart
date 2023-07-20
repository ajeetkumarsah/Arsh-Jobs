
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PadLR extends StatelessWidget {
  PadLR(
      {Key? key,
      this.child,
      this.leftPad = defualtPadding,
      this.topPad = 0,
      this.bottomPad = 0,
      this.rightPad = defualtPadding})
      : super(key: key);
  Widget? child;
  double leftPad, rightPad, topPad, bottomPad;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: leftPad, right: rightPad, top: topPad, bottom: bottomPad),
        child: child);
  }
}
