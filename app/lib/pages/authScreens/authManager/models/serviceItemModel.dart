class ServiceItemDataModel {
  bool? isSelected;

  String? user_id;
  String? business_id;
  String? service_name;
  String? service_price;
  String? service_time;
  String? service_online_booking;
  String? is_deleted;

  int? id;
  ServiceItemDataModel({
    this.isSelected,
    this.user_id,
    this.business_id,
    this.service_name,
    this.service_price,
    this.service_time,
    this.service_online_booking,
    this.is_deleted,
    this.id,
  });

  factory ServiceItemDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceItemDataModel(
      isSelected: false,
      user_id: json['user_id'].toString(),
      id: json['id'] ?? 0,
      business_id: json['business_id'].toString(),
      service_name: json['service_name'].toString(),
      service_price: json['service_price'].toString(),
      service_time: json['service_time'].toString(),
      service_online_booking: json['service_online_booking'].toString(),
      is_deleted: json['is_deleted'].toString(),
    );
  }
}
