
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers extends StatelessWidget {
  const Shimmers({Key? key, this.child, this.width, this.height})
      : super(key: key);
  final Widget? child;
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:
            Container(height: height, width: width, color: Colors.grey[300]));
  }
}
