import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class PopMenuView extends StatelessWidget {
  PopMenuView({super.key, this.onSelection, this.list});
  List<String>? list = [];
  Function(String)? onSelection;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        onSelection!(value);
      },
      child: Container(alignment: Alignment.centerRight, child: Container()),
      offset: const Offset(200, 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (ctx) {
        return list!
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: Text(e),
              ),
            )
            .toList();
      },
    );
  }
}
