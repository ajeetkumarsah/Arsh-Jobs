import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/models/language_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_translator/google_translator.dart';

class LanguageScreen extends StatelessWidget {
  final bool isSkipable;
  const LanguageScreen({super.key, this.isSkipable = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(sharedPreferences: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: isSkipable
                ? const SizedBox()
                : IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                  ),
            backgroundColor: isSkipable ? Colors.white : bg,
            elevation: 0,
            leadingWidth: isSkipable ? 12 : null,
            title: Text(
              'Select Language',
              style: GoogleFonts.openSans(color: Colors.black),
            ).translate(),
            actions: [
              isSkipable
                  ? InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade200.withOpacity(0.5)),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          'Skip',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ).translate(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Image.asset('assets/images/logo.png',
                                    width: 100)),
                            const SizedBox(height: 6),
                            // Center(child: Image.asset(Images.logo_name, width: 100)),

                            //Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE))),
                            const SizedBox(height: 30),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text('Select Language',
                                      style: GoogleFonts.openSans())
                                  .translate(),
                            ),
                            const SizedBox(height: 6),

                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1),
                              ),
                              itemCount: ctlr.languages.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => LanguageWidget(
                                languageModel: ctlr.languages[index],
                                isSelected: ctlr.locale.languageCode ==
                                    ctlr.languages[index].languageCode,
                                onTap: () {
                                  ctlr.setLanguage(Locale(
                                      ctlr.languages[index].languageCode));
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Text('you_can_change_language'.tr,
                            //     style: robotoRegular.copyWith(
                            //       fontSize: Dimensions.fontSizeSmall,
                            //       color: Theme.of(context).disabledColor,
                            //     )),
                          ]),
                    )),
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 12, right: 16),
                child: CustomButton(
                  title: 'Save',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final void Function()? onTap;
  final bool isSelected;
  const LanguageWidget({
    required this.languageModel,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(PADDING_SIZE_SMALL),
        margin: const EdgeInsets.all(PADDING_SIZE_EXTRA_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(RADIUS_SMALL),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 800 : 200] ?? Colors.grey,
                blurRadius: 5,
                spreadRadius: 1)
          ],
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RADIUS_SMALL),
                  border: Border.all(color: bg, width: 1),
                ),
                alignment: Alignment.center,
                child: Text(
                  languageModel.flag,
                  style: GoogleFonts.openSans(fontSize: 26),
                ),
              ),
              const SizedBox(height: PADDING_SIZE_LARGE),
              Text(languageModel.languageName, style: GoogleFonts.openSans()),
            ]),
          ),
          isSelected
              ? const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.check_circle, color: primary, size: 25),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
