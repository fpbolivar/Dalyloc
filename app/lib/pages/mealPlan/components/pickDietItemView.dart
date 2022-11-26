import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class PickDietItemView extends StatelessWidget {
  FoodDietModel itemData;
  bool needImage = true;
  PickDietItemView(
      {super.key,
      required this.itemData,
      this.needImage = true,
      required this.onSelected});
  Function() onSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelected();
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(4, 8),
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ],
          color: Colors.white,
          border: Border.all(
              width: itemData.isSelected ? 2 : 0.5,
              color: itemData.isSelected
                  ? Colors.green
                  : AppColor.halfGrayTextColor.withOpacity(0.5)),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: bodyView(),
                ),
                if (needImage)
                  Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                          width: 45,
                          height: 45,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: ImageLoadFromURL(
                            fit: BoxFit.cover,
                            imgURL: itemData.image,
                          ))),
                // if (itemData.isSelected)
                //   Positioned(
                //       right: 0,
                //       bottom: 0,
                //       child: Icon(
                //         Icons.check_circle,
                //         color: Colors.green,
                //         size: 15,
                //       ))
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
        Text(
          "${itemData.title}",
          style: const TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 5,
        ),
        Text(
          "${itemData.description}",
          // ignore: prefer_const_constructors
          style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
              fontSize: 11),
        ),
        // if (itemData.image != "")
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
