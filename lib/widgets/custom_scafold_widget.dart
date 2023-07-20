import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomScaffoldWidget extends StatelessWidget {
  CustomScaffoldWidget({Key? key, this.widget, this.title}) : super(key: key);
  Widget? widget;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, defaultAppBarHeight),
          child: CustomAppBar(
            title: title,
          ),
        ),
        body: widget);
  }
}
