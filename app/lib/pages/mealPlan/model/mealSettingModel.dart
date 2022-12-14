class MealSettingModel {
  String? id;
  String? meal_start_time;
  String? meal_end_time;
  int? meal_daily_count;
  String? meal_notify;

  MealSettingModel({
    this.meal_start_time,
    this.meal_end_time,
    this.id,
    this.meal_daily_count,
    this.meal_notify,
  });

  factory MealSettingModel.fromJson(Map<String, dynamic> json) {
    return MealSettingModel(
      id: json['id'].toString(),
      meal_notify:
          json['meal_notify'] == null ? "0" : json['meal_notify'].toString(),
      meal_daily_count: json['meal_daily_count'] ?? 0,
      meal_start_time: json['meal_start_time'] ?? "",
      meal_end_time: json['meal_end_time'] ?? "",
    );
  }
}
