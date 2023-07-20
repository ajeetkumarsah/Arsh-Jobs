
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateDesign extends StatelessWidget {
  DateDesign({Key? key, this.date}) : super(key: key);
  String? date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.date_range,
          size: defualtIcon,
          color: primary,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(date!)
      ],
    );
  }
}
