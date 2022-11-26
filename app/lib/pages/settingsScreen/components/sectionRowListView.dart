import 'package:daly_doc/pages/settingsScreen/components/itemSettingView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';

import '../../../utils/exportPackages.dart';

class SectionRowListView extends StatelessWidget {
  SectionRowListView(
      {super.key,
      required this.itemList,
      this.onTap,
      this.counter,
      this.onSelectionBool,
      this.borderEnable = false});
  int? counter = 1;
  List<SettingOption> itemList;
  Function(int, int)? onTap;
  Function(bool, int, int)? onSelectionBool;
  bool borderEnable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: !borderEnable
              ? null
              : Border.all(
                  width: 1,
                  color:
                      itemList.first.value == true ? Colors.green : Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (conext, index) {
            return InkWell(
              onTap: () {
                onTap!(itemList[index].section ?? 0, index);
              },
              child: SettingItemView(
                  itemData: itemList[index],
                  onSelectionBool: (value) {
                    onSelectionBool!(
                        value, itemList[index].section ?? 0, index);
                  }),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            // ignore: prefer_const_constructors
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(),
            );
          },
        ));
  }
}
