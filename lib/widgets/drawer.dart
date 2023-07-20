import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/blog_view.dart';
import 'package:cariera/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/methods.dart';
import 'circular_image_avatar.dart';
import 'drawer_custom_scaffold.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late SharedPreferences sp;
  String? first, last, role, userID, userImage;
  @override
  void initState() {
    super.initState();
    initSP();
  }

  initSP() async {
    sp = await SharedPreferences.getInstance();
    first = sp.getString(AppConstants.firstName);
    last = sp.getString(AppConstants.lastName);
    role = sp.getString(AppConstants.role);
    userID = sp.getString(AppConstants.userID);
    userImage = sp.getString(AppConstants.userImage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: onPrimary,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: defualtIcon * 2),
            child: userID == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularImageAvatar(
                        image: userImage,
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        fullName(
                            checkStringEmpty(first), checkStringEmpty(last)),
                        style: const TextStyle(
                          fontSize: fs18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        roll(checkStringEmpty(role)),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Get.to(() => DrawerCustomScaffold(
                    type: 'company',
                    url: AppConstants.companies,
                    search: AppConstants.searchCompanies,
                    title: 'Companies',
                  ));
            },
            leading: const Icon(
              Icons.business_outlined,
              color: dark,
            ),
            title: const Text("Companies"),
          ),
          ListTile(
            onTap: () {
              Get.to(() => DrawerCustomScaffold(
                    type: 'resume',
                    url: AppConstants.resumes,
                    search: AppConstants.searchResumes,
                    title: 'Resumes',
                  ));
            },
            leading: const Icon(
              Icons.assignment_outlined,
              color: dark,
            ),
            title: const Text("Resumes"),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const BlogView());
            },
            leading: const Icon(
              Icons.book_outlined,
              color: dark,
            ),
            title: const Text("Blog"),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              if (userID == null) {
                Get.to(() => LoginView(
                      isBack: true,
                    ));
              } else {
                sp.remove(AppConstants.userID);
                sp.remove(AppConstants.email);
                sp.remove(AppConstants.role);
                sp.remove(AppConstants.authToken);
                sp.remove(AppConstants.firstName);
                sp.remove(AppConstants.lastName);
                sp.remove(AppConstants.displayName);
                Get.back();
              }
            },
            leading: Icon(
              userID == null ? Icons.login_outlined : Icons.logout_outlined,
              color: dark,
            ),
            title: Text(userID == null ? "Login" : "Logout"),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ]),
      ),
    );
  }
}
