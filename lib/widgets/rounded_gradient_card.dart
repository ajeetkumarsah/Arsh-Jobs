
import 'package:cariera/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedGradientCard extends StatelessWidget {
  RoundedGradientCard(
      {Key? key, this.child, this.vpd = 15, this.hpd = 15, this.start, this.end})
      : super(key: key);
  Widget? child;
  double vpd, hpd;
  Color? start, end;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: primary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [start!, end!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: hpd, vertical: vpd),
        child: child,
      ),
    );
  }
}
