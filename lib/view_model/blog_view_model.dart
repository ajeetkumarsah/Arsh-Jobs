import 'dart:async';

import 'package:cariera/models/blog_model.dart';
import 'package:cariera/services/blog_service.dart';
import 'package:cariera/services/generic_service.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/views/blog_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class BlogViewModel extends BaseViewModel with WidgetsBindingObserver {
  BlogService blogService = BlogService();
  List<BlogModel?>? _blogs;
  List<BlogModel?>? get blog => _blogs;
  int page = 0;
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _searchQueryController = TextEditingController();
  Timer? _debounce;
  String query = "";
  int debouncetime = 500;
  List<BlogModel?>? _searchResult;
  bool _isSearch = false, _isloading = false;
  bool get isSearch => _isSearch;

  bool get isloading => _isloading;
  List<BlogModel?>? get searchResult => _searchResult;
  TextEditingController get searchQueryController => _searchQueryController;
  RefreshController get getRefresh => _refreshController;

  Future<List<BlogModel?>?> blogs({int page = 0}) async {
    _isloading = true;
    notifyListeners();
    List data = await blogService.blogs(page);
    if (data.isEmpty) {
      _blogs = [];
    } else {
      _blogs = data
          .map((blog) => BlogModel.fromMap(blog))
          .cast<BlogModel>()
          .toList();
    }
    _isloading = false;

    notifyListeners();
    return _blogs;
  }

  gotoDetails(BlogModel blog) {
    Get.to(() => BlogDetailsView(
          blog: blog,
        ));
  }

//REFRESH & PAGINATION
  onLoading() async {
    page++;
    List data = await blogService.blogs(page);
    List<BlogModel?>? b = data.map((blog) => BlogModel.fromMap(blog)).toList();
    _blogs!.addAll(b);
    _refreshController.loadComplete();
    notifyListeners();
  }

  onRefresh() async {
    _blogs = await blogs();
    _refreshController.refreshCompleted();
    page = 0;
    notifyListeners();
  }

  void initialise() {
    _searchQueryController.addListener(_onSearchChanged);
    notifyListeners();
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();

    super.dispose();
  }

  _onSearchChanged() {
    _isloading = true;
    notifyListeners();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: debouncetime), () async {
      if (_searchQueryController.text != "") {
        _isSearch = true;
        List data = await GenericService.search(
            AppConstants.searchBlogs, _searchQueryController.text);

        _searchResult = data.map((blog) => BlogModel.fromMap(blog)).toList();
      } else {
        _isSearch = false;
      }
      _isloading = false;

      notifyListeners();
    });
  }

//SINGLE BLOG
  Future<BlogModel> singleBlog(int id) async {
    String url = '${AppConstants.blogs}/$id';
    var data = await blogService.single(url);
    BlogModel blog = BlogModel(
        id: data['id'],
        title: data['title']['rendered'],
        image: data['featured_media_url'],
        content: data['content']['rendered']);
    return blog;
  }
}
