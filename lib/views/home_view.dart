import 'package:cariera/utils/constant.dart';
import 'package:cariera/widgets/blogs_listing.dart';
import 'package:cariera/widgets/default_pad_lr.dart';
import 'package:cariera/widgets/horiShimmerList.dart';
import 'package:cariera/widgets/listing_title.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:cariera/widgets/shimmer.dart';
import 'package:cariera/widgets/verticalShimmerList.dart';
import 'package:cariera/widgets/vertical_list.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';
import '../view_model/dashboard_view_model.dart';
import '../widgets/hori_big_tab.dart';
import '../widgets/twin_tab_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onViewModelReady: (DashboardViewModel model) {
          model.getListings(
              AppConstants.jobs, AppConstants.companies, AppConstants.resumes);
        },
        builder: (context, DashboardViewModel model, child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                sbH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text('Find Your ', style: swb25).translate()),
                    sbW10(),
                    Flexible(
                        child: Text('Dream Job ', style: swp25).translate())
                  ],
                ),
                // RichText(
                //     text: TextSpan(children: [
                //   TextSpan(text: 'Find Your ', style: swb25),
                //   TextSpan(text: 'Dream Job', style: swp25)
                // ])),
                sbH20(),
                PadLR(
                  child: TwinTabButton(
                    right: model.unFeatureButton,
                    left: model.featureButton,
                    leftPress: () {
                      model.isCheck(true, false);
                    },
                    rightPress: () {
                      model.isCheck(false, true);
                    },
                    rightTitle: 'Latest Jobs',
                    leftTitle: 'Featured Jobs',
                  ),
                ),
                jobs(model),
                model.isLoading
                    ? const HoriShimmerList()
                    : HoriBigTab(
                        isComplete: true,
                        title: 'Top',
                        jobs: model.unFeaturedCompanies,
                        type: 'company',
                        listType: 'unfeature'),
                model.isLoading
                    ? const Shimmers(
                        height: 20,
                        width: 100,
                      )
                    : ListingTitle(
                        type: 'resume',
                        start: 'Latest',
                        isSeelAll: true,
                        listType: 'unfeature',
                      ),
                model.isLoading
                    ? const VerticalShimmerList(
                        count: 3,
                      )
                    : VerticalList(
                        limit: setLimit(model.unFeaturedResumes, 3),
                        jobs: model.unFeaturedResumes,
                        type: 'resume',
                      ),
                model.isLoading
                    ? const Shimmers(
                        height: 20,
                        width: 100,
                      )
                    : ListingTitle(
                        full: 'Trending Posts',
                        isSeelAll: true,
                        isBlog: true,
                        listing: model.blog,
                        model: model,
                        blogTitle: 'Trending Posts',
                      ),
                model.isLoading
                    ? const VerticalShimmerList(
                        count: 3,
                      )
                    : BlogsListing(
                        limit: setLimit(model.blog, 3),
                        blog: model.blog!,
                        model: model,
                      )
              ],
            ),
          );
        });
  }

  Widget jobs(model) {
    return model.isLoading
        ? const VerticalShimmerList(
            count: 3,
          )
        : model.featureButton
            ? featureJob(model.featuredJobs)
            : unFeatureJob(model.unFeaturedJobs);
  }

  Widget featureJob(jobs) {
    return VerticalList(
      jobs: jobs,
      type: 'job',
      limit: setLimit(jobs, 3),
    );
  }

  Widget unFeatureJob(jobs) {
    return VerticalList(
      jobs: jobs,
      type: 'job',
      limit: setLimit(jobs, 3),
    );
  }

  int? setLimit(list, limit) {
    if (list != null) {
      if (list.isNotEmpty) {
        if (list.length < 3) {
          limit = null;
        } else {
          limit = limit;
        }
      } else {
        limit = null;
      }
    } else {
      limit = null;
    }
    return limit;
  }
}
