import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class JobTile extends StatelessWidget {
  JobTile(
      {Key? key,
      this.title = '',
      this.subTitle = '',
      this.color = primary,
      this.icon})
      : super(key: key);
  IconData? icon;
  String? title, subTitle;
  Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: primary,
        size: defaultJobDetailIcon,
      ),
      subtitle: Text(subTitle ?? '').translate(),
      title: Text(
        title ?? '',
        style: dark13,
      ).translate(),
    );
  }
}
