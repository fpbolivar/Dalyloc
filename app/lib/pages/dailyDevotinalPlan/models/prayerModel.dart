class PrayerModel {
  String? id;
  String? userId;
  String? prayerTitle;
  String? prayerNote;
  String? prayerStatus;

  String? isDeleted;
  List<PrayerResponse>? response;
  PrayerModel(
      {this.userId,
      this.prayerNote,
      this.id,
      this.prayerStatus,
      this.prayerTitle,
      this.isDeleted,
      this.response});

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    List<PrayerResponse>? responseTemp = [];
    var resoponseList = json["prayer_response"] as List;
    if (resoponseList != null) {
      if (resoponseList.length > 0) {
        responseTemp =
            resoponseList.map((e) => PrayerResponse.fromJson(e)).toList();
      }
    }

    return PrayerModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      prayerNote: json['prayer_note'].toString(),
      response: responseTemp,
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

class PrayerResponse {
  String? id;
  String? userId;
  String? user_prayer_id;
  String? user_prayer_response;

  PrayerResponse({
    this.userId,
    this.user_prayer_id,
    this.user_prayer_response,
    this.id,
  });

  factory PrayerResponse.fromJson(Map<String, dynamic> json) {
    return PrayerResponse(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      user_prayer_response: json['user_prayer_response'].toString(),
      user_prayer_id: json['user_prayer_id'].toString(),
    );
  }
}
