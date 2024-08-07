import 'package:cariera/controller/app_controller.dart';
import 'package:cariera/models/taxonomy_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/custom_button.dart';
import 'package:cariera/widgets/custom_textfield.dart';
import 'package:cariera/widgets/default_pad_lr.dart';
import 'package:cariera/widgets/empty.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

import '../utils/methods.dart';
import 'drop_down.dart';
import 'lined_button.dart';

// ignore: must_be_immutable
class JobFilter extends StatelessWidget {
  JobFilter(
      {Key? key, this.model, this.types, this.url, this.type, this.categories})
      : super(key: key);

  dynamic model;
  String? type, url;
  List<TaxonomyModel>? types, categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          children: [
            if (model.isFilterPressed)
              Expanded(
                flex: 1,
                child: PadLR(
                  child: LinedButton(
                    onPressed: () {
                      model.resetFilters(type);
                      model.isFiltered(false);
                      model.job(url: url);
                      model.setFilterPressed(false);
                    },
                    title: 'Reset',
                  ),
                ),
              ),
            Expanded(
              flex: 1,
              child: PadLR(
                child: CustomButton(
                  onPressed: () {
                    if (type == null &&
                        model.jobID == null &&
                        types!.isNotEmpty) {
                      model.setIDS(types!.first.id, 'job');
                    }
                    if (model.catID == null && categories!.isNotEmpty) {
                      categories!.first.id;
                      model.setIDS(categories!.first.id, 'cat');
                    }

                    model.isFiltered(false);
                    model.filterSearchQuery(type);
                    model.setFilterPressed(true);
                  },
                  title: 'Search',
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bg,
        body: types == null && categories == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GetBuilder<AppController>(
                init: AppController(sharedPreferences: Get.find()),
                builder: (ctlr) {
                  return Padding(
                    padding: const EdgeInsets.all(defualtPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text('Find Your ', style: swb25)
                                    .translate()),
                            sbW10(),
                            Expanded(
                                child:
                                    Text('Perfect', style: swp25).translate()),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Flexible(
                            //         child:
                            //             Text('Find Your ', style: swb25).translate()),
                            //     sbW10(),
                            //     Flexible(
                            //         child: Text('Perfect', style: swp25).translate())
                            //   ],
                            // ),
                            // Text.rich(
                            //   TextSpan(
                            //     children: [
                            //       TextSpan(text: 'Find Your ', style: swb20),
                            //       TextSpan(
                            //           text: 'Perfect ${checkPerfect(type)}',
                            //           style: swp20)
                            //     ],
                            //   ),
                            // ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (model.isFilter) {
                                    model.isFiltered(false);
                                  }
                                },
                                icon: const Icon(Icons.highlight_off_outlined,
                                    color: primary))
                          ],
                        ),
                        sbH20(),
                        CustomTextField(
                          hint: ctlr.locale.languageCode.startsWith('ar')
                              ? 'اسم المستخدم'
                              : ctlr.locale.languageCode.startsWith('hi')
                                  ? 'उपयोगकर्ता नाम'
                                  : ctlr.locale.languageCode.startsWith('bn')
                                      ? 'ব্যবহারকারীর নাম'
                                      : ctlr.locale.languageCode
                                              .startsWith('ur')
                                          ? 'صارف نام'
                                          : ctlr.locale.languageCode
                                                  .startsWith('mr')
                                              ? 'वापरकर्तानाव'
                                              : '${checkType(type)} Keywords',
                          controller: model.filterSearch,
                          type: TextInputType.text,
                          obscureText: false,
                          prefix: Icons.search,
                        ),
                        sbH20(),
                        CustomTextField(
                          hint: ctlr.locale.languageCode.startsWith('ar')
                              ? 'مقام'
                              : ctlr.locale.languageCode.startsWith('hi')
                                  ? 'जगह'
                                  : ctlr.locale.languageCode.startsWith('bn')
                                      ? 'অবস্থান'
                                      : ctlr.locale.languageCode
                                              .startsWith('ur')
                                          ? 'مقام'
                                          : ctlr.locale.languageCode
                                                  .startsWith('mr')
                                              ? 'स्थान'
                                              : 'Location',
                          controller: model.filterLocation,
                          type: TextInputType.text,
                          prefix: Icons.pin_drop,
                          obscureText: false,
                        ),
                        sbH20(),
                        if (type == null)
                          types == null
                              ? Empty(
                                  title: 'loading..',
                                )
                              : types!.isEmpty
                                  ? Container()
                                  : CustomDropDown(
                                      list: types,
                                      model: model,
                                      type: 'job',
                                      icon: Icons.work,
                                      hint: 'Select Job Type',
                                      value: model.jobID),
                        if (type == null) sbH20(),
                        categories == null
                            ? Empty(
                                title: 'loading..',
                              )
                            : categories!.isEmpty
                                ? Container()
                                : CustomDropDown(
                                    list: categories,
                                    model: model,
                                    icon: Icons.category,
                                    type: 'category',
                                    hint: 'Select Category',
                                    value: model.catID),
                      ],
                    ),
                  );
                },
              ));
  }
}
