import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/main.dart';
import 'package:cariera/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(sharedPreferences: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            backgroundColor: bg,
            elevation: 0,
            title: Text(
              'Select Language',
              style: GoogleFonts.openSans(color: Colors.black),
            ),
          ),
          body: Column(
            children: [
              ...ctlr.languages
                  .map((e) => ListTile(
                        onTap: () {
                          ctlr.setLanguage(Locale(e.languageCode));
                          Get.back();
                        },
                        leading: const Icon(
                          Icons.translate,
                          size: 22,
                        ),
                        title: Text(e.languageName),
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}
