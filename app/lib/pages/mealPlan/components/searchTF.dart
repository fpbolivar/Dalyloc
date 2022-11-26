import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class SearchTF extends StatelessWidget {
  SearchTF(
      {super.key,
      required this.serachTF,
      required this.onChangedData,
      this.onClear});
  TextEditingController serachTF;
  Function(String) onChangedData;
  Function()? onClear;
  @override
  Widget build(BuildContext context) {
    return searchView();
  }

  searchView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: AppColor.searchBgColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.0,
                  spreadRadius: 0.3),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/icons/ic_search.png",
                  fit: BoxFit.contain,
                  width: 20,
                  height: 20,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 5, top: 19),
                child: TextField(
                  controller: serachTF,
                  style: TextStyle(color: AppColor.textBlackColor),
                  onChanged: (text) {
                    onChangedData(text);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search meal",
                  ),
                  autofocus: false,
                ),
              )),
              if (!serachTF.text.isEmpty)
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      onClear!();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColor.theme,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
