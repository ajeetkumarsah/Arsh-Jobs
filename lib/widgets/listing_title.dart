import 'package:cariera/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';
import '../utils/methods.dart';
import '../views/blog_view.dart';
import 'default_pad_lr.dart';
import 'drawer_custom_scaffold.dart';

// ignore: must_be_immutable
class ListingTitle extends StatelessWidget {
  ListingTitle(
      {Key? key,
      this.type,
      this.start,
      this.full,
      this.isSeelAll = false,
      this.isBlog = false,
      this.listing,
      this.model,
      this.blogTitle,
      this.listType})
      : super(key: key);
  String? start, type, full, listType, blogTitle;
  dynamic model;
  List<BlogModel?>? listing;
  bool isSeelAll, isBlog;
  @override
  Widget build(BuildContext context) {
    return PadLR(
      topPad: defualtPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            full ?? '$start ${checkListingTitle(type)}',
            style: sbb15,
          ),
          isSeelAll
              ? TextButton(
                  onPressed: () {
                    if (isBlog) {
                      Get.to(() => const BlogView());
                      // Get.to(() => CustomScaffoldWidget(
                      //       title: blogTitle,
                      //       widget: BlogsListing(
                      //         blog: listing,
                      //         model: model,
                      //       ),
                      //     ));
                    } else {
                      Get.to(() => DrawerCustomScaffold(
                            type: 'resume',
                            url: AppConstants.resumes,
                            search: AppConstants.searchResumes,
                            title: 'Resumes',
                          ));

                      // Get.to(() => CustomScaffold(
                      //       type: type,
                      //       seeAll: true,
                      //       url: AppConstants.resumes,
                      //       search: AppConstants.searchResumes,
                      //       title: 'Resumes',
                      //     ));

                      // Get.to(() => FeaturedUnfeaturedJobsView(
                      //       type: type,
                      //       listType: listType,
                      //       url: checkListingFeaturedAPI(type, listType),
                      //       title:
                      //           '${listTypeCheck(listType)} ${checkListingTitle(type)}',
                      //     ));
                    }
                  },
                  child: Text(
                    'See all',
                    style: pb5l11,
                  ))
              : Container()
        ],
      ),
    );
  }
}
