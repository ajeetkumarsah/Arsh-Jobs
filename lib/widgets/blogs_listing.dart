import 'package:cariera/views/blog_details_view.dart';
import 'package:cariera/widgets/rounded_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import '../models/blog_model.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/methods.dart';
import 'date_design.dart';
import 'empty.dart';
import 'sb10.dart';

// ignore: must_be_immutable
class BlogsListing extends StatelessWidget {
  BlogsListing({Key? key, this.blog, this.model, this.limit}) : super(key: key);
  List<BlogModel>? blog;
  dynamic model;
  int? limit;
  @override
  Widget build(BuildContext context) {
    return blog!.isEmpty
        ? Empty()
        : ListView.builder(
            itemCount: limit ?? blog!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() => BlogDetailsView(
                        blog: blog![index],
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: defualtPadding,
                      right: defualtPadding,
                      top: ls10,
                      bottom: ls10),
                  decoration: BoxDecoration(
                      color: onPrimary,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      RoundedNetworkImage(
                        image: blog![index].thumbnail,
                        height: 85,
                        width: 80,
                      ),
                      sbW20(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              checkString(blog![index].title),
                              overflow: TextOverflow.ellipsis,
                              style: sbb15,
                            ).translate(),
                            sbH10(),
                            DateDesign(date: date(blog![index].date)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
