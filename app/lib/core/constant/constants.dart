import 'package:daly_doc/pages/excercisePlan/manager/provider/videoProvider.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealcontroller.dart';
import 'package:daly_doc/pages/settingsScreen/controller/settingController.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class Constant {
  static var taskProvider = TaskManager();
  static var mealProvider = MealController();
  static var settingProvider = SettingController();
  static var videoProvider = VideoProvider();
  static var KeyGoogleMaps = "AIzaSyCHbr4Y4V0UwjtTPY6r8pN4kdNrIexxNvk";
  static var selectedDateYYYYMMDD = "";
  static var HRS24FORMAT = true;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
