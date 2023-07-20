import 'package:cariera/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_translator/google_translator.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/job_model.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/methods.dart';
import '../view_model/company_view_model.dart';
import '../widgets/big_rounded_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/overview.dart';
import '../widgets/register_card.dart';
import '../widgets/rounded_color_container.dart';
import '../widgets/rounded_container.dart';
import '../widgets/rounded_network_image.dart';
import '../widgets/sb10.dart';
import 'google_map_view.dart';

// ignore: must_be_immutable
class CompanyView extends StatelessWidget {
  CompanyView({Key? key, this.id}) : super(key: key);
  String? id;
  JobModel? job;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        // ignore: deprecated_member_use
        onViewModelReady: (dynamic model) {
          model.getCompany(id);
        },
        viewModelBuilder: () => CompanyViewModel(),
        builder: (context, dynamic model, child) {
          job = model.company;

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              children: [
                if (job != null)
                  if (job!.companyEmail != null && job!.companyEmail != '')
                    BigRoundedButton(
                      onPress: () async {
                        if (job!.companyEmail != null &&
                            job!.companyEmail != '') {
                          // ignore: deprecated_member_use
                          if (!await launch('mailto:${job!.companyEmail}')) {
                            throw 'Could not launch ${job!.companyEmail}';
                          }
                        }
                      },
                      title: 'Contact Us',
                      radius: defualtRadius,
                    ),
              ],
            ),
            backgroundColor: bg,
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, defaultAppBarHeight),
                child: CustomAppBar(
                    rightIcon: Icons.share,
                    rightPress: () {
                      Method.share(job!.link);
                    })),
            body: model.isError == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : model.isError
                    ? Empty(
                        title: 'No Company Details Found!',
                      )
                    : ListView(
                        children: [
                          sbH20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedNetworkImage(
                                  image: model.company.companyImage,
                                  defaultImage:
                                      AppConstants.defaultCompanyImage,
                                  width: defaultJobDetailImage,
                                  height: defaultJobDetailImage,
                                  radius: defualtRadius)
                            ],
                          ),
                          sbH10(),
                          Text(
                            checkString(job!.title),
                            textAlign: TextAlign.center,
                            style: swb20,
                          ).translate(),
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
                                    checkString(job!.location),
                                    style: s2,
                                  ).translate()
                                ],
                              )
                            ],
                          ),
                          sbH20(),
                          info(model, context),
                          if (model.isOverview) mapView(context),
                          if (model.isOverview) sbH20(),
                          sbH50(),
                        ],
                      ),
          );
        });
  }

  Widget mapView(context) {
    return job!.lat != null && job!.long != null
        ? RoundedContainer(
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width,
            radius: defualtRadius * 1.5,
            child: GoogleMapScreen(
              lat: job!.lat,
              long: job!.long,
              title: job!.title,
              description: job!.location,
            ))
        : Container();
  }

  Widget info(model, context) {
    return RoundedColorContainer(
      margin: const EdgeInsets.all(defualtPadding),
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
                    title: 'Company Overview',
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
              type: 'company',
              job: job,
            ),
          if (model.isDescription) description(model),
        ],
      ),
    );
  }

  Widget description(model) {
    return Html(
      style: {
        'html': Style(textAlign: TextAlign.justify),
      },
      data: checkString(job!.content),
    );
  }
}
