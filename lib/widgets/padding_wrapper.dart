
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaddingWapper extends StatelessWidget {
  PaddingWapper(
      {Key? key,
      this.child,
      this.l = 0.0,
      this.r = 0.0,
      this.b = 0.0,
      this.t = 0.0,
      this.alignment = Alignment.topLeft})
      : super(key: key);
  Alignment alignment;
  Widget? child;
  double l, r, t, b;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: l, right: r, bottom: b, top: t),
        child: Align(alignment: alignment, child: child));
  }
}
