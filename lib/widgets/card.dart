import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  CustomCard(
      {Key? key,
      this.count,
      this.start,
      this.end,
      this.img,
      this.title,
      this.height,
      this.width})
      : super(key: key);
  String? count, title, img;
  double? height, width;
  Color? end, start;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(p10),
      height: height! - 30,
      width: width,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   image: DecorationImage(
      //     fit: BoxFit.cover,
      //     image: svg.Svg(
      //       img,
      //     ),
      //   ),
      // ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [start!, end!],
          ),
          borderRadius: BorderRadius.circular(dp)),
      padding: const EdgeInsets.all(p15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count ?? '', style: swb50).translate(),
          Text(
            title!,
            style: swb,
          ).translate(),
        ],
      ),
    );
  }
}
