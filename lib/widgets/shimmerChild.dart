
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChild extends StatelessWidget {
  const ShimmerChild({Key? key, this.child, this.width, this.height})
      : super(key: key);
  final Widget? child;
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child!);
  }
}
