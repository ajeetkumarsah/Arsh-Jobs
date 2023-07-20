import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/jobs_view_model.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:cariera/widgets/vertical_list.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class FeaturedUnfeaturedJobsView extends StatelessWidget {
  FeaturedUnfeaturedJobsView(
      {Key? key, this.url, this.title, this.type, this.listType})
      : super(key: key);
  String? url, title, type, listType;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => JobsViewModel(),
        onViewModelReady: (dynamic model) {
          model.job(url: url);
        },
        builder: (context, dynamic model, child) {
          return Scaffold(
              backgroundColor: bg,
              appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, kToolbarHeight),
                  child: CustomAppBar(
                    title: title,
                  )),
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
                child: items(model),
                onRefresh: () => model.onRefresh(url, type),
                onLoading: () => model.onLoading(url, type),
              ));
        });
  }

  Widget items(model) {
    return model.isData == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : VerticalList(
            type: type,
            jobs: listType == 'unfeature'
                ? model.unFeaturedJobs
                : model.featuredJobs,
          );
  }
}
