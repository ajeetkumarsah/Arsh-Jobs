import 'dart:async';
import 'package:cariera/models/job_model.dart';
import 'package:cariera/models/taxonomy_model.dart';
import 'package:cariera/services/generic_service.dart';
import 'package:cariera/services/jobs_service.dart';
import 'package:cariera/utils/constant.dart';
import 'package:cariera/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class JobsViewModel extends BaseViewModel with WidgetsBindingObserver {
  JobService jobService = JobService();
  List<JobModel> _featuredJobs = [],
      _unFeaturedJobs = [],
      _searchUnFeaturedJobs = [],
      _searchFeaturedJobs = [];
  List? data;
  bool _isFilter = false;
  bool _isLoading = false;

  late SharedPreferences sp;
//SEARCH
  List? _searchResult;
  bool _isSearch = false, _isFilterPressed = false;
  Timer? _debounce;
  String query = "", username = '';
  int? _jobID, _catID;
  int page = 0, debouncetime = 500;
  List<TaxonomyModel>? _jobTypes, _categories;

  final _searchQueryController = TextEditingController();
  final TextEditingController _filterSearch = TextEditingController();
  final TextEditingController _filterLocation = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get getRefresh => _refreshController;

  TextEditingController get searchQueryController => _searchQueryController;

  bool get isSearch => _isSearch;
  bool get isFilterPressed => _isFilterPressed;
  bool get isLoading => _isLoading;

  bool get isFilter => _isFilter;

  List? get isData => data;
  List? get searchResult => _searchResult;
  List<TaxonomyModel>? get jobTypes => _jobTypes;
  List<TaxonomyModel>? get categories => _categories;
  List<JobModel> get featuredJobs => _featuredJobs;
  List<JobModel> get unFeaturedJobs => _unFeaturedJobs;
  List<JobModel> get searchFeaturedJobs => _searchFeaturedJobs;
  List<JobModel> get searchUnFeaturedJobs => _searchUnFeaturedJobs;
  late String searchUrl;
  int? get jobID => _jobID;
  int? get catID => _catID;

  TextEditingController get filterSearch => _filterSearch;
  TextEditingController get filterLocation => _filterLocation;

  getSPData() async {
    sp = await SharedPreferences.getInstance();
    username = Method.welcomeName(sp) ?? '';
    notifyListeners();
  }

  Future job({int page = 0, required String url}) async {
    getSPData();
    _isLoading = true;
    notifyListeners();
    data = await jobService.jobs(page, url);
    List<JobModel?>? jobList;
    _featuredJobs = [];
    _unFeaturedJobs = [];

    if (data!.isNotEmpty) {
      jobList = data!.map((job) => JobModel.fromMap(job)).toList();
    }
    if (jobList != null) {
      for (JobModel? j in jobList) {
        if (j!.featured == 0) {
          _unFeaturedJobs.add(j);
        } else {
          _featuredJobs.add(j);
        }
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  void initialise(String url) {
    searchUrl = url;
    _searchQueryController.addListener(_onSearchChanged);
    notifyListeners();
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();

    super.dispose();
  }

  // ignore: missing_return
  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: debouncetime), () async {
      if (_searchQueryController.text != "") {
        _isSearch = true;
        _isLoading = true;
        notifyListeners();
        _searchResult =
            await GenericService.search(searchUrl, _searchQueryController.text);
        List<JobModel?>? jobList;

        if (_searchResult!.isNotEmpty) {
          jobList = _searchResult!.map((job) => JobModel.fromMap(job)).toList();
        }

        _searchUnFeaturedJobs = [];
        _searchFeaturedJobs = [];
        if (jobList != null) {
          for (JobModel? j in jobList) {
            if (j!.featured == 0) {
              _searchUnFeaturedJobs.add(j);
            } else {
              _searchFeaturedJobs.add(j);
            }
          }
        }
        _isLoading = false;
      } else {
        _isSearch = false;
      }
      notifyListeners();
    });
  }

  //FILTER
  void isFiltered(bool filter) {
    _isFilter = filter;
    notifyListeners();
  }

  Future getJobTypes(String? type) async {
    String? jobTypeUrl, categoryUrl;
    if (type == null) {
      jobTypeUrl = AppConstants.jobTypes;
      categoryUrl = AppConstants.jobCategories;
    } else if (type == 'resume') {
      categoryUrl = AppConstants.resumeCategories;
    } else if (type == 'company') {
      categoryUrl = AppConstants.companyCategories;
    }
    if (type == null) {
      List data = await jobService.texonomy(jobTypeUrl);
      if (data.isEmpty) {
        _jobTypes = [];
      } else {
        _jobTypes = data.map((type) => TaxonomyModel.fromMap(type)).toList();
        _jobTypes!.insert(0, TaxonomyModel(id: 0, name: 'Select Job Type'));
      }
    }
    getJobCategories(categoryUrl!);
  }

  Future getJobCategories(String categoryUrl) async {
    List data = await jobService.texonomy(categoryUrl);
    debugPrint('CATEGORY');
    debugPrint('$data');
    if (data.isEmpty) {
      _categories = [];
    } else {
      _categories =
          data.map((category) => TaxonomyModel.fromMap(category)).toList();
      _categories!.insert(0, TaxonomyModel(id: 0, name: 'Select Category'));
    }
    notifyListeners();
  }

  selectDropDownValue(int id, String type) {
    if (type == 'job') {
      _jobID = id;
    } else {
      _catID = id;
    }
    notifyListeners();
  }

  setIDS(int id, String type) {
    if (type == 'job') {
      _jobID = id;
    } else {
      _catID = id;
    }
    notifyListeners();
  }

  Future filterSearchQuery(String? type) async {
    _isLoading = true;
    notifyListeners();
    String query =
        '${_filterSearch.text}${_catID == 0 ? '' : '&${type ?? 'job'}-categories=$_catID'}${_filterLocation.text == '' ? '' : '&location=${_filterLocation.text}'}';

    if (type == null) {
      // ignore: unnecessary_string_interpolations
      query = '$query${_jobID == 0 ? '' : '&job-types=$_jobID'}';
    }
    data = await GenericService.search(searchUrl, query);
    List<JobModel?>? jobList;
    _featuredJobs = [];
    _unFeaturedJobs = [];

    if (data!.isNotEmpty) {
      jobList = data!.map((job) => JobModel.fromMap(job)).toList();
    }
    if (jobList != null) {
      for (JobModel? j in jobList) {
        if (j!.featured == 0) {
          _unFeaturedJobs.add(j);
        } else {
          _featuredJobs.add(j);
        }
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  setFilterPressed(bool isFilter) {
    _isFilterPressed = isFilter;
    notifyListeners();
  }

  String getFilterQueryUrl(String type) {
    String query;
    if (type == 'resume') {
      query =
          '${AppConstants.searchResumes}${_filterSearch.text}${_catID == 0 ? '' : '&resume-categories=$_catID'}${_filterLocation.text == '' ? '' : '&location=${_filterLocation.text}'}';
    } else if (type == 'company') {
      query =
          '${AppConstants.searchCompanies}${_filterSearch.text}${_catID == 0 ? '' : '&company-categories=$_catID'}${_filterLocation.text == '' ? '' : '&location=${_filterLocation.text}'}';
    } else {
      query =
          '${AppConstants.searchJobs}${_filterSearch.text}${_catID == 0 ? '' : '&job-categories=$_catID'}${_jobID == 0 ? '' : '&job-types=$_jobID'}${_filterLocation.text == '' ? '' : '&location=${_filterLocation.text}'}';
    }
    return query;
  }

//REFRESH & PAGINATION
  onLoading(String url, String? type) async {
    page++;
    if (_isFilterPressed) {
      url = getFilterQueryUrl(type!);
    }
    List<JobModel> featuredPag = [], unfeaturedPag = [];
    List data = await jobService.jobs(page, url);
    List<JobModel?>? jobList =
        data.map((job) => JobModel.fromMap(job)).toList();
    // ignore: unnecessary_null_comparison
    if (jobList != null) {
      for (JobModel? j in jobList) {
        if (j!.featured == 0) {
          unfeaturedPag.add(j);
        } else {
          featuredPag.add(j);
        }
      }
    }

    _featuredJobs.addAll(featuredPag);
    _unFeaturedJobs.addAll(unfeaturedPag);
    _refreshController.loadComplete();
    notifyListeners();
  }

  onRefresh(String url, String? type) async {
    _searchQueryController.clear();
    _isFilterPressed = false;
    resetFilters(type);
    _featuredJobs = [];
    _unFeaturedJobs = [];
    job(url: url);
    _refreshController.refreshCompleted();
    page = 0;
    notifyListeners();
  }

  resetFilters(String? type) {
    _filterSearch.clear();
    _filterLocation.clear();
    if (type == null) {
      if (_jobTypes!.isNotEmpty) {
        _jobID = _jobTypes!.first.id;
      }
    }
    if (_categories != null && _categories!.isNotEmpty) {
      _catID = _categories!.first.id;
    }
    notifyListeners();
  }
}
