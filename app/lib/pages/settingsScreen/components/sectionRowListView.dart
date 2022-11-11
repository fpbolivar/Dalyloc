import 'package:daly_doc/pages/settingsScreen/components/itemSettingView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';

import '../../../utils/exportPackages.dart';

class SectionRowListView extends StatelessWidget {
  SectionRowListView({super.key, required this.itemList, this.onTap});
  List<SettingOption> itemList;
  Function(int, int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
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
              ),
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
