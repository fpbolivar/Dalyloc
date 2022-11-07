import '../../../utils/exportPackages.dart';
import '../model/SettingOption.dart';

class SettingItemView extends StatelessWidget {
  SettingItemView({super.key, this.itemData});
  SettingOption? itemData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        children: [
          Text(
            "${itemData?.title}",
            style: TextStyle(
                color: itemData!.type! == SettingType.logout
                    ? Colors.red
                    : Colors.black,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          if (itemData!.type! != SettingType.logout)
            Image.asset(
              'assets/icons/ic_arrow.png',
              fit: BoxFit.contain,
              height: 20,
              width: 20,
            ),
        ],
      ),
    );
  }
}
