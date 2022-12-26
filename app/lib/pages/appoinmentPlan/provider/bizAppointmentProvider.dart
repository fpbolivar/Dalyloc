import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BizAppointmentProvider with ChangeNotifier {
  List<BookedAppointmentModel> bookingList = [];
  bool isLoading = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  getAppointment() async {
    isLoading = true;
    notifyListeners();
    List<BookedAppointmentModel>? dataTemp =
        await AppointmentApi().getBizOwnerAppointmentList();
    isLoading = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    notifyListeners();
    if (dataTemp != null) {
      bookingList = dataTemp;
    }
    notifyListeners();
  }
}
