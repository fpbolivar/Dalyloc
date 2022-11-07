import 'package:connectivity/connectivity.dart';

Future<bool> internetCheck() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
    // I am connected to a wifi network.
  } else {
    return false;
  }
}
