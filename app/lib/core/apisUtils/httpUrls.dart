import '../localStore/localStore.dart';

class HttpUrls {
  // ignore: constant_identifier_names
  var headers = {'Content-Type': 'application/json'};
  static const WS_BASEURL =
      "https://codeoptimalsolutions.com/test/daly-doc/public/";
  // ignore: constant_identifier_names
  static const WS_GOOGLELOGIN = "${WS_BASEURL}api/auth/google-login";
  // ignore: constant_identifier_names
  static const WS_FACEBOOKLOGIN = "${WS_BASEURL}api/auth/facebook-login";
  // ignore: constant_identifier_names
  static const WS_USERLOGIN = "${WS_BASEURL}api/auth/user-login";
  // ignore: constant_identifier_names
  static const WS_USERREGISTER = "${WS_BASEURL}api/auth/user-register";
  // ignore: constant_identifier_names
  static const WS_GETUSERDATA = "${WS_BASEURL}api/auth/get-profile";
  // ignore: constant_identifier_names
  static const WS_OTPVERIFICATION =
      "${WS_BASEURL}api/auth/verify-phone-with-otp";
  // ignore: constant_identifier_names
  static const WS_RESENDOTP =
      "${WS_BASEURL}api/auth/resend-authenticate-otp?user_id=";
  static const WS_EDITUSERPROFILE = "${WS_BASEURL}api/auth/edit-profile";
  // ignore: constant_identifier_names
  static const WS_CHANGEPASSWORD = "${WS_BASEURL}api/change-password";
  static Future<Map<String, String>> headerData() async {
    return {
      "Authorization": await LocalStore().getToken(),
      "content-type": 'application/json',
    };
  }

  static var headers2 = {'Content-Type': 'application/json'};
}
