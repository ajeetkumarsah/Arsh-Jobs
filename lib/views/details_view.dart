import 'dart:async';
import 'dart:convert';

import 'package:cariera/controller/app_controller.dart';
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
import 'package:html/dom.dart' as dom;
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../widgets/big_rounded_button.dart';

// ignore: must_be_immutable
class DetailsView extends StatefulWidget {
  DetailsView({Key? key, this.job, this.type}) : super(key: key);
  JobModel? job;
  String? type;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final GoogleTranslationService translationService =
      GoogleTranslationService(AppConstants.googleApiKey);

  // Stream controller to emit translated text
  final StreamController<String> _translatedTextController =
      StreamController<String>();
  String _translatedText = '';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(sharedPreferences: Get.find()),
      builder: (ctlr) {
        return ViewModelBuilder.reactive(
            viewModelBuilder: () => DetailsViewModel(),
            onViewModelReady: (d) {
              if (isFirst) {
                translatelang(widget.job?.content ?? '',
                    lngCode: ctlr.locale.languageCode);
              }
            },
            builder: (context, dynamic model, child) {
              return Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: widget.type == 'resume' ||
                        widget.type == 'company'
                    ? Row(
                        children: [
                          if ((widget.job!.resumeEmail != null &&
                                  widget.job!.resumeEmail != '') ||
                              (widget.job!.companyEmail != null &&
                                  widget.job!.companyEmail != ''))
                            BigRoundedButton(
                              onPress: () async {
                                if (widget.job!.resumeEmail != null &&
                                    widget.job!.resumeEmail != '' &&
                                    widget.type == 'resume') {
                                  // ignore: deprecated_member_use
                                  if (!await launch(
                                      'mailto:${widget.job!.resumeEmail}')) {
                                    throw 'Could not launch ${widget.job!.resumeEmail}';
                                  }
                                } else if (widget.job!.companyEmail != null &&
                                    widget.job!.companyEmail != '' &&
                                    widget.type == 'company') {
                                  // ignore: deprecated_member_use
                                  if (!await launch(
                                      'mailto:${widget.job!.companyEmail}')) {
                                    throw 'Could not launch ${widget.job!.companyEmail}';
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
                    preferredSize:
                        const Size(double.infinity, defaultAppBarHeight),
                    child: CustomAppBar(
                      rightIcon: Icons.share,
                      rightPress: () async {
                        Method.share(widget.job!.link);
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
                            if ((widget.type == 'job' || widget.type == null) &&
                                widget.job!.companyID!.isNotEmpty) {
                              Get.to(() => CompanyView(
                                    id: widget.job!.companyID,
                                  ));
                            }
                          },
                          child: RoundedNetworkImage(
                              image: checkListingLogo(widget.job, widget.type),
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
                      checkString(widget.job?.title),
                      textAlign: TextAlign.center,
                      style: swb20,
                    ).translate(),

                    //LOCATION
                    sbH10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          color: primary,
                          size: 15,
                        ),
                        Flexible(
                          child: Text(
                            checkString(widget.job?.location),
                            style: s2,
                          ).translate(),
                        )
                      ],
                    ),
                    //COMPANY INFO
                    sbH10(),
                    if (widget.type == 'job' || widget.type == null)
                      InkWell(
                        onTap: () {
                          if (widget.job!.companyID!.isNotEmpty) {
                            Get.to(() => CompanyView(
                                  id: widget.job!.companyID,
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
                                        checkString(widget.job?.companyName) ==
                                                ''
                                            ? 'No Company'
                                            : checkString(
                                                widget.job?.companyName),
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
                    if (widget.type == 'job' || widget.type == null) sbH20(),
                    info(model, context),
                    if (model.isOverview) mapView(context, model),
                    sbH10(),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget mapView(context, model) {
    return widget.job!.lat != null && widget.job!.long != null
        ? Container(
            padding: EdgeInsets.only(
                bottom: widget.type == 'resume' || widget.type == 'company'
                    ? defualtPadding * 3
                    : 0),
            child: RoundedContainer(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width,
                radius: defualtRadius * 1.5,
                child: GoogleMapScreen(
                  lat: widget.job?.lat,
                  long: widget.job?.long,
                  image: null,
                  title: widget.job?.title,
                  description: widget.job?.location,
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
                    title: '${checkType(widget.type)} Overview',
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
              type: widget.type,
              job: widget.job,
            ),
          if (model.isDescription) description(model),
        ],
      ),
    );
  }

  Widget description(model) {
    return Container(
      padding: EdgeInsets.only(
          bottom: widget.type == 'resume' || widget.type == 'company'
              ? defualtPadding * 3
              : 0),
      child: _translatedText.isNotEmpty
          ? Expanded(
              child: SingleChildScrollView(
                child: Html(
                  style: {
                    'html': Style(textAlign: TextAlign.justify),
                  },
                  data: checkString(_translatedText), //job.content
                  onLinkTap: (String? url,
                      RenderContext context,
                      Map<String, String> attributes,
                      dom.Element? element) async {
                    //open URL in webview, or launch URL in browser, or any other logic here
                    final Uri _url = Uri.parse(url ?? '');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
              ),
            )
          : const SizedBox(),

      // StreamBuilder<String>(
      //   stream: _translatedTextController.stream,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return SingleChildScrollView(
      //         child:
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text('Error: ${snapshot.error}');
      //     } else {
      //       return Container(); // Placeholder or loading indicator
      //     }
      //   },
      // ),
    );
  }

  bool isFirst = true;

  void translatelang(String text, {String lngCode = 'en'}) async {
    isFirst = false;
    String translatedText =
        await translationService.translateText(text, lngCode);

    _translatedTextController.add(translatedText);
    setState(() {
      _translatedText = translatedText;
    });
  }
}

class GoogleTranslationService {
  final String apiKey;

  GoogleTranslationService(this.apiKey);

  Future<String> translateText(String text, String targetLanguage) async {
    final url =
        Uri.parse('https://translation.googleapis.com/language/translate/v2');
    final response = await http.post(url, body: {
      'key': apiKey,
      'source': 'en', // Source language code (English)
      'target': targetLanguage,
      'q': text,
    });

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
