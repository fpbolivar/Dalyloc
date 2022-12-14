import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/searchPlaceModel.dart';
import 'package:daly_doc/widgets/segmentControl/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

class LocationTFViewTask extends StatelessWidget {
  LocationTFViewTask({super.key, this.data});
  String howOften = "";
  SearchPlacesModel? data;
  Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColor.textBlackColor),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 44,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.blueColor
                      //                   <--- border width here
                      ),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.blueColor),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Text(
                        (data!.address == "")
                            ? "Select"
                            : data!.address.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 15, color: AppColor.theme),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.gps_fixed,
                    color: AppColor.segmentBarSelectedColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
