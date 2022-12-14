import 'dart:async';
import 'dart:convert';

import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/searchPlaceModel.dart';
import 'package:http/http.dart';

class PlacesSearchManager {
  static List<SearchPlacesModel>? predictions = [];
  static String searchText = '';
  static Timer timer = Timer(Duration(seconds: 0), () {
    print("Yeah, this line is printed immediately");
  });
  static autoCompleteSearch(value, {completionHandler}) {
    cancelTimer();
    print("you given  entered ${value}");
    searchText = value;

    print("you entered ${searchText}");

    timer = Timer(Duration(milliseconds: 1000), () {
      searchPlaces(onSuccess: (result) {
        completionHandler(result);
      });
    });
  }

  static cancelTimer() {
    timer.cancel();
  }

  static searchPlaces({onSuccess}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }

    try {
      //  String token = await LocalStore().getToken();
      var strGoogleApi =
          "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchText&key=" +
              Constant.KeyGoogleMaps;
      Response response;
      cancelTimer();
      print(strGoogleApi);
      response = await get(Uri.parse(strGoogleApi));

      print(response.statusCode);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        var listData = data["results"] as List;
        predictions = [];
        listData.forEach((json) {
          var name = json["name"].toString();
          var formatAddress = json["formatted_address"].toString();
          var lat = json["geometry"]["location"]["lat"].toString();
          var long = json["geometry"]["location"]["lng"].toString();
          if (predictions!.length <= 5) {
            predictions!.add(SearchPlacesModel(
                address: formatAddress, lat: lat, long: long, title: name));
          }
          print("loop $predictions");
        });
        print("predictionshhh $predictions");
        onSuccess(predictions);
      } else {}
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      //    await pr.hide();
      // dismissWaitDialog();
      print(e.toString());
    }
  }

  static Future<String> getPincode({latitude, longitude}) async {
    const _host = 'https://maps.google.com/maps/api/geocode/json';
    var apiKey = Constant.KeyGoogleMaps;
    var pincode = "";
    final uri = Uri.parse('$_host?key=$apiKey&latlng=$latitude,$longitude');
    print(uri);
    Response response = await get(uri);
    final responseJson = json.decode(response.body);
    print(responseJson);
    var results = responseJson['results'] as List;
    if (results.length != 0 && results != null) {
      var addressComponents = results[0]["address_components"] as List;

      if (addressComponents.length != 0 && addressComponents != null) {
        for (int i = 0; i < addressComponents.length; i++) {
          var element = addressComponents[i];
          var types = element["types"] as List;

          if (types.contains("postal_code")) {
            pincode = element["long_name"];
            break;
          }
        }
      }
    }
    print("PPIINN$pincode");
    return pincode;
  }
}
