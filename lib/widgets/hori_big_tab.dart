import 'package:cariera/models/job_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/views/details_view.dart';
import 'package:cariera/widgets/rounded_button.dart';
import 'package:cariera/widgets/rounded_card.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_scaffold_listing.dart';
import 'default_pad_lr.dart';
import 'drawer_custom_scaffold.dart';
import 'rounded_gradient_card.dart';

// ignore: must_be_immutable
class HoriBigTab extends StatelessWidget {
  HoriBigTab(
      {Key? key,
      this.jobs = const [],
      this.type,
      this.isComplete = false,
      this.listType,
      this.isFav = false,
      this.title = 'Featured'})
      : super(key: key);
  List<JobModel>? jobs;
  bool isFav, isComplete;

  String? type, title, listType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PadLR(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title ${checkListingTitle(type)}',
                style: sbb15,
              ),
              TextButton(
                  onPressed: () {
                    String title = '', url = '', search = '';
                    if (type == 'company') {
                      title = 'Companies';
                      url = AppConstants.companies;
                      search = AppConstants.searchCompanies;
                    } else if (type == 'resume') {
                      title = 'Resumes';
                      url = AppConstants.resumes;
                      search = AppConstants.searchResumes;
                    } else {
                      title = 'Jobs';
                      url = AppConstants.jobs;
                      search = AppConstants.searchJobs;
                    }
                    if (isComplete) {
                      Get.to(() => DrawerCustomScaffold(
                            type: 'company',
                            url: AppConstants.companies,
                            search: AppConstants.searchCompanies,
                            title: 'Companies',
                          ));
                    } else {
                      Get.to(() => CustomScaffold(
                            seeAll: true,
                            type: type,
                            url: url,
                            search: search,
                            isFav: isFav,
                            title: title,
                          ));
                    }

                    // Get.to(() => FeaturedUnfeaturedJobsView(
                    //       type: type,
                    //       listType: listType,
                    //       url: checkListingFeaturedAPI(type, listType),
                    //       title:
                    //           '${listTypeCheck(listType)} ${checkListingTitle(type)}',
                    //     ));
                  },
                  child: Text(
                    'See all',
                    style: pb5l11,
                  ))
            ],
          ),
        ),
        sbH10(),
        jobs!.isEmpty
            ? Center(
                child:
                    Text('No Featured ${checkListingTitle(type)} Available!'),
              )
            : Container(
                height: 210,
                padding: const EdgeInsets.all(p5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jobs!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailsView(
                                job: jobs![index],
                                type: type,
                              ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.only(left: p10, right: p10),
                          child: RoundedGradientCard(
                            vpd: 10,
                            hpd: 15,
                            // ignore: sort_child_properties_last
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RoundedCard(
                                        color: bt1,
                                        pd: p5,
                                        child: checkListingLogo(
                                                    jobs![index], type) !=
                                                ''
                                            ? Image.network(
                                                checkListingLogo(
                                                    jobs![index], type)!,
                                                height: fs20,
                                                width: fs20,
                                              )
                                            : Image.asset(
                                                AppConstants
                                                    .defaultCompanyImage,
                                                height: fs20,
                                                width: fs20,
                                              )),
                                    if (type == 'company')
                                      category(jobs![index].companyCategory),
                                    if (type == 'resume')
                                      category(jobs![index].resumeCategory),
                                    if (jobs![index].jobCategory!.isNotEmpty &&
                                        type == null)
                                      category(jobs![index]
                                          .jobCategory!
                                          .first['name'])
                                  ],
                                ),
                                type != null
                                    ? sbH20()
                                    : Text(
                                        checkString(jobs![index].companyName),
                                        style: wb5l11),
                                Text(
                                    checkString(
                                      jobs![index].title,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    style: sww15),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.pin_drop,
                                      color: onPrimary,
                                      size: fs13,
                                    ),
                                    Expanded(
                                      child: Text(
                                          checkString(jobs![index].location),
                                          overflow: TextOverflow.ellipsis,
                                          style: wb5l11),
                                    ),
                                  ],
                                ),
                                type == 'company'
                                    ? sbH20()
                                    : type == 'resume'
                                        ? Text(
                                            checkReumeRate(jobs![index])!,
                                            style: sww15,
                                          )
                                        : Text(
                                            checkSalaryRate(jobs![index])!,
                                            style: sww15,
                                          ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (jobs![index].jobType!.isNotEmpty &&
                                        type == null)
                                      bottomButton(
                                          jobs![index].jobType!.first['name']),
                                    if (type == 'company')
                                      bottomButton(
                                          puralCheck(jobs![index].jobPosted)),
                                    Container(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: onPrimary,
                                    )
                                  ],
                                )
                              ],
                            ),
                            start: bt1,
                            end: bt2,
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }

  Widget bottomButton(var bt) {
    return RoundedButton(
      radius: p5,
      title: checkString(bt),
    );
  }

  Widget category(String? cat) {
    return RoundedCard(
        pd: p5, color: bt1, child: Text(checkString(cat), style: wb7l11));
  }
}
