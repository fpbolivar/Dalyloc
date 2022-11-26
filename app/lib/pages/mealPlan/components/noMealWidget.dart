import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class NoMealWidget extends StatelessWidget {
  NoMealWidget({required this.refresh});
  Function() refresh;
  Widget bodyDesign(context) {
    return Center(
      child: Container(
        // height: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 30,
              // ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Image.asset(
                    'assets/icons/meal.png',
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Text(
                "No Meal available.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.textGrayBlue),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButton.regular(
                title: "Tap to Refresh",
                width: 120,
                height: 23,
                fontSize: 13,
                radius: 2,
                background: AppColor.segmentBarSelectedColor,
                onTap: () {
                  refresh();
                },
              ),
              SizedBox(
                height: 30,
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyDesign(context);
  }
}
