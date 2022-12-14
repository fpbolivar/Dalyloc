class PrayerSettingModel {
  String? id;
  String? prayer_start_time;
  String? prayer_end_time;
  int? paryer_daily_count;
  String? prayer_notify;

  PrayerSettingModel({
    this.prayer_start_time,
    this.prayer_end_time,
    this.id,
    this.paryer_daily_count,
    this.prayer_notify,
  });

  factory PrayerSettingModel.fromJson(Map<String, dynamic> json) {
    return PrayerSettingModel(
      id: json['id'].toString(),
      prayer_notify: json['prayer_notify'] == null
          ? "0"
          : json['prayer_notify'].toString(),
      paryer_daily_count: json['paryer_daily_count'] ?? 0,
      prayer_end_time: json['prayer_end_time'] ?? "",
      prayer_start_time: json['prayer_start_time'] ?? "",
    );
  }
}
