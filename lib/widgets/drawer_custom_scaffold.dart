import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/jobs_view.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerCustomScaffold extends StatelessWidget {
  DrawerCustomScaffold({
    Key? key,
    this.url,
    this.search,
    this.title,
    this.type,
  }) : super(key: key);
  String? url, search, title, type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, defaultAppBarHeight),
        child: CustomAppBar(
          title: title,
        ),
      ),
      body: JobsView(
        type: type,
        isFav: true,
        url: url,
        searchUrl: search,
      ),
    );
  }
}
