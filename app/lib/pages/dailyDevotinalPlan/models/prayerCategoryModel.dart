class PrayerCategoryModel {
  String? id;
  String? name;

  PrayerCategoryModel({
    this.id,
    this.name,
  });
  factory PrayerCategoryModel.fromJson(Map<String, dynamic> json) {
    return PrayerCategoryModel(
      id: json['id'].toString(),
      name: json['prayer_category_name'].toString(),
    );
  }
}
