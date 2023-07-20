import 'package:cariera/views/login_view.dart';
import 'package:cariera/widgets/card.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';

import 'about_view.dart';
import 'account_view.dart';

// ignore: use_key_in_widget_constructors
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = size.width / 2;
    final double itemWidth = size.width / 2;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (ProfileViewModel model) {
          model.initSP();
        },
        builder: (context, ProfileViewModel model, child) {
          return model.userID == null
              ? LoginView()
              : ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: dp),
                      child: Row(
                        children: [
                          Text(
                            'Welcome, ',
                            style: swb20,
                          ).translate(),
                          Text(
                            model.firstName ?? '', //model.displayName,
                            style: swp20,
                          ).translate(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomCard(
                                  height: itemHeight,
                                  width: itemWidth,
                                  title:
                                      'Published\n${model.isCandidate ? 'Resumes' : 'Jobs'}',
                                  start: a2,
                                  end: a1,
                                  count:
                                      '${model.user != null ? (model.isCandidate ? model.user?.cariera?.resumesPublished : model.user?.cariera?.jobsPublished) : 0}',
                                  img: 'assets/svgs/a.svg',
                                ),
                              ),
                              Expanded(
                                child: CustomCard(
                                  title:
                                      'Pending\n${model.isCandidate ? 'Resumes' : 'Jobs'}',
                                  count:
                                      '${model.user != null ? (model.isCandidate ? model.user?.cariera?.resumesPending : model.user?.cariera?.jobsPending) : 0}',
                                  height: itemHeight,
                                  width: itemWidth,
                                  start: b2,
                                  end: b1,
                                  img: 'assets/svgs/b.svg',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomCard(
                                  height: itemHeight,
                                  width: itemWidth,
                                  title:
                                      'Expired\n${model.isCandidate ? 'Resumes' : 'Jobs'}',
                                  start: d2,
                                  end: d1,
                                  count:
                                      '${model.user != null ? (model.isCandidate ? model.user?.cariera?.resumesExpired : model.user?.cariera?.jobsExpired) : 0}',
                                  img: 'assets/svgs/a.svg',
                                ),
                              ),
                              Expanded(
                                child: CustomCard(
                                  title: 'Monthly\nViews',
                                  count:
                                      '${model.user != null ? model.user?.cariera?.monthlyViews : 0}',
                                  height: itemHeight,
                                  width: itemWidth,
                                  start: c2,
                                  end: c1,
                                  img: 'assets/svgs/b.svg',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Settings',
                        style: swb20,
                      ).translate(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.business_center_outlined),
                      title: const Text('My Jobs'),
                      onTap: () {
                        model.gotoListing(
                            'My Jobs', 'job', AppConstants.myJobs, model.user);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.business_outlined),
                      title: const Text('My Companies'),
                      onTap: () {
                        model.gotoListing('My Companies', 'company',
                            AppConstants.myCompanies, model.user);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.assignment_outlined),
                      title: const Text('My Resumes'),
                      onTap: () {
                        model.gotoListing('My Resumes', 'resume',
                            AppConstants.myResumes, model.user);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Change Language'),
                      onTap: () async {
                        // String? result = await Get.to(() => AccountView());
                        // if (result == 'refresh') {
                        //   model.initSP();
                        // }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Account'),
                      onTap: () async {
                        String? result = await Get.to(() => AccountView());
                        if (result == 'refresh') {
                          model.initSP();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About'),
                      onTap: () {
                        Get.to(() => const AboutView());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(model.userID != null ? 'Logout' : 'Login'),
                      onTap: () {
                        model.loginLogout();
                      },
                    ),
                  ],
                );
        });
  }
}
