// ignore: file_names
import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import '../../utils/exportPackages.dart';
import 'package:intl/intl.dart';

class SyncingView extends StatelessWidget {
  SyncingView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: AppColor.theme,
      width: MediaQuery.of(context).size.width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Syncing...",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
