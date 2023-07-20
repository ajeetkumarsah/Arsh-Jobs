
// ignore_for_file: file_names

import 'package:cariera/widgets/rounded_gradient_card.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:cariera/widgets/shimmer.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import 'default_pad_lr.dart';
import 'shimmerChild.dart';

class HoriShimmerList extends StatelessWidget {
  const HoriShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerChild(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PadLR(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Shimmers(
                  height: 20,
                  width: 100,
                ),
                Container(
                  color: Colors.grey[300],
                  height: 15,
                  width: 50,
                ),
              ],
            ),
          ),
          sbH10(),
          Container(
            height: 210,
            padding: const EdgeInsets.all(p5),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(left: p10, right: p10),
                      child: RoundedGradientCard(
                        start: Colors.grey[300],
                        end: Colors.grey[300],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
