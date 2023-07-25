import 'package:cariera/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../models/job_model.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/methods.dart';
import 'rounded_network_image.dart';

// ignore: must_be_immutable
class MyListingItem extends StatelessWidget {
  MyListingItem(
      {Key? key, this.jobs, this.onTap, this.type, this.model, this.url})
      : super(key: key);
  JobModel? jobs;
  Function? onTap;
  String? type, url;
  dynamic model;
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
                  if (type == 'job')
                    Text(
                      checkString(jobs!.companyName),
                      style: grey12,
                    ).translate(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          checkString(jobs!.title),
                          overflow: TextOverflow.ellipsis,
                          style: sbb15,
                        ).translate(),
                      ),
                      PopupMenu(
                          jobModel: jobs, type: type, model: model, url: url)
                      // IconButton(
                      //   icon: const Icon(Icons.more_vert_outlined),
                      //   onPressed: () {
                      //     // dialog(context, 'Remove ${checkPerfect(type)}',
                      //     //     'Are you sure to remove?',
                      //     //     isRemove: true, buttonText: 'Remove', onTap: () {
                      //     //   Get.back();
                      //     // });
                      //   },
                      // )
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
}
