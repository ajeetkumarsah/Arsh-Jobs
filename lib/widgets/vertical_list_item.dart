import 'package:cariera/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/methods.dart';
import 'rounded_button.dart';
import 'rounded_network_image.dart';
import 'sb10.dart';

// ignore: must_be_immutable
class VerticalListItem extends StatelessWidget {
  VerticalListItem({Key? key, this.jobs, this.onTap, this.type})
      : super(key: key);
  JobModel? jobs;
  Function? onTap;
  String? type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.only(
            left: defualtPadding,
            right: defualtPadding,
            top: ls10,
            bottom: ls10),
        decoration: BoxDecoration(
            color: onPrimary,
            borderRadius: BorderRadius.circular(defualtRadius)),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: RoundedNetworkImage(
                defaultImage: getDefaultListingImage(type),
                image: checkListingLogo(jobs, type),
                height: 85,
                width: 80,
                radius: defualtRadius,
              ),
            ),
            const SizedBox(
              width: fs20,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == null)
                    Text(
                      checkString(jobs!.companyName),
                      overflow: TextOverflow.ellipsis,
                      style: gb5l11,
                    ).translate(),
                  Text(
                    checkString(jobs!.title),
                    overflow: TextOverflow.ellipsis,
                    style: sbb15,
                  ).translate(),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_drop,
                        color: Colors.grey,
                        size: fs13,
                      ),
                      Expanded(
                        child: Text(checkString(jobs?.location),
                                overflow: TextOverflow.ellipsis, style: gb5l11)
                            .translate(),
                      ),
                    ],
                  ),
                  type == null
                      ? Text(
                          checkSalaryRate(jobs!)!,
                          style: sbb15,
                        ).translate()
                      : Text(
                          checkReumeRate(jobs!)!,
                          style: sbb15,
                        ).translate(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      type == 'company'
                          ? bottomButton(
                              jobs!.jobPosted != null
                                  ? puralCheck(jobs!.jobPosted)
                                  : '',
                              jobs!.companyCategory ?? '')
                          : type == 'resume'
                              ? bottomButton(
                                  '',
                                  jobs!.resumeCategory!.isNotEmpty
                                      ? jobs!.resumeCategory!
                                      : '')
                              : bottomButton(
                                  jobs!.jobCategory!.isNotEmpty
                                      ? jobs!.jobCategory!.first['name']
                                      : '',
                                  jobs!.jobType!.isNotEmpty
                                      ? jobs!.jobType!.first['name']
                                      : ''),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: primary,
                        size: fs20,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String bt1, String bt2) {
    return Row(
      children: [
        if (bt1.isNotEmpty)
          RoundedButton(
            title: checkString(bt1),
            style: wp7l11,
            color: primary.withOpacity(0.2),
            radius: p5,
          ),
        sbW10(),
        if (bt2.isNotEmpty)
          RoundedButton(
            title: checkString(bt2),
            color: primary,
            radius: p5,
          ),
      ],
    );
  }
}
