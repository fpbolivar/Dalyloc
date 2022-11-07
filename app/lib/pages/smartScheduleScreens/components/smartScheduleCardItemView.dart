import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../models/SmartItemModal.dart';

// ignore: must_be_immutable
class SmartScheduleCardItemView extends StatelessWidget {
  SmartScheduleCardItemView({super.key, required this.itemData});
  SmartItemModel itemData;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.theme,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: bodyView(),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          child: Image.asset(
            "assets/icons/${itemData.icon}",
            width: 25,
            height: 25,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${itemData.title}",
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
