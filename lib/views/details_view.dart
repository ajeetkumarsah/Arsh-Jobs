import 'package:cariera/models/job_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/view_model/details_view_model.dart';
import 'package:cariera/views/company_view.dart';
import 'package:cariera/views/google_map_view.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:cariera/widgets/default_pad_lr.dart';
import 'package:cariera/widgets/overview.dart';
import 'package:cariera/widgets/register_card.dart';
import 'package:cariera/widgets/rounded_card.dart';
import 'package:cariera/widgets/rounded_color_container.dart';
import 'package:cariera/widgets/rounded_container.dart';
import 'package:cariera/widgets/rounded_network_image.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/big_rounded_button.dart';

// ignore: must_be_immutable
class DetailsView extends StatelessWidget {
  DetailsView({Key? key, this.job, this.type}) : super(key: key);
  JobModel? job;
  String? type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => DetailsViewModel(),
        builder: (context, dynamic model, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: type == 'resume' || type == 'company'
                ? Row(
                    children: [
                      if ((job!.resumeEmail != null &&
                              job!.resumeEmail != '') ||
                          (job!.companyEmail != null &&
                              job!.companyEmail != ''))
                        BigRoundedButton(
                          onPress: () async {
                            if (job!.resumeEmail != null &&
                                job!.resumeEmail != '' &&
                                type == 'resume') {
                              // ignore: deprecated_member_use
                              if (!await launch('mailto:${job!.resumeEmail}')) {
                                throw 'Could not launch ${job!.resumeEmail}';
                              }
                            } else if (job!.companyEmail != null &&
                                job!.companyEmail != '' &&
                                type == 'company') {
                              // ignore: deprecated_member_use
                              if (!await launch(
                                  'mailto:${job!.companyEmail}')) {
                                throw 'Could not launch ${job!.companyEmail}';
                              }
                            }
                          },
                          title: 'Contact Us',
                          radius: defualtRadius,
                        ),
                    ],
                  )
                : Container(),
            backgroundColor: bg,
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, defaultAppBarHeight),
                child: CustomAppBar(
                  rightIcon: Icons.share,
                  rightPress: () async {
                    Method.share(job!.link);
                  },
                )),
            body: ListView(
              children: [
                //LOGO
                sbH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if ((type == 'job' || type == null) &&
                            job!.companyID!.isNotEmpty) {
                          Get.to(() => CompanyView(
                                id: job!.companyID,
                              ));
                        }
                      },
                      child: RoundedNetworkImage(
                          image: checkListingLogo(job, type),
                          defaultImage: AppConstants.defaultCompanyImage,
                          width: defaultJobDetailImage,
                          height: defaultJobDetailImage,
                          radius: defualtRadius),
                    )
                  ],
                ),
                //TITLE
                sbH10(),

                Text(
                  checkString(job?.title),
                  textAlign: TextAlign.center,
                  style: swb20,
                ).translate(),

                //LOCATION
                sbH10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          color: primary,
                          size: 15,
                        ),
                        Text(
                          checkString(job?.location),
                          style: s2,
                        ).translate()
                      ],
                    )
                  ],
                ),
                //COMPANY INFO
                sbH10(),
                if (type == 'job' || type == null)
                  InkWell(
                    onTap: () {
                      if (job!.companyID!.isNotEmpty) {
                        Get.to(() => CompanyView(
                              id: job!.companyID,
                            ));
                      }
                    },
                    child: PadLR(
                      child: Row(
                        children: [
                          Expanded(
                            child: RoundedCard(
                              pd: 20,
                              elevation: 0,
                              color: primary.withOpacity(0.07),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    checkString(job?.companyName) == ''
                                        ? 'No Company'
                                        : checkString(job?.companyName),
                                    style: swp15,
                                  ).translate(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                if (type == 'job' || type == null) sbH20(),
                info(model, context),
                if (model.isOverview) mapView(context, model),
                sbH10(),
              ],
            ),
          );
        });
  }

  Widget mapView(context, model) {
    return job!.lat != null && job!.long != null
        ? Container(
            padding: EdgeInsets.only(
                bottom: type == 'resume' || type == 'company'
                    ? defualtPadding * 3
                    : 0),
            child: RoundedContainer(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width,
                radius: defualtRadius * 1.5,
                child: GoogleMapScreen(
                  lat: job!.lat,
                  long: job!.long,
                  image: null,
                  title: job!.title,
                  description: job!.location,
                )),
          )
        : Container();
  }

  Widget info(model, context) {
    return RoundedColorContainer(
      margin: const EdgeInsets.only(
          left: defualtPadding,
          right: defualtPadding,
          top: defualtPadding,
          bottom: defualtPadding),
      padding: const EdgeInsets.only(
          top: defualtPadding, bottom: defualtPadding, left: 10, right: 10),
      radius: defualtRadius,
      color: primary.withOpacity(0.07),
      child: Column(
        children: [
          RoundedColorContainer(
            radius: defualtRadius,
            color: bg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: RegisterCard(
                    title: 'Description',
                    elevation: 0,
                    isPress: model.isDescription,
                    onPressed: () {
                      model.isCheck(true, false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RegisterCard(
                    title: '${checkType(type)} Overview',
                    elevation: 0,
                    isPress: model.isOverview,
                    onPressed: () {
                      model.isCheck(false, true);
                    },
                  ),
                )
              ],
            ),
          ),
          sbH20(),
          if (model.isOverview)
            OverView(
              type: type,
              job: job,
            ),
          if (model.isDescription) description(model),
        ],
      ),
    );
  }

  Widget description(model) {
    return Container(
      padding: EdgeInsets.only(
          bottom:
              type == 'resume' || type == 'company' ? defualtPadding * 3 : 0),
      child: Html(
        style: {
          'html': Style(textAlign: TextAlign.justify),
        },
        data: checkString(job!.content),
      ),
    );
  }
}
