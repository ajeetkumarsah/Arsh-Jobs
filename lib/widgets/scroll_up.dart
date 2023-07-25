import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ScrollUp extends StatelessWidget {
  const ScrollUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: 50,
        child: Center(
          child: const Text(
            "Click to scroll up",
            style: TextStyle(
              fontSize: 18,
            ),
          ).translate(),
        ),
      ),
    );
  }
}
