
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedCard extends StatelessWidget {
  RoundedCard(
      {Key? key, this.child, this.pd = 0.0, this.color, this.elevation = 5})
      : super(key: key);
  Widget? child;
  double pd;
  Color? color;
  double elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(pd),
      ),
      child: Padding(
        padding: EdgeInsets.all(pd),
        child: child,
      ),
    );
  }
}
