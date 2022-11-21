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
      required this.value});

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
