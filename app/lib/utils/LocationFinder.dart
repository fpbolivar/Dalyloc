import 'dart:convert';

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as MobileLOC;
export 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/localStore/localStore.dart';

GoogleMapsPlaces _places =
    GoogleMapsPlaces(apiKey: "AIzaSyCObYgbuEEpAktTlfJhGs6LS_xjWam5F3k");

class SelectedLocation {
  var lat = "";
  var long = "";
  var address = "";
  var city = "";
  var zipCode = "";
  var state = "";
  var country = "";

  SelectedLocation(
      {this.lat = "",
      this.address = "",
      this.long = "",
      this.city = "",
      this.zipCode = "",
      this.state = "",
      this.country = ""});
}

class LocationDetector {
  var country = "";
  var lat = "";
  var long = "";
  var address = "";
  bool userUpdateYourAddress = false;
  BuildContext? context;
  LocationDetector({this.userUpdateYourAddress = false});
  MobileLOC.Location? location = MobileLOC.Location();
  MobileLOC.LocationData? locationData;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MobileLOC.PermissionStatus? permissionGranted;
  bool? serviceEnabled;
  String? _error;
  SelectedLocation? locData;

  initial() {
    locData = SelectedLocation(
        address: "", country: "", lat: "", long: "", state: "", zipCode: "");
  }

  Future<SelectedLocation?> getLocation() async {
    initial();
    _error = null;
    serviceEnabled = await location!.serviceEnabled();

    print("serviceEnabled" + serviceEnabled.toString());
    if (!serviceEnabled!) {
      serviceEnabled = await location!.requestService();
      print("serviceEnabled2" + serviceEnabled.toString());
      if (!serviceEnabled!) {
        return null;
      }
    }

    permissionGranted = await location!.hasPermission();
    print("permissionGranted" + permissionGranted.toString());
    if (permissionGranted == MobileLOC.PermissionStatus.denied) {
      permissionGranted = await location!.requestPermission();
      print("permissionGranted2" + permissionGranted.toString());
      if (permissionGranted != MobileLOC.PermissionStatus.granted) {
        showDialog(
          context: context!,
          builder: (context) =>
              showAlert("Goto Settings and Enable Location Service."),
        );
        return null;
      }
    }

    try {
      final MobileLOC.LocationData locationResult =
          await location!.getLocation();

      locationData = locationResult;

      print(locationData);
      var data = await findAddress(locationResult);

      return locData;
    } on PlatformException catch (err) {
      _error = err.code;
      print(_error);
    }
  }

  Future<bool?> findAddress(MobileLOC.LocationData value) async {
    try {
      List<Placemark> addresses =
          await placemarkFromCoordinates(value.latitude!, value.longitude!);

      var first = addresses.first;
      country = first.isoCountryCode.toString();
      print("isoCountryCode $country");
      print(
          'userUpdateYourAddress ${first.locality},${first.subLocality}, $first');
      saveCountyCOde(country: "${first.isoCountryCode}");
      print("userUpdateYourAddress $userUpdateYourAddress}");
      if (!userUpdateYourAddress) {
        saveCountyCOde(country: "${first.isoCountryCode}");
        saveAddress(address: "${first.administrativeArea}");
        print("first.country${first.isoCountryCode}");
        country = first.isoCountryCode.toString();

        saveLatLong(lat: value.latitude!, long: value.longitude!);
      }

      print("first.country${first.country} : ${first.subAdministrativeArea}");
      print("${first.locality} : ${first.subLocality}");
      print("${first.postalCode} : ${first.postalCode}");

      locData!.address =
          "${first.street}, ${first.subLocality}, ${first.subAdministrativeArea}, ${first.administrativeArea}";
      locData!.city = "${first.locality}";
      locData!.country = "${first.country}";
      locData!.state = "${first.administrativeArea}";
      locData!.zipCode = "${first.postalCode}";
      locData!.lat = "${value.latitude}";
      locData!.long = "${value.longitude}";
      country = "${first.isoCountryCode}";

      return true;
    } catch (e) {
      print("Error occured: $e");
    } finally {}
  }

  saveLatLong({double? lat, double? long}) async {
    print("saveLatLong ${lat} ${long}");
    userUpdateYourAddress
        ? await LocalStore().setLat(lat!, long!)
        : await LocalStore().setLat(lat!, long!);
  }

  saveAddress({String? address}) async {
    userUpdateYourAddress
        ? await LocalStore().setUseraddress(address!)
        : await LocalStore().setaddress(address!);
  }

  saveCountyCOde({String? country}) async {
    userUpdateYourAddress
        ? await LocalStore().setCuntrycode(country!)
        : await LocalStore().setCuntrycode(country!);
  }

  Future<SelectedLocation?> handlePressButton(
      BuildContext? context, String countryCode) async {
    context = context;
    String code = await LocalStore().getCuntrycode();
    initial();
    // show input autocomplete with selected mode
    // then get the Prediction selected
    print("locData!.country.toString()$code");
    Prediction? p = await PlacesAutocomplete.show(
      context: context!,
      apiKey: "AIzaSyCObYgbuEEpAktTlfJhGs6LS_xjWam5F3k",
      types: [],
      offset: 0,
      radius: 1000,
      strictbounds: false,
      // region: "in",
      onError: onError,
      mode: Mode.overlay,
      components: [Component(Component.country, code)],
    );

    bool? data = await displayPrediction(p!);

    return locData;
  }

  Future<bool?> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);

      lat = detail.result.geometry!.location.lat.toString();
      long = detail.result.geometry!.location.lng.toString();

      address = "${p.description}";

      locData!.address = address;
      locData!.lat = lat;
      locData!.long = long;

      detail.result.addressComponents.forEach((element) {
        element.types.forEach((element1) async {
          if (element1.contains('route')) {}
          if (element1.contains('locality')) {
            var city = element.longName;
            locData!.city = city;
          }
          if (element1.contains('postal_code')) {
            var pincode = element.longName;
            locData!.zipCode = pincode;
          }
          if (element1.contains('country')) {
            var country = element.longName;
            locData!.country = country;
          }
          if (element1.contains('sublocality')) {
            var sublocality = element.longName;
          }
          if (element1.contains('administrative_area_level_1')) {
            var state = element.longName;
            locData!.state = state;
          }
          if (element1.contains('political')) {
            print(element.longName);
          }
        });
      });

      print("------------->");
      if (!userUpdateYourAddress) {
        print("<------------->");
        saveAddress(address: address);
      }
      if (!userUpdateYourAddress) {
        saveAddress(address: address);

        saveLatLong(
            lat: detail.result.geometry!.location.lat,
            long: detail.result.geometry!.location.lng);
      }
      return true;
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    print("Error${response.errorMessage}");

    // showDialog(
    //   context: context!,
    //   builder: (context) => textDialog(
    //     text: "Error${response.errorMessage}",
    //     size: 13,
    //     color: Colors.green,
    //     align: TextAlign.center,
    //   ),
    // );
  }

  _getGooglecoo(MobileLOC.LocationData value) async {
    const _host = 'https://maps.google.com/maps/api/geocode/json';
    const apiKey = "AIzaSyCObYgbuEEpAktTlfJhGs6LS_xjWam5F3k";
    var latitude = value.latitude.toString();
    var longitude = value.longitude.toString();

    final uri = Uri.parse('$_host?key=$apiKey&latlng=$latitude,$longitude');
    print(uri);
    Response response = await get(uri);
    final responseJson = json.decode(response.body);
    print(responseJson);
  }
}
