import 'package:cariera/utils/colors.dart';
import 'package:cariera/view_model/jobs_view_model.dart';
import 'package:cariera/widgets/filter_job.dart';
import 'package:cariera/widgets/jobs_listing.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class ResumesView extends StatelessWidget {
  ResumesView({Key? key, this.url, this.searchUrl, this.type})
      : super(key: key);
  String? url, searchUrl, type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => JobsViewModel(),
        onViewModelReady: (JobsViewModel model) {
          model.job(url: url ?? '');
          model.initialise(searchUrl ?? '');
          model.getJobTypes(type);
        },
        builder: (context, JobsViewModel model, child) {
          return WillPopScope(
              onWillPop: () {
                if (model.isFilter) {
                  model.isFiltered(false);
                }
                // ignore: null_argument_to_non_null_type
                return Future.value();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: bg,
                body: model.isSearch ? search(model) : jobs(model),
              ));
        });
  }

  Widget search(JobsViewModel model) {
    return JobListing(
        url: url,
        type: type,
        isFav: true,
        model: model,
        featured: model.searchFeaturedJobs,
        unFeatured: model.searchUnFeaturedJobs);
  }

  Widget jobs(model) {
    return model.isFilter
        ? JobFilter(
            type: type,
            model: model,
            url: url,
            types: model.jobTypes,
            categories: model.categories)
        : JobListing(
            url: url,
            type: type,
            isFav: true,
            model: model,
            featured: model.featuredJobs,
            unFeatured: model.unFeaturedJobs);
  }
}
