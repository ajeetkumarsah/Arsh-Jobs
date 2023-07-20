
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedContainer extends StatelessWidget {
  RoundedContainer(
      {Key? key,
      this.radius = defualtRadius,
      this.child,
      this.height,
      this.padding = defualtPadding,
      this.width})
      : super(key: key);
  double? radius, height, width, padding;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius!)),
        child: child,
      ),
    );
  }
}
