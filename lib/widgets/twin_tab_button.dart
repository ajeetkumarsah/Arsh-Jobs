import 'package:cariera/widgets/register_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TwinTabButton extends StatelessWidget {
  TwinTabButton(
      {Key? key,
      this.left = true,
      this.right = false,
      this.leftTitle = '',
      this.rightTitle = '',
      this.leftPress,
      this.rightPress})
      : super(key: key);
  bool? left, right;
  String leftTitle, rightTitle;
  Function? leftPress, rightPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: RegisterCard(
            title: leftTitle,
            elevation: 0,
            isPress: left,
            onPressed: () {
              leftPress!();
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: RegisterCard(
            title: rightTitle,
            elevation: 0,
            isPress: right,
            onPressed: () {
              rightPress!();
            },
          ),
        )
      ],
    );
  }
}
