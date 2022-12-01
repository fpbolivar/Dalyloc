class PrayerModel {
  String? id;
  String? userId;
  String? prayerTitle;
  String? prayerNote;
  String? prayerStatus;

  String? isDeleted;

  PrayerModel({
    this.userId,
    this.prayerNote,
    this.id,
    this.prayerStatus,
    this.prayerTitle,
    this.isDeleted,
  });

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      prayerNote: json['prayer_note'].toString(),
      prayerStatus: json['prayer_status'].toString(),
      prayerTitle: json['prayer_title'].toString(),
      isDeleted: json['is_deleted'].toString(),
    );
  }
}

class AdminPrayerModel {
  String? id;
  String? writtenby;
  String? prayerDescription;

  String? isDeleted;

  AdminPrayerModel({
    this.writtenby,
    this.id,
    this.prayerDescription,
    this.isDeleted,
  });

  factory AdminPrayerModel.fromJson(Map<String, dynamic> json) {
    return AdminPrayerModel(
      id: json['id'].toString(),
      prayerDescription: json['prayer_description'].toString(),
      writtenby: json['written_by'].toString(),
      isDeleted: json['is_deleted'].toString(),
    );
  }
}
