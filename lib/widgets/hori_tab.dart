import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/default_pad_lr.dart';
import 'package:cariera/widgets/rounded_card.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class HoriTab extends StatelessWidget {
  const HoriTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PadLR(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Job Category',
                style: sbb15,
              ).translate(),
              TextButton(
                  onPressed: () {},
                  child: Text('See all', style: pb5l11).translate())
            ],
          ),
        ),
        sbH10(),
        SizedBox(
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: p5, right: p5),
                    child: RoundedCard(
                      // ignore: sort_child_properties_last
                      child: Row(
                        children: [
                          const Icon(
                            Icons.book,
                            color: onPrimary,
                          ),
                          const SizedBox(
                            width: p10,
                          ),
                          Text(
                            'Design & Art',
                            style: sbw13,
                          ).translate()
                        ],
                      ),
                      color: primary,
                      pd: defualtPadding,
                    ),
                  );
                }))
      ],
    );
  }
}
