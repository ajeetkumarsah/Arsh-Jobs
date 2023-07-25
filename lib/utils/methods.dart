import 'package:cariera/models/job_model.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Method {
  static welcomeName(SharedPreferences sp) {
    String? name, username, fName;
    username = sp.getString(AppConstants.displayName);
    fName = sp.getString(AppConstants.firstName);
    if (fName != null && fName != '') {
      name = fName;
    } else {
      name = username;
    }
    return name;
  }

  static share(link) async {
    if (link != '') {
      await Share.share(link);
    } else {
      Method.showToast('nothing to share!');
    }
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

String checkString(String? s) {
  s ??= 'N/A';
  return s;
}

String checkStringEmpty(String? s) {
  s ??= '';
  return s;
}

String fullName(f, l) {
  return '$f $l';
}

String roll(r) {
  return '$r';
}

String puralCheck(var val) {
  String result;
  if (val <= 1) {
    result = '$val job';
  } else {
    result = '$val jobs';
  }
  return result;
}

String date(String? d) {
  final f = DateFormat('MMMM d, yyyy');
  DateTime dt;
  if (d == null) {
    dt = DateTime.now();
  } else {
    dt = DateTime.parse(d);
  }
  return f.format(dt);
}

String? checkSalaryRate(JobModel job) {
  String? range;

  if (job.minSalary!.isNotEmpty && job.maxSalary!.isNotEmpty) {
    range = currencyLogoPosition(job.minSalary, job.maxSalary);
  } else if (job.minSalary!.isEmpty &&
      job.maxSalary!.isEmpty &&
      job.minRate!.isEmpty &&
      job.maxRate!.isEmpty) {
    range = AppConstants.noSalary;
  } else {
    range = currencyLogoPosition(job.minRate, job.maxRate) + '/hr';
  }
  return range;
}

String? checkReumeRate(JobModel job) {
  String? range = '';

  if (job.resumeRate!.isNotEmpty) {
    range = currencyLogoResumePosition(job.resumeRate) + '/hour';
  }
  return range;
}

String? checkSalaryTitle(JobModel job) {
  String? title;

  if (job.minSalary!.isNotEmpty && job.maxSalary!.isNotEmpty) {
    title = 'Salary';
  } else if (job.minSalary!.isEmpty &&
      job.maxSalary!.isEmpty &&
      job.minRate!.isEmpty &&
      job.maxRate!.isEmpty) {
    title = null;
  } else {
    title = 'Rate';
  }
  return title;
}

currencyLogoPosition(min, max) {
  String range;
  if (AppConstants.isCurrencyLogoLeft) {
    range =
        '${AppConstants.defaultCurrency}$min - ${AppConstants.defaultCurrency}$max';
  } else {
    range =
        '$min${AppConstants.defaultCurrency} - $max${AppConstants.defaultCurrency}';
  }
  return range;
}

currencyLogoResumePosition(val) {
  String range;
  if (AppConstants.isCurrencyLogoLeft) {
    range = '${AppConstants.defaultCurrency}$val';
  } else {
    range = '$val${AppConstants.defaultCurrency}';
  }
  return range;
}

String? checkListingLogo(JobModel? job, String? type) {
  String? logo;
  if (type == 'resume') {
    logo = job!.resumeImage;
  } else if (type == 'company') {
    logo = job!.companyImage;
  } else {
    logo = job!.companyLogo;
  }
  return logo;
}

String getDefaultListingImage(String? type) {
  String image;
  if (type == 'resume') {
    image = AppConstants.defaultResumeImage;
  } else if (type == 'company') {
    image = AppConstants.defaultCompanyImage;
  } else {
    image = AppConstants.defaultJobImage;
  }
  return image;
}

String checkListingTitle(String? type) {
  String title;
  if (type == 'resume') {
    title = 'Resumes';
  } else if (type == 'company') {
    title = 'Companies';
  } else {
    title = 'Jobs';
  }
  return title;
}

String? checkListingCount(String? type, String countType, User? user) {
  String? count;
  if (type == 'resume') {
    if (countType == 'Pending') {
      count = user!.cariera!.resumesPending;
    } else if (countType == 'Expired') {
      count = user!.cariera!.resumesExpired;
    }
  } else if (type == 'company') {
    if (countType == 'Pending') {
      count = user!.cariera!.companiesPending;
    } else if (countType == 'Published') {
      count = user!.cariera!.companiesPublished;
    }
  } else {
    if (countType == 'Pending') {
      count = user!.cariera!.jobsPending;
    } else if (countType == 'Expired') {
      count = user!.cariera!.jobsExpired;
    }
  }
  return count;
}

String checkListingFeaturedAPI(String type, String listType) {
  String api;
  if (type == 'resume') {
    api = listType == 'feature'
        ? AppConstants.featuredResumes
        : AppConstants.unFeaturedResumes;
  } else if (type == 'company') {
    api = listType == 'feature'
        ? AppConstants.featuredCompanies
        : AppConstants.unFeaturedCompanies;
  } else {
    api = listType == 'feature'
        ? AppConstants.featuredJobs
        : AppConstants.unFeaturedJobs;
  }

  return api;
}

String listTypeCheck(String s) {
  if (s == 'unfeature') {
    s = 'Latest';
  } else {
    s = 'Featured';
  }
  return s;
}

String checkPerfect(String? type) {
  String perfect;
  if (type == 'resume') {
    perfect = 'Candidate';
  } else if (type == 'company') {
    perfect = 'Company';
  } else {
    perfect = 'Job';
  }
  return perfect;
}

String checkType(String? type) {
  String perfect;
  if (type == 'resume') {
    perfect = 'Resume';
  } else if (type == 'company') {
    perfect = 'Company';
  } else {
    perfect = 'Job';
  }
  return perfect;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 20000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

loading(status) {
  EasyLoading.show(status: status);
}

dismissLoading() {
  if (EasyLoading.isShow) {
    EasyLoading.dismiss();
  }
}

size(context) {
  Size size = MediaQuery.of(context).size;
  return size;
}

bool isLoading() {
  return EasyLoading.isShow;
}

dialog(context, title, subTitle,
    {String buttonText = 'Ok', bool isRemove = false, Function? onTap}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title).translate(),
            content: Text(subTitle).translate(),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 15,
                      ),
                      Text(
                        buttonText,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 13),
                      ).translate(),
                    ],
                  ),
                ),
              ),
            ],
          ));
}
