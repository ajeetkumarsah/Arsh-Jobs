import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../utils/methods.dart';
import 'rounded_card.dart';

// ignore: must_be_immutable
class NoLoginListing extends StatelessWidget {
  NoLoginListing(
      {Key? key, this.status = AppConstants.noListing, this.isAppBar = true})
      : super(key: key);
  bool isAppBar;
  String status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, defaultAppBarHeight),
          child: Visibility(
            visible: isAppBar,
            child: CustomAppBar(
              title: 'Authentication',
            ),
          )),
      body: Column(
        children: [
          SizedBox(
            height: size(context).height * 0.05,
          ),
          Center(
            child: RoundedCard(
              color: bg,
              pd: 20,
              child: Text(status).translate(),
            ),
          )
        ],
      ),
    );
  }
}
