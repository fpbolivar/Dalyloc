import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';

import 'businessCatModel.dart';

class UserBusinessModel {
  String? id;
  String? userId;
  String? businessName;
  String? businessImg;
  String? businessCategoryId;
  String? businessAddress;
  String? businessEmail;
  String? deposit_percentage;
  String? lat;
  String? slot_interval;
  String? is_acceptance;
  String? lng;
  UserBusinessCategoryModel? userBusinessCategory;
  List<WeekDaysModel>? timing;
  ServiceItemDataModel? serviceDetail;
  UserBusinessModel(
      {this.lat,
      this.businessEmail,
      this.lng,
      this.deposit_percentage,
      this.id,
      this.slot_interval,
      this.is_acceptance,
      this.userId,
      this.timing,
      this.businessImg,
      this.businessName,
      this.businessCategoryId,
      this.businessAddress,
      this.serviceDetail,
      this.userBusinessCategory});

  factory UserBusinessModel.fromJson(json) {
    var subStr = json["user_business_category"];
    print(subStr);
    UserBusinessCategoryModel? obj;
    if (subStr != null) {
      obj = UserBusinessCategoryModel.fromJson(subStr);
    }
    var tempTiming = json["user_business_timing"] as List;
    var userServices = json["user_business_service"];
    ServiceItemDataModel? serviceData;
    if (serviceData != null) {
      serviceData = ServiceItemDataModel.fromJson(userServices);
    }
    List<WeekDaysModel>? tempTiminglist = [];
    if (tempTiming != "") {
      print("tempTiming$tempTiming");

      int index = 0;
      var data = tempTiming;
      data.forEach(
        (element) {
          print(index);
          tempTiminglist.add(WeekDaysModel(
            value: index.toString(),
            name: element['day'].toString(),
            userid: element['user_id'].toString(),
            id: element['id'].toString(),
            endtime: PickUpDateTime(timeStr: element['close_time'].toString()),
            startime: PickUpDateTime(timeStr: element['open_time'].toString()),
            selected: element['isClosed'] == "0"
                ? true
                : element['isClosed'] == "1"
                    ? false
                    : false,
          ));
          index++;
        },
      );
    }
    print("tempTiminglist${tempTiminglist.length}");
    return UserBusinessModel(
        businessCategoryId: json['business_category_id'].toString(),
        id: json['id'].toString(),
        businessEmail: json['business_email'].toString(),
        businessName: json['business_name'].toString(),
        businessImg: json['business_img'].toString(),
        is_acceptance: json['is_acceptance'].toString(),
        slot_interval: json["slot_interval"].toString(),
        businessAddress: json['business_address'].toString() == "null"
            ? ""
            : json['business_address'].toString(),
        lat: json['lat'].toString(),
        userId: json['user_id'].toString(),
        deposit_percentage: json['deposit_percentage'].toString() == "null"
            ? ""
            : json['deposit_percentage'].toString(),
        lng: json['lng'].toString(),
        timing: tempTiminglist,
        serviceDetail: serviceData,
        userBusinessCategory: obj);
  }
}

class UserBusinessCategoryModel {
  int? id;
  String? businessCategoryName;

  String? businessCategoryimage;
  String? isDeleted;

  UserBusinessCategoryModel({
    this.id,
    this.businessCategoryName,
    this.businessCategoryimage,
    this.isDeleted,
  });

  factory UserBusinessCategoryModel.fromJson(json) {
    print(
        "${json['business_category_name']}${json['id']}${json['is_deleted']}");
    return UserBusinessCategoryModel(
      businessCategoryimage: json['image'].toString(),
      id: json['id'],
      businessCategoryName: json['business_category_name'].toString(),
      isDeleted: json['is_deleted'].toString(),
    );
  }
}
