
import 'package:cariera/models/job_model.dart';
import 'package:flutter/material.dart';

import '../utils/methods.dart';
import 'job_tile.dart';

// ignore: must_be_immutable
class OverView extends StatelessWidget {
  OverView({
    Key? key,
    this.job,
    this.type,
  }) : super(key: key);
  JobModel? job;
  String? type;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (job!.postedDate != null && job!.postedDate != '')
          JobTile(
              title: 'Date Posted',
              subTitle: date(job!.postedDate),
              icon: Icons.date_range),
        if (job!.location != null && job!.location != '')
          JobTile(
            title: 'Location',
            subTitle: job!.location,
            icon: Icons.location_on_outlined,
          ),
        if (job!.careerLevel!.isNotEmpty)
          JobTile(
            title: 'Career Level',
            subTitle: job!.careerLevel!.first['name'],
            icon: Icons.insights,
          ),
        if (job!.jobExperience!.isNotEmpty)
          JobTile(
            title: 'Experience',
            subTitle: job!.jobExperience!.first['name'],
            icon: Icons.engineering_outlined,
          ),
        if (job!.jobQualification!.isNotEmpty)
          JobTile(
            title: 'Qualification',
            subTitle: job!.jobQualification!.first['name'],
            icon: Icons.business_center_outlined,
          ),
        if (checkSalaryTitle(job!) != null)
          JobTile(
            title: checkSalaryTitle(job!),
            subTitle: checkSalaryRate(job!),
            icon: Icons.monetization_on_outlined,
          ),
        if (job!.resumeTitle!.isNotEmpty && type == 'resume')
          JobTile(
            title: 'Occupation',
            subTitle: job!.resumeTitle,
            icon: Icons.business_center_outlined,
          ),
        if (job!.resumeCategory!.isNotEmpty && type == 'resume')
          JobTile(
            title: 'Category',
            subTitle: job!.resumeCategory,
            icon: Icons.category_outlined,
          ),
        if (job!.resumeRate!.isNotEmpty && type == 'resume')
          JobTile(
              title: 'Rate',
              subTitle: checkReumeRate(job!),
              icon: Icons.monetization_on_outlined),
        if (job!.resumeEducationLevel!.isNotEmpty && type == 'resume')
          JobTile(
            title: 'Education Level',
            subTitle: job!.resumeEducationLevel,
            icon: Icons.school_outlined,
          ),
        if (job!.language!.isNotEmpty && type == 'resume')
          JobTile(
            title: 'Language',
            subTitle: job!.language,
            icon: Icons.g_translate_outlined,
          ),
        if (job!.resumeExperience!.isNotEmpty && type == 'resume')
          JobTile(
            title: 'Experience',
            subTitle: job!.resumeExperience,
            icon: Icons.engineering_outlined,
          ),
        if (job!.careerLevel!.isNotEmpty && type == 'company')
          JobTile(
            title: 'Career Level',
            subTitle: job!.careerLevel!.first['name'],
            icon: Icons.insights,
          ),
        if (job!.jobExperience!.isNotEmpty && type == 'company')
          JobTile(
            title: 'Experience',
            subTitle: job!.jobExperience!.first['name'],
            icon: Icons.work_outline,
          ),
        if (job!.jobQualification!.isNotEmpty && type == 'company')
          JobTile(
            title: 'Qualification',
            subTitle: job!.jobQualification!.first['name'],
            icon: Icons.business_center_outlined,
          ),
        if (job!.companyCategory!.isNotEmpty && type == 'company')
          JobTile(
              title: 'Category',
              subTitle: job!.companyCategory,
              icon: Icons.category_outlined),
        if (job!.sinceCompany!.isNotEmpty && type == 'company')
          JobTile(
            title: 'Since',
            subTitle: job!.sinceCompany,
            icon: Icons.schedule_outlined,
          ),
        if (job!.companyTeamSize!.isNotEmpty && type == 'company')
          JobTile(
            title: 'Team Size',
            subTitle: job!.companyTeamSize,
            icon: Icons.group_outlined,
          ),
        if (job!.jobPosted != null && type == 'company')
          JobTile(
            title: 'Posted Jobs',
            subTitle: '${job!.jobPosted}',
            icon: Icons.business_center_outlined,
          ),
        if (checkSalaryTitle(job!) != null && type == 'company')
          JobTile(
            title: checkSalaryTitle(job!),
            subTitle: checkSalaryRate(job!),
            icon: Icons.monetization_on,
          ),
      ],
    );
  }
}
