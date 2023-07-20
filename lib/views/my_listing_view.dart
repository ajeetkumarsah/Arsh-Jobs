// ignore: use_key_in_widget_constructors
import 'package:cariera/models/user_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:cariera/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import '../utils/methods.dart';
import '../view_model/my_listing_view_model.dart';
import '../widgets/card.dart';
import '../widgets/listing_title.dart';
import '../widgets/myListing_shimmer.dart';
import '../widgets/my_listing_item.dart';

// ignore: must_be_immutable
class MyListingView extends StatelessWidget {
  MyListingView(
      {Key? key, this.url, this.title, this.type, this.user, this.role})
      : super(key: key);
  String? type, title, url, role;
  User? user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = size.width / 2;
    final double itemWidth = size.width / 2;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => MyListingViewModel(),
        onViewModelReady: (MyListingViewModel model) {
          model.getListing(url);
        },
        builder: (context, MyListingViewModel model, child) {
          return Scaffold(
            backgroundColor: bg,
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, defaultAppBarHeight),
                child: CustomAppBar(
                  title: title,
                )),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              physics: const BouncingScrollPhysics(),
              footer: const ClassicFooter(
                  // loadStyle: LoadStyle.ShowWhenLoassding,
                  loadingText: AppConstants.loadPosts,
                  noDataText: AppConstants.noPosts,
                  canLoadingText: AppConstants.loading),
              controller: model.getRefresh,
              child: myJobsListing(model, itemHeight, itemWidth),
              onRefresh: () => model.onRefresh(url),
              onLoading: () => model.onLoading(url),
            ),
          );
        });
  }

  Widget myJobsListing(MyListingViewModel model, itemHeight, itemWidth) {
    return model.myListing == null
        ? const Center(child: CircularProgressIndicator())
        : model.myListing == []
            ? Empty()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (type == 'job')
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            title: 'Pending\n${checkListingTitle(type)}',
                            count: checkListingCount(type, 'Pending', user),
                            height: itemHeight,
                            width: itemWidth,
                            start: b2,
                            end: b1,
                            img: 'assets/svgs/b.svg',
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            title:
                                '${type == 'company' ? 'Published' : 'Expired'}\n${checkListingTitle(type)}',
                            count: checkListingCount(
                                type,
                                type == 'company' ? 'Published' : 'Expired',
                                user),
                            height: itemHeight,
                            width: itemWidth,
                            start: d2,
                            end: d1,
                            img: 'assets/svgs/b.svg',
                          ),
                        ),
                      ],
                    ),
                    // if (type != 'job')
                    //   CustomCard(
                    //     title: 'Pending\n${checkListingTitle(type)}',
                    //     count: checkListingCount(type, 'Pending', user),
                    //     height: itemHeight,
                    //     width: itemWidth,
                    //     start: b2,
                    //     end: b1,
                    //     img: 'assets/svgs/b.svg',
                    //   ),

                    ListingTitle(
                      type: type,
                      start: 'Published',
                      isSeelAll: false,
                    ),
                    myListing(model)
                  ],
                ),
              );
  }

  Widget myListing(model) {
    return model.isLoading
        ? const MyListingShimmer()
        : Column(
            children: [
              model.myListing.length == 0
                  ? Column(
                      children: [
                        const SizedBox(
                          height: defualtPadding * 2,
                        ),
                        Empty(
                          title:
                              'You don’t have any published ${checkListingTitle(type)}',
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: defualtPadding),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.myListing.length,
                      itemBuilder: (context, index) {
                        return MyListingItem(
                          jobs: model.myListing[index],
                          type: type,
                          model: model,
                          url: url,
                        );
                      })
            ],
          );
  }
}
