import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/dashboard_view_model.dart';
import 'package:cariera/views/jobs_view.dart';
import 'package:cariera/views/resumes_view.dart';
import 'package:cariera/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

import 'home_view.dart';
import 'profile_view.dart';

// ignore: must_be_immutable
class DashboardView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardView({Key? key}) : super(key: key);
  bool remember = false;
  final tabs = [
    const Home(),
    JobsView(
      isFav: true,
      url: AppConstants.jobs,
      searchUrl: AppConstants.searchJobs,
    ),
    ResumesView(
      type: 'resume',
      url: AppConstants.resumes,
      searchUrl: AppConstants.searchResumes,
    ),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onViewModelReady: (DashboardViewModel model) {
          model.initSP();
        },
        builder: (context, DashboardViewModel model, child) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: const MainDrawer(),
              key: _scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: bg,
                elevation: 0,
                actions: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Container(
                        padding: const EdgeInsets.only(right: dp),
                        child: SvgPicture.asset('assets/svgs/menu.svg')),
                  )
                ],
                title: SizedBox(
                  height: 60,
                  child: Image.asset(
                    AppConstants.logo,
                  ),
                ),
              ),
              backgroundColor: bg,
              body: SafeArea(child: tabs[model.index]),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: model.index,
                  backgroundColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedIconTheme: const IconThemeData(color: primary),
                  unselectedIconTheme: const IconThemeData(color: dark),
                  type: BottomNavigationBarType.fixed,
                  onTap: model.updateIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.business_center_outlined), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.assignment_outlined), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle_outlined), label: ''),
                  ]));
        });
  }
}
