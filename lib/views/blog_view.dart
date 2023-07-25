import 'package:cariera/models/blog_model.dart';
import 'package:cariera/utils/colors.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/view_model/blog_view_model.dart';
import 'package:cariera/widgets/blogs_listing.dart';
import 'package:cariera/widgets/sb10.dart';
import 'package:cariera/widgets/search_field.dart';
import 'package:cariera/widgets/verticalShimmerList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class BlogView extends StatelessWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => BlogViewModel(),
        // ignore: deprecated_member_use
        onViewModelReady: (dynamic model) {
          model.blogs();
          model.initialise();
        },
        builder: (context, dynamic model, child) {
          return Scaffold(
            backgroundColor: bg,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 150,
              elevation: 0,
              backgroundColor: bg,
              centerTitle: true,
              title: Column(
                children: [
                  sbH10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: dark,
                          )),
                      Text(
                        'Blog',
                        style: swb20,
                      ).translate(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: bg,
                          ))
                    ],
                  ),
                  sbH20(),
                  searchTextField(
                    controller: model.searchQueryController,
                    hint: 'Search',
                    obscureText: false,
                    sufix: Icons.search,
                    type: TextInputType.text,
                  ),
                ],
              ),
            ),
            body: model.isloading
                ? const VerticalShimmerList()
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    physics: const BouncingScrollPhysics(),
                    footer: const ClassicFooter(
                        // loadStyle: LoadStyle.ShowWhenLoading,
                        loadingText: AppConstants.loadPosts,
                        noDataText: AppConstants.noPosts,
                        canLoadingText: AppConstants.loading),
                    controller: model.getRefresh,
                    child: BlogsListing(
                      blog: model.isSearch ? model.searchResult : model.blog,
                      model: model,
                    ),
                    onRefresh: () => model.onRefresh(),
                    onLoading: () => model.onLoading(),
                  ),
          );
        });
  }

  Widget search(model) {
    List data = model.searchResult;
    return data.isEmpty
        ? Center(
            child: Text('No Result Found!').translate(),
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  BlogModel? blog = await model.singleBlog(data[index]['id']);
                  model.gotoDetails(blog);
                },
                leading: const Icon(
                  Icons.search,
                  color: primary,
                ),
                title: Text(data[index]['title']).translate(),
              );
            });
  }

  // Widget _blogs(model) {
  //   return model.blog == null
  //       ? const Center(
  //           child: CircularProgressIndicator(),
  //         )
  //       : model.blog.isEmpty
  //           ? Empty()
  //           : ListView.builder(
  //               itemCount: model.blog.length,
  //               itemBuilder: (context, index) {
  //                 return InkWell(
  //                   onTap: () {
  //                     model.gotoDetails(model.blog[index]);
  //                   },
  //                   child: Container(
  //                     margin: const EdgeInsets.only(
  //                         left: defualtPadding,
  //                         right: defualtPadding,
  //                         top: ls10,
  //                         bottom: ls10),
  //                     decoration: BoxDecoration(
  //                         color: onPrimary,
  //                         borderRadius: BorderRadius.circular(20)),
  //                     padding: const EdgeInsets.all(10),
  //                     child: Row(
  //                       children: [
  //                         RoundedNetworkImage(
  //                           image: model.blog[index].image,
  //                           height: 85,
  //                           width: 80,
  //                         ),
  //                         sbW20(),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               checkString(model.blog[index].title),
  //                               style: sbb15,
  //                             ),
  //                             sbH10(),
  //                             DateDesign(date: date(model.blog[index].date)),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               });
  // }
}
