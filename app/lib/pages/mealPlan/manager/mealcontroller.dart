import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class MealController with ChangeNotifier {
  List<MealCategoryModel> categoryList = [];
  List<MealCategoryModel> categoryCookList = [];
  bool? showOrderItem = false;
  List<MealItemModel> selecteOrderItems = [];
  MealItemModel? singleMealItem = null;
  MealApis manager = MealApis();
  showHideOrderItem() async {
    showOrderItem = true;
    notifyListeners();
  }

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
    MealItemModel modifiedItem = list[index];
    if (list[index].isSelected == true) {
      List<MealItemModel> founded = selecteOrderItems
          .where((element) => element.id == list[index].id)
          .toList();
      if (founded.length == 0) {
        selecteOrderItems.add(list[index]);
      }
    } else {
      selecteOrderItems.removeWhere((element) => element.id == list[index].id);
    }

    categoryCookList.forEach((cat) {
      cat.data!.forEach((element) {
        if (modifiedItem.id == element.id) {
          element.isSelected = modifiedItem.isSelected;
        }
      });
    });
    notifyListeners();
    return list;
  }

  List<MealItemModel>? preSelectedItem(List<MealItemModel> list, index) {
    List<MealItemModel> listData = [];
    listData.addAll(list);
    for (int i = 0; i < listData.length; i++) {
      MealItemModel item = listData[i];
      List<MealItemModel> found =
          selecteOrderItems.where((element) => element.id == item.id).toList();
      if (found.length > 0) {
        listData[i].isSelected = true;
      }
      notifyListeners();
    }
    return listData;
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
