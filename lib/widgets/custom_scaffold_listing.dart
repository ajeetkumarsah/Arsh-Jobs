import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/jobs_view.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../views/see_all_items_view.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatelessWidget {
  CustomScaffold(
      {Key? key,
      this.url,
      this.search,
      this.title,
      this.type,
      this.isFav = false,
      this.seeAll = false})
      : super(key: key);
  String? url, search, title, type;

  bool seeAll, isFav;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, defaultAppBarHeight),
        child: CustomAppBar(
          title: title,
        ),
      ),
      body: seeAll
          ? SeeAllItemsView(
              type: type,
              isFav: isFav,
              url: url,
              searchUrl: search,
            )
          : JobsView(
              isFav: isFav,
              type: type,
              url: url,
              searchUrl: search,
            ),
    );
  }
}
