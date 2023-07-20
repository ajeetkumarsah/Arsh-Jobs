import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class Empty extends StatelessWidget {
  Empty({Key? key, this.title = 'No Data Found!'}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title).translate(),
    );
  }
}
