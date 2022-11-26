import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class MealController with ChangeNotifier {
  List<MealCategoryModel> categoryList = [];
  MealApis manager = MealApis();
  getAllUserData() async {
    List<MealCategoryModel>? tempResponse = await manager.getUserReceipeData();
    if (tempResponse == null) {
      categoryList = [];
      notifyListeners();
      return;
    }
    categoryList = tempResponse;
    notifyListeners();
  }

  List<MealItemModel> selectedItem(List<MealItemModel> list, index) {
    list[index].isSelected = !list[index].isSelected!;
    return list;
  }

  List<MealItemModel> getSelectedItem(List<MealItemModel> list) {
    List<MealItemModel> found =
        list.where((element) => element.isSelected!).toList();
    return found;
  }

  List<MealItemModel> getSelectedAllListItem(List<MealCategoryModel> list) {
    List<MealItemModel> found = [];
    list.forEach((element) {
      element.data!.forEach((element) {
        if (element.isSelected!) {
          found.add(element);
        }
      });
    });
    return found;
  }

  List<int> getSelectedItemIDs(List<MealItemModel> list, index) {
    List<int> found = list
        .where((element) => element.isSelected!)
        .toList()
        .map((e) => e.id!)
        .toSet()
        .toList();
    return found;
  }
}
