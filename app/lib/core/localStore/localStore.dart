import '../../utils/exportPackages.dart';
import 'package:client_information/client_information.dart';

class LocalStore {
  final String _token = "_token";
  final String _otp = "123456";
  final String _nameofuser = "_nameofuser";
  final String _MobileNumberOfUser = "_MobileNumberOfUser";
  final String _user_id = "1";
  final String _fcmToken = "_fcmToken";
  final String _lat = "_lat";

  final String _address = "_address";

  final String countryCode = "_countryCode";
  final String _long = "_long";
  final String _userlat = "_userlat";
  final String _useraddress = "_useraddress";
  final String _userlong = "_userlong";

  final String _userCountry = "_userCountry";
  final String _userCity = "_userCity";
  final String _businessId = "_businessId";
  final String _userState = "_userState";
  final String _businessSlug = "_businessSlug";

  final String _userPincode = "_userPincode";
  final String _age = "_age";
  final String _feet = "_feet";
  final String _inch = "_inch";
  final String _weight = "_weight";
  final String _deletedIDS = "_deletedIDS";
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

  Future<bool> setBusinessSlug(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set _businessSlug");
    print(value);
    return (prefs.setString(_businessSlug, value));
  }

  Future<String> getBusinessSlug() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_businessSlug) ?? '';

    print("GET _businessSlug");
    print(value);
    return value;
  }

  Future<bool> setBusinessId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set _businessSlug");
    print(value);
    return (prefs.setString(_businessId, value));
  }

  Future<String> getBusinessId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_businessId) ?? '';

    print("GET _MobileNumberOfUser");
    print(value);
    return value;
  }

  Future<bool> setUserCountry(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.setString(_userCountry, value));
  }

  Future<bool> setUserCity(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.setString(_userCity, value));
  }

  Future<bool> setaddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_address, value.toString());
  }

  Future<String> getaddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_address) ?? '';
  }

  Future<bool> setCuntrycode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(countryCode, value.toString());
  }

  Future<String> getCuntrycode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(countryCode) ?? '';
  }

  Future<bool> setUserState(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.setString(_userState, value));
  }

  Future<bool> setUserPincode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.setString(_userPincode, value));
  }

  Future<String> getUserCountry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getString(_userCountry) ?? '');
  }

  Future<String> getUserCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getString(_userCity) ?? '');
  }

  Future<String> getUserState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getString(_userState) ?? '');
  }

  Future<String> getUserPincode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getString(_userPincode) ?? '');
  }

  Future<bool> removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(_userlat);
    prefs.remove(_userlong);
    prefs.remove(_useraddress);
    prefs.remove(_userCity);
    prefs.remove(_userCountry);
    prefs.remove(_userPincode);
    prefs.remove(_userState);

    return prefs.remove(_userState);
  }

  Future<bool> setLat(lat, long) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_long, long.toString());
    return prefs.setString(_lat, lat.toString());
  }

  Future<bool> setUserLat(lat, long) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_userlong, long.toString());
    return prefs.setString(_userlat, lat.toString());
  }

  Future<List<String>> getLatLong() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var lat = prefs.getString(_lat) ?? '00';
    var long = prefs.getString(_long) ?? '00';

    return [lat, long];
  }

  Future<List<String>> getUserLatLong() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var lat = prefs.getString(_userlat) ?? '00';
    var long = prefs.getString(_userlong) ?? '00';

    return [lat, long];
  }

  Future<bool> setUseraddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_useraddress, value.toString());
  }

  Future<String> getUseraddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_useraddress) ?? '';
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

  Future<bool> setIDSDeleted(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET setIDSDeleted");
    print(value);
    return (prefs.setString(_deletedIDS, value));
  }

  Future<String> getDeletedIDS() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_deletedIDS) ?? '';
    print("GET getDeletedIDS");
    print(value);
    return value;
  }

  Future<String> getDeviceId() async {
    return (await ClientInformation.fetch()).deviceId;
  }
}
