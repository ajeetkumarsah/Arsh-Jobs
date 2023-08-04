import 'dart:async';

import 'package:cariera/services/service_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../models/blog_model.dart';
import '../models/job_model.dart';
import '../services/blog_service.dart';
import '../utils/constant.dart';

class DashboardViewModel extends BaseViewModel {
  int _index = 0;
  int get index => _index;
  //SERVICES
  BlogService blogService = BlogService();
  ServiceRepo serviceRepo = ServiceRepo();
  //JOBS
  List<JobModel>? _featuredJobs = [], _unFeaturedJobs = [];
  List<JobModel>? get featuredJobs => _featuredJobs;
  List<JobModel>? get unFeaturedJobs => _unFeaturedJobs;
  //COMPANIES
  List<JobModel>? _featuredCompanies = [], _unFeaturedCompanies = [];
  List<JobModel>? get featuredCompanies => _featuredCompanies;
  List<JobModel>? get unFeaturedCompanies => _unFeaturedCompanies;
  //RESUMES
  List<JobModel>? _featuredResumes = [], _unFeaturedResumes = [];
  List<JobModel>? get featuredResumes => _featuredResumes;
  List<JobModel>? get unFeaturedResumes => _unFeaturedResumes;
  //BLOGS
  List<BlogModel>? _blogs;
  List<BlogModel>? get blog => _blogs;

  bool featureButton = true, unFeatureButton = false, _isLoading = false;

  bool get isLoading => _isLoading;

  String? _userID;
  String? get userID => _userID;
  String? _firstName, _role;
  String? get firstName => _firstName;
  late SharedPreferences sp;

  void isCheck(bool description, bool overview) {
    featureButton = description;
    unFeatureButton = overview;

    notifyListeners();
  }

  Future getListings(job, company, resume) async {
    _isLoading = true;
    notifyListeners();
    await jobs(url: job);
    await companies(url: company);
    await resumes(url: resume);
    await blogs();
    _isLoading = false;
    notifyListeners();
  }

  Future jobs({int page = 0, required String url}) async {
    _featuredJobs = [];
    _unFeaturedJobs = [];
    List<List<JobModel>?>? data =
        await serviceRepo.getListing(page: page, url: url);
    _featuredJobs = data![0];

    _unFeaturedJobs = data[1];
  }

  Future companies({int page = 0, required String url}) async {
    _featuredCompanies = [];
    _unFeaturedCompanies = [];
    List<List<JobModel>?>? data =
        await serviceRepo.getListing(page: page, url: url);
    _featuredCompanies = data![0];
    _unFeaturedCompanies = data[1];
  }

  Future resumes({int page = 0, required String url}) async {
    _featuredResumes = [];
    _unFeaturedResumes = [];
    List<List<JobModel>?>? data =
        await serviceRepo.getListing(page: page, url: url);
    _featuredResumes = data![0];
    _unFeaturedResumes = data[1];
  }

  Future blogs({int page = 0}) async {
    List data = await blogService.blogs(page);
    if (data.isEmpty) {
      _blogs = [];
    } else {
      _blogs = data.map((blog) => BlogModel.fromMap(blog)).toList();
    }
  }

  updateIndex(int index) {
    _index = index;
    notifyListeners();
  }

  initSP() async {
    sp = await SharedPreferences.getInstance();
    _userID = sp.getString(AppConstants.userID);
    _firstName = sp.getString(AppConstants.firstName);
    _role = sp.getString(AppConstants.role);
    if (_role != null && _role!.startsWith('emp')) {
      updateIndex(2);
    } else if (_role != null && _role!.startsWith('cand')) {
      updateIndex(1);
    } else {
      updateIndex(0);
    }

    notifyListeners();
  }
}
