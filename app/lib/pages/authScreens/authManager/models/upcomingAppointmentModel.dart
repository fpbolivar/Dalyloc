import 'package:daly_doc/widgets/extension/string+capitalize.dart';

enum StatusAppointment { accepted, pending, reject, completed, paid, cancelled }

extension PlanTypeString on String {
  StatusAppointment get statusType {
    switch (this) {
      case 'cancelled':
        return StatusAppointment.cancelled;
      case 'accepted':
        return StatusAppointment.accepted;
      case 'pending':
        return StatusAppointment.pending;
      case 'rejected':
        return StatusAppointment.reject;
      case 'completed':
        return StatusAppointment.completed;
      case 'paid':
        return StatusAppointment.paid;

      default:
        return StatusAppointment.pending;
    }
  }
}

extension Extension on StatusAppointment {
  String get rawValue {
    switch (this) {
      case StatusAppointment.cancelled:
        return 'cancelled';
      case StatusAppointment.paid:
        return 'paid';
      case StatusAppointment.pending:
        return 'pending';
      case StatusAppointment.completed:
        return 'completed';
      case StatusAppointment.reject:
        return 'rejected';
      case StatusAppointment.accepted:
        return 'accepted';
    }
  }
}

class UpcomingAppointmentItemModel {
  bool? isSelected;

  String? id;
  String? title;
  String? description;
  String? price;
  String? dateTime;
  String? status;
  UpcomingAppointmentItemModel({
    this.isSelected,
    this.description,
    this.price,
    this.dateTime,
    this.status,
    this.title,
    this.id,
  });

  factory UpcomingAppointmentItemModel.fromJson(Map<String, dynamic> json) {
    print("======${json}");
    return UpcomingAppointmentItemModel(
      isSelected: false,
      id: json["id"].toString(),
      title: json["title"].toString(),
    );
  }
}
