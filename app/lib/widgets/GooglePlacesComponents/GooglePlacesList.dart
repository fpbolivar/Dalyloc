import 'package:daly_doc/utils/LocationFinder.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/PlacesSearchManager.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/searchPlaceModel.dart';
import 'package:daly_doc/widgets/ShadowOnView.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:permission_handler/permission_handler.dart';

class GooglePlaceListView extends StatefulWidget {
  //List<SearchPlacesModel>? predictions = [];
  Function(SearchPlacesModel)? onSelection;
  GooglePlaceListView({Key? key, this.onSelection}) : super(key: key);

  @override
  State<GooglePlaceListView> createState() => _GooglePlaceListViewState();
}

class _GooglePlaceListViewState extends State<GooglePlaceListView> {
  List<SearchPlacesModel>? predictions = [];
  bool loaderStart = false;
  TextEditingController searchTF = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Search Location",
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ShadowOnView(
                elevation: 6,
                height: 50,
                child: searchTextView(),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  getCurrentLocation();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.gps_fixed),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Use current location",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions?.length,
                  itemBuilder: (context, index) {
                    return placeCell(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget placeCell(int index) {
    return InkWell(
      onTap: () {
        if (widget.onSelection == null) {
          return;
        }
        Navigator.of(context).pop();
        widget.onSelection!(predictions![index]);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(
            //   'assets/images/modPin.png',
            //   height: 25,
            //   width: 25,
            // ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  predictions![index].title.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  predictions![index].address.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  searchTextView() {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Row(children: [
        Expanded(
          child: TextField(
            minLines: 5,
            maxLines: 15,
            autocorrect: false,
            controller: searchTF,
            onChanged: (value) {
              if (value.isNotEmpty) {
                loaderStart = true;
                setState(() {});
                PlacesSearchManager.autoCompleteSearch(value,
                    completionHandler: (predictionsList) {
                  print("predictions $predictionsList");
                  if (predictionsList == null || predictionsList.length == 0) {
                    ToastMessage.showErrorwMessage(
                      msg:
                          "Unable to found address. Please try another address ",
                    );
                    this.predictions = [];
                    loaderStart = false;
                    setState(() {});
                  } else {
                    if (searchTF.text.isEmpty) {
                      loaderStart = false;
                      setState(() {});
                      return;
                    }
                    loaderStart = false;
                    this.predictions = predictionsList;
                  }
                  setState(() {});
                });
              } else {
                loaderStart = false;

                this.predictions = [];
                setState(() {});
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey)),
            autofocus: false,
            keyboardType: TextInputType.text,
          ),
        ),
        loaderStart
            ? SizedBox(
                width: 20,
                height: 20,
                child: loaderList(),
              )
            : Container()
      ]),
    );
  }

  getCurrentLocation({bool currentTapBtn = false}) async {
    var status = await Permission.location.status;
    print("status ${status}");
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    var result = await LocationDetector().getLocation(noPermissionHandler: () {
      //showAlert("Go to setting and enable Location for DalyDoc app.");
    });
    if (result == null) {
      return;
    }
    if (widget.onSelection == null) {
      return;
    }
    Navigator.of(context).pop();
    widget.onSelection!(SearchPlacesModel(
        address: result.address,
        lat: result.lat,
        long: result.long,
        title: result.state));
  }
}

// class ShadowOnView extends StatelessWidget {
//   double width = 100;
//   double height = 100;
//   double fontSize = 17;
//   double elevation = 0;

//   Color? background;
//   Color? titleColor;
//   VoidCallback? onTap;
//   FontWeight fontweight;
//   EdgeInsets? padding;
//   Widget? child;
//   ShadowOnView(
//       {this.width = double.infinity,
//       this.height = 50,
//       this.elevation = 10.0,
//       this.fontSize = 17,
//       this.background,
//       this.titleColor,
//       this.padding,
//       this.onTap,
//       @required this.child,
//       this.fontweight = FontWeight.w400});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: (MediaQuery.of(context).size.width),
//         height: height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         // clipBehavior: Clip.antiAlias,
//         child: Material(
//             elevation: elevation,
//             borderRadius: BorderRadius.circular(10),
//             clipBehavior: Clip.antiAlias,
//             color: background,
//             child: Padding(
//               padding: padding == null
//                   ? EdgeInsets.fromLTRB(10, 0, 10, 0)
//                   : padding!,
//               child: this.child,
//             )));
//   }
// }
