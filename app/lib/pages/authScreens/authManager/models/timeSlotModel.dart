class TimeSlotModel {
  String? id;
  String? name;
  bool? isChecked;
  String? time;

  TimeSlotModel({this.id, this.time, this.isChecked, this.name});

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      time: json['time'].toString(),
      id: json['service_id'].toString(),
      name: json['name'].toString(),
      isChecked: false,
    );
  }
}
