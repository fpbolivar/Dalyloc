import 'package:daly_doc/widgets/CountryPicker/care_country_picker.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryModels/country.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryPicker.dart';

import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class CountryPickerTF extends StatelessWidget {
  // double width = 100;
  double height = 50;
  var controllr = TextEditingController();
  String placeholder = "";
  String defaultDialCode = "";
  // int maxLength;
  //Color background;
  // Color titleColor;
  bool obscureText;
  bool isBorderEnable;
  bool enabled;
  bool password;
  int maxlines;
  TextInputType keyBoardType;
  String? defaultCountryName;
  Function(String)? onChange;

  CountryPickerTF(
      {this.password = false,
      this.maxlines = 1,
      this.defaultCountryName = "",
      //this.width = double.infinity,
      required this.controllr,
      this.isBorderEnable = true,
      this.keyBoardType = TextInputType.text,
      this.height = 50,
      this.placeholder = "",

      // this.background,
      // this.titleColor,
      this.obscureText = false,
      this.enabled = true,
      this.onChange});

  Country? country;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          border: isBorderEnable
              ? Border.all(width: 1, color: AppColor.textBlackColor
                  //                   <--- border width here
                  )
              : null,
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                child: Text(
              defaultCountryName ?? "",
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
