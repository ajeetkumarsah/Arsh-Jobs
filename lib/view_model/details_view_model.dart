
import 'package:cariera/services/generic_service.dart';
import 'package:stacked/stacked.dart';

class DetailsViewModel extends BaseViewModel {
  bool isDescription = true, isOverview = false;

  void isCheck(bool description, bool overview) {
    isDescription = description;
    isOverview = overview;
    notifyListeners();
  }

  imageBytes(String url) async {
    return await GenericService.getImageBytes(url);
  }
}
