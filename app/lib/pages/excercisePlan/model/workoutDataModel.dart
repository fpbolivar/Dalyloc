import 'package:daly_doc/pages/excercisePlan/model/levelWorkOutModel.dart';

class WorkoutReponseModel {
  List<WorkoutDataModel>? explore;
  LevelWorkoutModel? levelData;
  List<WorkoutPendindDataModel>? pending;
  WorkoutReponseModel({
    this.explore,
    this.levelData,
    this.pending,
  });

  factory WorkoutReponseModel.fromJson(Map<String, dynamic> json) {
    List<WorkoutDataModel>? exploreTemp;
    LevelWorkoutModel? levelDataTemp;
    List<WorkoutPendindDataModel>? pendingTemp;
    var levelObj = json["workout_level_detail"];
    if (levelObj != null) {
      levelDataTemp = LevelWorkoutModel.fromJson(levelObj);
    }
    var exploreObj = json["explore"] as List;
    if (exploreObj.length > 0) {
      exploreTemp =
          exploreObj.map((e) => WorkoutDataModel.fromJson(e)).toList();
    } else {
      exploreTemp = [];
    }
    var pendingObj = json["pending"] as List;
    if (pendingObj.length > 0) {
      pendingTemp =
          pendingObj.map((e) => WorkoutPendindDataModel.fromJson(e)).toList();
    } else {
      pendingTemp = [];
    }

    return WorkoutReponseModel(
        explore: exploreTemp, pending: pendingTemp, levelData: levelDataTemp);
  }
}

class WorkoutPendindDataModel {
  String? id;
  String? workout_id;
  String? user_id;
  String? workout_status;
  String? task_name;
  List<WorkoutDataModel>? user_workout;

  WorkoutPendindDataModel({
    this.user_workout,
    this.workout_status,
    this.workout_id,
    this.task_name,
    this.id,
    this.user_id,
  });

  factory WorkoutPendindDataModel.fromJson(Map<String, dynamic> json) {
    List<WorkoutDataModel>? user_workoutTemp = [];

    var pendingObj = json["user_workout"] as List;
    if (pendingObj.length > 0) {
      user_workoutTemp =
          pendingObj.map((e) => WorkoutDataModel.fromJson(e)).toList();
    } else {
      user_workoutTemp = [];
    }
    return WorkoutPendindDataModel(
      id: json['id'].toString(),
      workout_id:
          json['workout_id'] == null ? "" : json['workout_id'].toString(),
      user_id: json['user_id'].toString(),
      workout_status: json['workout_status'].toString(),
      task_name: json['task_name'].toString(),
      user_workout: user_workoutTemp,
    );
  }
}

class WorkoutDataModel {
  String? id;
  String? workout_time;
  String? workout_name;
  String? workout_image;
  String? level_id;

  WorkoutDataModel({
    this.workout_name,
    this.workout_image,
    this.workout_time,
    this.id,
    this.level_id,
  });

  factory WorkoutDataModel.fromJson(Map<String, dynamic> json) {
    return WorkoutDataModel(
      id: json['id'].toString(),
      workout_name:
          json['workout_name'] == null ? "" : json['workout_name'].toString(),
      workout_time: json['workout_time'] ?? "",
      workout_image: json['workout_image'] ?? "",
      level_id: json['level_id'].toString(),
    );
  }
}
