import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ServiceItemView extends StatelessWidget {
  ServiceItemDataModel itemData;
  int selectedIndex = -1;
  int currentIndex = 0;
  ServiceItemView(
      {super.key,
      required this.itemData,
      required this.selectedIndex,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: selectedIndex == currentIndex
              ? AppColor.segmentBarSelectedColor
              : Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(1, 1)),
          ],
          // border: Border.all(width: 0.5, color: Colors.black26),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
            child: Stack(
              children: [
                bodyView(),
                // Positioned(
                //     right: 0,
                //     top: 0,
                //     child: Container(
                //       width: 80,
                //       height: 80,
                //       child: Image.asset(
                //         "assets/icons/${itemData.image}",
                //         width: 25,
                //         height: 25,
                //       ),
                //     ))
              ],
            )),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "${itemData.service_name}",
              style: TextStyle(
                  fontSize: 14,
                  color: selectedIndex == currentIndex
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(
              "\$ ${itemData.service_price}",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: selectedIndex == currentIndex
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
