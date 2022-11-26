import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/receipeDetailModel.dart';
import 'package:daly_doc/widgets/dashedLine/dashedView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ReceipeBasicDetailView extends StatefulWidget {
  ReceipeDetailModel? data;
  ReceipeBasicDetailView({super.key, this.data});

  @override
  State<ReceipeBasicDetailView> createState() => _ReceipeBasicDetailViewState();
}

class _ReceipeBasicDetailViewState extends State<ReceipeBasicDetailView> {
  final GlobalKey _childKey = GlobalKey();

  bool isHeightCalculated = false;

  double height = 0;
  ReceipeDetailModel? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return bodyView();
  }

  bodyView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
              alignment: Alignment.center,
              color: Colors.orange[100 * (index % 9)],
              child: dataView());
        },
        childCount: 1,
      ),
    );

    // SliverAppBar(
    //   // this is where I would like to set some minimum constraint
    //   expandedHeight: height,
    //   floating: false,
    //   pinned: false,
    //   backgroundColor: Colors.white,

    //   flexibleSpace: FlexibleSpaceBar(
    //       // ignore: sort_child_properties_last
    //       background: dataView()),
    // );
  }

  Widget dataView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   height: 40,
          // ),
          // Container(
          //   height: 60,
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${data!.meal_name}",
            textAlign: TextAlign.left,
            maxLines: 3,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: AppColor.textGrayBlue),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: optionView(
                        iconName: "clock",
                        title: "${data!.meal_cooking_timing}")),
                Expanded(
                    child: optionView(
                        iconName: "fire", title: "${data!.meal_calories}")),
                Expanded(
                    child: optionView(iconName: "ic_user", title: "1 serve"))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          separatorDashed(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Description",
            textAlign: TextAlign.left,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColor.halfGrayTextColor),
          ),
          SizedBox(
            height: 10,
          ),
          data!.description.toString() != "null"
              ? Text(
                  "${data!.description.toString()}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColor.textBlackColor),
                )
              : Text(
                  "No Descriptions",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColor.textBlackColor),
                ),
          SizedBox(
            height: 25,
          ),
          separatorDashed(),
          SizedBox(
            height: 5,
          ),
          //Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget separatorDashed() {
    return Column(
      children: [
        DashedLine(
          dashWidth: 5,
          color: AppColor.halfGrayTextColor,
        ),
      ],
    );
  }

  Widget optionView({iconName = "", title = ""}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          child: Image.asset(
            "assets/icons/${iconName}.png",
            width: 25,
            height: 25,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${title}",
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
