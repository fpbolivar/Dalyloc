class ExerciseSettingModel {
  String? id;
  String? option_name;

  String? option_value;

  ExerciseSettingModel({
    this.option_value,
    this.id,
    this.option_name,
  });

  factory ExerciseSettingModel.fromJson(Map<String, dynamic> json) {
    return ExerciseSettingModel(
      id: json['id'].toString(),
      option_value: json['option_value'] ?? "",
      option_name: json['option_name'] ?? "",
    );
  }
}
