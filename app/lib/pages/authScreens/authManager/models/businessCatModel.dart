import '../../../../utils/exportPackages.dart';

class BusinessCatModel {
  String? id;
  String? name;
  String? image;

  BusinessCatModel({
    this.image,
    this.id,
    this.name,
  });

  factory BusinessCatModel.fromJson(Map<String, dynamic> json) {
    return BusinessCatModel(
      image: json['image'].toString(),
      id: json['id'].toString(),
      name: json['business_category_name'].toString(),
    );
  }
}

class WeekDaysModel {
  String? value;
  String? name;
  String? id;
  String? userid;
  String? status;
  bool? selected;
  PickUpDateTime? startime;
  PickUpDateTime? endtime;
  WeekDaysModel(
      {required this.startime,
      required this.endtime,
      required this.selected,
      this.status,
      required this.name,
      this.id,
      this.userid,
      this.value});

  factory WeekDaysModel.fromJsonServer(Map<String, dynamic> json) {
    return WeekDaysModel(
      name: json['day'].toString(),
      userid: json['user_id'].toString(),
      id: json['id'].toString(),
      endtime: PickUpDateTime(timeStr: json['close_time'].toString()),
      startime: PickUpDateTime(timeStr: json['open_time'].toString()),
      selected: json['isClosed'] == 0
          ? true
          : json['isClosed'] == 1
              ? false
              : false,
    );
  }
  factory WeekDaysModel.fromJson(Map<String, dynamic> json) {
    return WeekDaysModel(
      value: json['value'].toString(),
      name: json['name'].toString(),
      id: json['_id'].toString(),
      status: json['status'].toString(),
      endtime: json['endtime'],
      startime: json['startime'],
      selected: false,
    );
  }
}

class PickUpDateTime {
  var pickupTime = "";
  DateTime pickupDate = DateTime.now();
  var pickupStrDate = "";
  TimeOfDay time = TimeOfDay.now();
  var timeStr = "";
  PickUpDateTime({this.pickupTime = "", this.timeStr = ""});
}
