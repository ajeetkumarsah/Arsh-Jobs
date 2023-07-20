import 'package:cariera/models/job_model.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/views/details_view.dart';
import 'package:cariera/widgets/vertical_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

// ignore: must_be_immutable
class VerticalList extends StatelessWidget {
  VerticalList({Key? key, this.jobs, this.type, this.title, this.limit})
      : super(key: key);
  List<JobModel>? jobs;
  String? type, title;
  int? limit;
  @override
  Widget build(BuildContext context) {
    return jobs!.isEmpty
        ? Center(
            child: Text('No ${checkListingTitle(type)} Available!').translate(),
          )
        : ListView.builder(
            itemCount: limit ?? jobs!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return VerticalListItem(
                jobs: jobs![index],
                onTap: () {
                  Get.to(() => DetailsView(
                        job: jobs![index],
                        type: type,
                      ));
                },
                type: type,
              );
            },
          );
  }
}
