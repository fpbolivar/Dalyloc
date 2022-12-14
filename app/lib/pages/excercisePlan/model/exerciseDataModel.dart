import 'package:daly_doc/core/apisUtils/httpUrls.dart';
import 'package:daly_doc/pages/excercisePlan/model/levelWorkOutModel.dart';

import 'workoutDataModel.dart';

class ExerciseReponseModel {
  List<ExerciseDataModel>? exerciseList;
  String? id;
  String? workout_time;
  String? workout_name;
  String? workout_image;
  String? level_id;
  String? total_time;
  LevelWorkoutModel? levelData;

  ExerciseReponseModel({
    this.exerciseList,
    this.id,
    this.workout_time,
    this.workout_name,
    this.workout_image,
    this.level_id,
    this.levelData,
    this.total_time,
  });

  factory ExerciseReponseModel.fromJson(Map<String, dynamic> json) {
    var exercisesobj = json["exercises"];
    var exercises = exercisesobj == null ? [] : exercisesobj as List;
    LevelWorkoutModel? levelDataTemp;

    var levelData = json["workout_level"];
    if (levelData != null) {
      levelDataTemp = LevelWorkoutModel.fromJson(levelData);
    }
    List<ExerciseDataModel>? exerciseListTemp;
    if (exercises.length > 0) {
      exerciseListTemp =
          exercises.map((e) => ExerciseDataModel.fromJson(e)).toList();
    } else {
      exerciseListTemp = [];
    }
    return ExerciseReponseModel(
      exerciseList: exerciseListTemp,
      levelData: levelDataTemp,
      id: json['id'].toString(),
      workout_name: json['workout_name'].toString(),
      workout_time: json['workout_time'].toString(),
      level_id: json['level_id'].toString(),
      workout_image: json['workout_image'].toString() == "null"
          ? ""
          : json['workout_image'].toString(),
    );
  }
}

class ExerciseDataModel {
  String? id;
  String? exercise_name;
  String? exercise_video;
  int? exercise_duration;
  String? exercise_image;
  String? exercise_time;

  ExerciseDataModel({
    this.exercise_name,
    this.exercise_video,
    this.id,
    this.exercise_duration,
    this.exercise_image,
    this.exercise_time,
  });

  factory ExerciseDataModel.fromJson(Map<String, dynamic> json) {
    int duration = int.tryParse(json['exercise_time']) ?? 0;
    return ExerciseDataModel(
      id: json['id'].toString(),
      exercise_duration: duration,
      exercise_name: json['exercise_name'] ?? "",
      exercise_video: HttpUrls.WS_BASEURL + json['exercise_video'].toString(),
      exercise_time: json['exercise_time'] ?? "",
      exercise_image: json['exercise_image'] ?? "",
    );
  }
}
