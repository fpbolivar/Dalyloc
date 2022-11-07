import 'dart:ffi';

import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class NotificationRowView extends StatelessWidget {
  RowItemModel itemData;
  NotificationRowView({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${itemData.title}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${itemData.description}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
