import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';

import '../../../utils/exportPackages.dart';

import 'itemRowView.dart';

class NotificationSectionRowListView extends StatelessWidget {
  NotificationSectionRowListView(
      {super.key, required this.sectionItem, this.onTap});
  NotificationSectionRowModel sectionItem;
  Function(int, int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${sectionItem.title}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColor.textGrayBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sectionItem.items!.length,
                itemBuilder: (conext, index) {
                  return InkWell(
                    onTap: () {
                      //onTap!(itemList[index].section ?? 0, index);
                    },
                    child: NotificationRowView(
                        itemData: sectionItem.items![index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  // ignore: prefer_const_constructors
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(),
                  );
                },
              ),
            ))
      ],
    );
  }
}
