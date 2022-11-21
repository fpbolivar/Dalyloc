import '../localStore/localStore.dart';

class HttpUrls {
  var headers = {'Content-Type': 'application/json'};
  // ignore: constant_identifier_names
  static const WS_BASEURL =
      "https://codeoptimalsolutions.com/test/daly-doc/public/";
  // ignore: constant_identifier_names
  static const WS_GOOGLELOGIN = "${WS_BASEURL}api/auth/google-login";
  // ignore: constant_identifier_names
  static const WS_FACEBOOKLOGIN = "${WS_BASEURL}api/auth/facebook-login";
  // ignore: constant_identifier_names
  static const WS_CREATEBUSINESS = "${WS_BASEURL}api/create-user-business";
  // ignore: constant_identifier_names
  static const WS_GETALLBUSINESSCATGORY =
      "${WS_BASEURL}api/auth/get-all-business-category";
  // ignore: constant_identifier_names
  static const WS_USERLOGIN = "${WS_BASEURL}api/auth/user-login";
  // ignore: constant_identifier_names
  static const WS_USERLOGOUT = "${WS_BASEURL}api/logout";
  // ignore: constant_identifier_names
  static const WS_USERREGISTER = "${WS_BASEURL}api/auth/user-register";
  // ignore: constant_identifier_names
  static const WS_GETUSERDATA = "${WS_BASEURL}api/auth/get-profile";
  // ignore: constant_identifier_names
  static const WS_CREATETASK = "${WS_BASEURL}api/create-task";
  // ignore: constant_identifier_names
  static const WS_EDITTASK = "${WS_BASEURL}api/update-task?id=";
  // ignore: constant_identifier_names
  static const WS_DELETETASK = "${WS_BASEURL}api/delete-task/";
  // ignore: constant_identifier_names
  static const WS_GETALLTASK = "${WS_BASEURL}api/all-task-by-date?dateString=";
  // ignore: constant_identifier_names
  static const WS_OTPVERIFICATION =
      "${WS_BASEURL}api/auth/verify-phone-with-otp";
  // ignore: constant_identifier_names
  static const WS_OTPVERIFICATIONFORGOT =
      "${WS_BASEURL}api/auth/password/otp/verify";
  // ignore: constant_identifier_names
  static const WS_CREATENEWPASSWORDAFTERFORGOT =
      "${WS_BASEURL}api/auth/password/reset";
  // ignore: constant_identifier_names
  static const WS_RESENDOTP =
      "${WS_BASEURL}api/auth/resend-authenticate-otp?user_id=";
  // ignore: constant_identifier_names
  static const WS_RESENDOTPFORGOT = "${WS_BASEURL}api/auth/password/resendotp";
  // ignore: constant_identifier_names
  static const WS_FORGOTPASSWORD = "${WS_BASEURL}api/auth/password/create";
  // ignore: constant_identifier_names
  static const WS_EDITUSERPROFILE = "${WS_BASEURL}api/auth/edit-profile";
  // ignore: constant_identifier_names
  static const WS_CHANGEPASSWORD = "${WS_BASEURL}api/change-password";
  // ignore: constant_identifier_names
  static const WS_GETALLPLANS = "${WS_BASEURL}api/get-plans";
  // ignore: constant_identifier_names
  static const WS_SUBCRIBEPLANS = "${WS_BASEURL}api/stripe-user-subscription";
  // ignore: constant_identifier_names
  static const WS_CANCELPLANS =
      "${WS_BASEURL}api/stripe-user-cancel-subscription";
  // ignore: constant_identifier_names
  static const WS_GETACTIVEPLANS = "${WS_BASEURL}api/get-user-active-plans";
  static Future<Map<String, String>> headerData() async {
    return {
      "Authorization": await LocalStore().getToken(),
      "content-type": 'application/json',
    };
  }
}
