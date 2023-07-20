import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class RoundedButton extends StatelessWidget {
  RoundedButton(
      {Key? key,
      this.radius = defualtRadius,
      this.color = btbtn,
      this.elevation = 0,
      this.style = wb7l11,
      this.title})
      : super(key: key);
  double radius, elevation;
  String? title;
  Color color;
  TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        width: 90,
        padding:
            const EdgeInsets.only(left: p15, top: p5, bottom: p5, right: p15),
        child: Center(
          child: Text(
            title ?? '',
            style: style,
            overflow: TextOverflow.ellipsis,
          ).translate(),
        ),
      ),
    );
  }
}
