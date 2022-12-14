import 'dart:ui';

import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/appBar/CustomAppBar.dart';

import '../care_country_picker.dart';

class CountryPicker extends StatefulWidget {
  Function(Country)? onSelection;
  String countryCode;
  CountryPicker({this.onSelection, this.countryCode = ""});
  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  var listCat = [
    {
      "title": "23, Prabhat Centre, Sector 1a, Belapur (cbd)",
      "pincode": "Zip code  400614"
    },
    {"title": "59, 59,jmrdblr-2, J M Road", "pincode": "Zip code  560002"},
  ];

  // List<Category> dataService = [];
  var serachTF = TextEditingController();
  // var provider = SocietyProvider();
  bool seeAllSoceity = false;
  bool seeAllCommunity = false;
  int lenghtSociety = 20;
  int lenghtCommunity = 20;
  int selectedIndex = 0;
  Country? country;
  List<Country> countryData = [];
  List<Country> copiedcountryData = [];
  @override
  void initState() {
    // TODO: implement initState
    countryData = countryCodes
        .map((countryData) => Country.fromJson(countryData))
        .toList();
    copiedcountryData.addAll(countryData);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add Your Code here.

      setState(() {});

      if (widget.countryCode != null) {
        for (int i = 0; i < countryData.length; i++) {
          if (countryData[i].code.toLowerCase() ==
              widget.countryCode.toLowerCase()) {
            // countryData[i].selected = true;
            country = countryData[i];
            //selectedIndex = i;
            break;
          }
        }
        copiedcountryData.clear();
        copiedcountryData.addAll(countryData);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.newBgcolor,
        appBar: CustomAppBarPresentCloseButton(
            title: "Country Code",
            subtitle: "",
            needHomeIcon: false,
            subtitleColor: AppColor.textGrayBlue),
        body: bodyView());

    // AppScaffold(
    //   title: 'List Example',
    //   slivers: [historyList()],
    // );
  }

  bodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          searchViewSection(),
          Expanded(
            child: searchAddress(),
          )
        ],
      ),
    );
  }

  searchViewSection() {
    return Column(
      children: [
        searchView(),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  searchView() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // ignore: unnecessary_new
            new BoxShadow(
                color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.3),
          ],
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: serachTF,
                  style: TextStyle(color: AppColor.theme),
                  onChanged: (text) => {searchCountryCode()},
                  textCapitalization: TextCapitalization.words,
                  onTap: () {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",

                    // hintStyle: new TextStyle(

                    //     fontWeight: FontWeight.w400)
                  ),
                  autofocus: false,
                ),
              )

              //  Text(
              //   'I am looking for...',
              //   style: TextStyle(
              //       color: AppColor.blueTextColor,
              //       fontSize: 14,
              //       fontFamily: AppFont.roboto),
              // )
              ),

          //SizedBox(width: 30),

          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: Icon(
          //     Icons.location_on,
          //     color: AppColor.themeColor,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget buildViewCountryCell(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      color: country == null
          ? Colors.transparent
          : country?.code == countryData[index].code
              ? Colors.grey[300]
              : Colors.transparent,
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                countryData[index].name.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )),
          Text(
            countryData[index].dialCode.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchAddress() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              // countryData[index].selected = true;
              country = countryData[index];
              // await LocalStore().setCountryCode(country.code.toLowerCase());
              setState(() {});
              widget.onSelection!(country!);

              Navigator.pop(context);
              //selectedIndex = i;
            },
            child: buildViewCountryCell(index),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: countryData.length);
  }

  searchCountryCode() {
    if (serachTF.text == '') {
      this.countryData.clear();
      this.countryData.addAll(copiedcountryData);
      return;
    }

    this.countryData = this
        .copiedcountryData
        .where((element) =>
            element.name
                .toString()
                .toLowerCase()
                .contains(serachTF.text.toString().toLowerCase()) ||
            element.dialCode
                .toString()
                .toLowerCase()
                .contains(serachTF.text.toString().toLowerCase()) ||
            element.code
                .toString()
                .toLowerCase()
                .contains(serachTF.text.toString().toLowerCase()))
        .toList();
    setState(() {});
  }
}
