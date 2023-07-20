import 'package:cariera/models/job_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/jobs_view_model.dart';
import 'package:cariera/widgets/horiShimmerList.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:cariera/widgets/shimmer.dart';
import 'package:cariera/widgets/verticalShimmerList.dart';
import 'package:cariera/widgets/vertical_list.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../utils/methods.dart';
import 'default_pad_lr.dart';
import 'filter_seach.dart';
import 'hori_big_tab.dart';

// ignore: must_be_immutable
class JobListing extends StatelessWidget {
  JobListing(
      {Key? key,
      this.type,
      required this.model,
      this.url,
      this.featured = const [],
      this.unFeatured = const [],
      required this.isFav})
      : super(key: key);
  JobsViewModel model;
  String? type;
  bool isFav;
  String? url;
  List<JobModel>? featured, unFeatured;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        physics: const BouncingScrollPhysics(),
        footer: const ClassicFooter(
            // loadStyle: LoadStyle.ShowWhenLoading,
            loadingText: AppConstants.loadJobs,
            noDataText: AppConstants.noJobs,
            canLoadingText: AppConstants.loading),
        controller: model.getRefresh,
        child: lists(),
        onRefresh: () => model.onRefresh(url ?? '', type),
        onLoading: () => model.onLoading(url ?? '', type),
      ),
    );
  }

  Widget lists() {
    return ListView(
      children: [
        PadLR(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey, ${model.username}',
              ).translate(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Find Your ', style: swb20),
                    TextSpan(
                        text: 'Perfect ${checkPerfect(type)}', style: swp20)
                  ],
                ),
              ).translate(),
              sbH10(),
              searchFilterField(
                controller: model.searchQueryController,
                onTap: () {
                  model.searchQueryController.clear();
                  model.isFiltered(true);
                },
                hint: 'Search',
                obscureText: false,
                sufix: Icons.search,
                type: TextInputType.text,
              ),
              sbH20()
            ],
          ),
        ),
        model.isLoading ? shimmer() : listings(),
      ],
    );
  }

  Widget shimmer() {
    return Column(
      children: [
        const HoriShimmerList(),
        sbH20(),
        PadLR(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Shimmers(
                height: 15,
                width: 100,
              )
            ],
          ),
        ),
        const VerticalShimmerList(),
      ],
    );
  }

  Widget listings() {
    return Column(
      children: [
        HoriBigTab(
          isFav: isFav,
          jobs: featured,
          type: type,
        ),
        sbH20(),
        PadLR(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              checkListingTitle(type),
              style: sbb15,
            ).translate(),
          ],
        )),
        VerticalList(
          type: type,
          jobs: unFeatured,
        ),
      ],
    );
  }
}
