import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class Constant {
  static var taskProvider = TaskManager();
  static var selectedDateYYYYMMDD = "";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
