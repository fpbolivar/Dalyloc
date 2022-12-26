import 'package:daly_doc/widgets/CountryPicker/care_country_picker.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryModels/country.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryPicker.dart';

import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class PhoneTF extends StatefulWidget {
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
  Function(String)? onChange;
  Function(String)? onCountryCodeChange;
  PhoneTF(
      {this.password = false,
      this.maxlines = 1,
      this.defaultDialCode = "",
      //this.width = double.infinity,
      required this.controllr,
      this.isBorderEnable = true,
      this.onCountryCodeChange,
      this.keyBoardType = TextInputType.text,
      this.height = 50,
      this.placeholder = "",

      // this.background,
      // this.titleColor,
      this.obscureText = false,
      this.enabled = true,
      this.onChange});

  @override
  State<PhoneTF> createState() => _PhoneTFState();
}

class _PhoneTFState extends State<PhoneTF> {
  Country? country;
  List<Country> countryData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryData = countryCodes
        .map((countryData) => Country.fromJson(countryData))
        .toList();
    List<Country> temp = [];

    if (widget.defaultDialCode == "") {
      temp = countryData.where((element) => element.code == "us").toList();
    } else {
      temp = countryData
          .where((element) => element.dialCode == widget.defaultDialCode)
          .toList();
    }
    if (temp.isEmpty) {
      temp = countryData.where((element) => element.code == "us").toList();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (temp.length > 0) {
        country = temp.first;
        widget.onCountryCodeChange!(country!.dialCode);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
          border: widget.isBorderEnable
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
            InkWell(
              onTap: () {
                Routes.presentSimple(
                    context: context,
                    child: CountryPicker(
                      countryCode: country!.code,
                      onSelection: (data) {
                        country = data;
                        widget.onCountryCodeChange!(country!.dialCode);
                        setState(() {});
                      },
                    ));
              },
              child: Container(
                child: country == null
                    ? Text(
                        "+1",
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        country!.dialCode,
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                maxLines: widget.maxlines,
                controller: widget.controllr,
                style: TextStyle(fontSize: 16),
                onChanged: (text) => {widget.onChange!(text)},
                keyboardType: widget.keyBoardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  suffixIcon: widget.password == true
                      ? IconButton(
                          onPressed: () {
                            //add Icon button at end of TextField
                            setState(() {
                              //refresh UI
                              if (widget.obscureText) {
                                //if passenable == true, make it false
                                widget.obscureText = false;
                              } else {
                                widget.obscureText =
                                    true; //if passenable == false, make it true
                              }
                            });
                          },
                          icon: Icon(
                            widget.obscureText == true
                                ? Icons.remove_red_eye
                                : Icons.password,
                            // color: Colors.black,
                          ),
                        )
                      : null,
                ),
                autofocus: false,
                enabled: widget.enabled,
                obscureText: widget.obscureText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
