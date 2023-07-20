
import 'package:cariera/models/blog_model.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:cariera/view_model/blog_details_view_model.dart';
import 'package:cariera/widgets/appbar_background.dart';
import 'package:cariera/widgets/date_design.dart';
import 'package:cariera/widgets/padding_wrapper.dart';
import 'package:cariera/widgets/rounded_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../widgets/top_appbar_btn.dart';

// ignore: must_be_immutable
class BlogDetailsView extends StatelessWidget {
  BlogDetailsView({Key? key, this.blog}) : super(key: key);

  BlogModel? blog;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => BlogDetailsViewModel(),
        builder: (context, dynamic model, child) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  AppbarBackground(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TopAppbarBtn(
                        textStyle: sww20,
                        title: 'Details',
                        leftIcon: Icons.arrow_back_ios,
                        leftFun: () {
                          Get.back();
                        },
                        rightIcon: Icons.share,
                        rightFun: () async {
                          Method.share(blog!.link);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(defualtPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defualtRadius)),
                        child: RoundedNetworkImage(
                          image: blog!.image,
                          width: size.width * 0.8,
                          height: size.width / 2.5,
                        ),
                      ),
                      PaddingWapper(
                        l: defualtPadding * 2,
                        r: defualtPadding * 2,
                        child: Text(
                          blog!.title!,
                          style: sbb15,
                        ),
                      ),
                      PaddingWapper(
                          l: defualtPadding * 2,
                          r: defualtPadding * 2,
                          b: defualtPadding / 2,
                          child: DateDesign(
                            date: date(blog!.date),
                          )),
                      Expanded(
                          child: ListView(
                        children: [
                          PaddingWapper(
                              l: defualtPadding * 2,
                              r: defualtPadding * 2,
                              child: Html(
                                style: {
                                  'html': Style(textAlign: TextAlign.justify),
                                },
                                data: blog!.content,
                              ))
                        ],
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
