class LevelWorkoutModel {
  String? id;
  String? workout_image;
  String? workout_name;

  String? workout_description;

  LevelWorkoutModel({
    this.workout_name,
    this.workout_description,
    this.id,
    this.workout_image,
  });

  factory LevelWorkoutModel.fromJson(Map<String, dynamic> json) {
    return LevelWorkoutModel(
      id: json['id'].toString(),
      workout_name: json['workout_level_name'] == null
          ? ""
          : json['workout_level_name'].toString(),
      workout_description: json['workout_description'] ?? "",
      workout_image: json['workout_image'] ?? "",
    );
  }
}
