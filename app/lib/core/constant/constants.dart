import 'package:daly_doc/pages/mealPlan/manager/mealcontroller.dart';
import 'package:daly_doc/pages/settingsScreen/controller/settingController.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class Constant {
  static var taskProvider = TaskManager();
  static var mealProvider = MealController();
  static var settingProvider = SettingController();

  static var selectedDateYYYYMMDD = "";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
