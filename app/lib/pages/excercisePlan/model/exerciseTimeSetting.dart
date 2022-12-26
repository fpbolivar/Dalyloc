class ExerciseTimeSettingModel {
  String? id;
  String? exercise_start_time;
  String? exercise_end_time;

  String? exercise_notify;

  ExerciseTimeSettingModel({
    this.exercise_start_time,
    this.exercise_end_time,
    this.id,
    this.exercise_notify,
  });

  factory ExerciseTimeSettingModel.fromJson(Map<String, dynamic> json) {
    return ExerciseTimeSettingModel(
      id: json['id'].toString(),
      exercise_notify: json['exercise_notify'] == null
          ? "0"
          : json['exercise_notify'].toString(),
      exercise_start_time: json['exercise_start_time'] ?? "",
      exercise_end_time: json['exercise_end_time'] ?? "",
    );
  }
}
