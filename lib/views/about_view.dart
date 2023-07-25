import 'package:cariera/utils/colors.dart';
import 'package:cariera/widgets/custom_appbar.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constant.dart';
import '../widgets/rounded_card.dart';
import '../widgets/rounded_network_image.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, defaultAppBarHeight),
          child: CustomAppBar(
            title: 'About',
            centerTitle: true,
          )),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            sbH20(),
            RoundedNetworkImage(
              defaultImage: AppConstants.icon,
              height: 100,
              width: 100,
            ),
            sbH10(),
            Text(
              AppConstants.version,
              style: grey12,
            ).translate(),
            sbH20(),
            Container(
              padding: const EdgeInsets.only(
                  left: defualtPadding, right: defualtPadding),
              child: Column(
                children: [
                  aboutTile(
                      icon: Icons.info_outline,
                      title: 'Information',
                      onTap: () async {
                        // ignore: deprecated_member_use
                        if (!await launch(AppConstants.informationURL)) {
                          throw 'Could not launch ${AppConstants.informationURL}';
                        }
                      }),
                  sbH10(),
                  aboutTile(
                      icon: Icons.description_outlined,
                      title: 'Support',
                      onTap: () async {
                        // ignore: deprecated_member_use
                        if (!await launch(
                            'mailto:${AppConstants.supportEmail}')) {
                          throw 'Could not launch ${AppConstants.supportEmail}';
                        }
                      }),
                  sbH10(),
                  aboutTile(
                      icon: Icons.description_outlined,
                      title: 'Privacy Policy',
                      onTap: () async {
                        // ignore: deprecated_member_use
                        if (!await launch(AppConstants.informationURL)) {
                          throw 'Could not launch ${AppConstants.informationURL}';
                        }
                      }),
                ],
              ),
            ),
            sbH50(),
            Text(
              AppConstants.copyright,
              style: grey12,
            ).translate(),
          ],
        ),
      ),
    );
  }
}

Widget aboutTile({icon, required title, url, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: RoundedCard(
      elevation: 1,
      color: bg,
      pd: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 23,
                color: aboutIconColor,
              ),
              sbW10(),
              Text(
                title,
                style: s15boldark,
              ).translate(),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    ),
  );
}
