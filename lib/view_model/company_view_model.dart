import 'package:cariera/services/generic_service.dart';
import 'package:stacked/stacked.dart';

import '../models/job_model.dart';

class CompanyViewModel extends BaseViewModel {
  bool isDescription = true, isOverview = false;
  JobModel? _company;
  JobModel? get company => _company;
  bool? _isError;
  bool? get isError => _isError;
  void isCheck(bool description, bool overview) {
    isDescription = description;
    isOverview = overview;
    notifyListeners();
  }

  void getCompany(String id) async {
    Map company = await GenericService.company(id);
    if (company.containsKey('error')) {
      _isError = true;
    } else {
      _isError = false;
      _company = JobModel.fromMap(company as Map<String, dynamic>);
    }
    notifyListeners();
  }
}
