import '../../utils/exportPackages.dart';
import 'package:client_information/client_information.dart';

class LocalStore {
  final String _token = "_token";
  final String _otp = "123456";
  final String _nameofuser = "_nameofuser";
  final String _MobileNumberOfUser = "_MobileNumberOfUser";
  final String _user_id = "1";
  final String _fcmToken = "_fcmToken";

  final String _age = "_age";
  final String _feet = "_feet";
  final String _inch = "_inch";
  final String _weight = "_weight";
  Future<bool> set_MobileNumberOfUser(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_MobileNumberOfUser");
    print(value);
    return (prefs.setString(_MobileNumberOfUser, value));
  }

  Future<String> get_MobileNumberOfUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_MobileNumberOfUser) ?? '';

    print("GET _MobileNumberOfUser");
    print(value);
    return value;
  }

  Future<bool> set_nameofuser(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_nameofuser");
    print(value);
    return (prefs.setString(_nameofuser, value));
  }

  Future<String> get_nameofuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_nameofuser) ?? '';

    print("GET _nameofuser");
    print(value);
    return value;
  }

  Future<bool> setWeightOfUser(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_weight");
    print(value);
    return (prefs.setString(_weight, value));
  }

  Future<String> getWeightOfUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_weight) ?? '';

    print("GET _weight");
    print(value);
    return value;
  }

  Future<bool> setfeet(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_feet");
    print(value);
    return (prefs.setString(_feet, value));
  }

  Future<String> getfeet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_feet) ?? '';

    print("GET _feet");
    print(value);
    return value;
  }

  Future<bool> setInch(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_inch");
    print(value);
    return (prefs.setString(_inch, value));
  }

  Future<String> getInch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_inch) ?? '';

    print("GET _inch");
    print(value);
    return value;
  }

  Future<bool> setAge(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set_age");
    print(value);
    return (prefs.setString(_age, value));
  }

  Future<String> getAge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_age) ?? '';

    print("GET _age");
    print(value);
    return value;
  }

  Future<bool> setFCMToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setFCMToken");
    print(value);
    return (prefs.setString(_fcmToken, value));
  }

  Future<String> getFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_fcmToken) ?? '';

    print("GET getFCMToken");
    print(value);
    return value;
  }

  Future<bool> setotp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setFCMToken");
    print(value);
    return (prefs.setString(_otp, value));
  }

  Future<String> getotp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_otp) ?? '';

    print("GET getFCMToken");
    print(value);
    return value;
  }

  Future<bool> setuid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setFCMToken");
    print(value);
    return (prefs.setString(_user_id, value));
  }

  Future<String> getuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_user_id) ?? '';

    print("GET getFCMToken");
    print(value);
    return value;
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET TOKEN");
    print(value);
    return (prefs.setString(_token, value));
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_token) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<String> getDeviceId() async {
    return (await ClientInformation.fetch()).deviceId;
  }
}
