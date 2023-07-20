
// ignore_for_file: file_names

import 'package:cariera/widgets/shimmer.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class VerticalShimmerList extends StatelessWidget {
  const VerticalShimmerList({Key? key, this.count = 10}) : super(key: key);
  final int count;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
              left: defualtPadding,
              right: defualtPadding,
              top: ls10,
              bottom: ls10),
          decoration: BoxDecoration(
              color: onPrimary,
              borderRadius: BorderRadius.circular(defualtRadius)),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Shimmers(
                  height: 85,
                  width: 80,
                ),
              ),
              const SizedBox(
                width: fs20,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Shimmers(
                      height: 15,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Shimmers(
                      height: 20,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Shimmers(
                      height: 10,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Shimmers(
                          height: 20,
                          width: 100,
                        ),
                        Shimmers(
                          height: 20,
                          width: 100,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
