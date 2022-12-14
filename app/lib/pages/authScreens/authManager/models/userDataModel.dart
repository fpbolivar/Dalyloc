class UserDetailModel {
  int? id;
  String? name;
  int? age;
  String? dateOfBirth;
  String? weight;

  String? height;
  String? inchse;
  String? gender;
  String? mobile_no;
  String? login_type;
  String? country_code;
  UserDetailModel(
      {this.age,
      this.dateOfBirth,
      this.mobile_no,
      this.login_type,
      this.id,
      this.height,
      this.inchse,
      this.gender,
      this.name,
      this.country_code,
      this.weight});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      age: json['age'] ?? "",
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      gender: json['gender'] ?? "",
      mobile_no: json['phone_no'] ?? "",
      dateOfBirth: json['date_of_birth'] ?? "",
      country_code: json['country_code'] ?? "",
      height: json['height'] ?? "",
      weight: json['weight'] ?? "",
      login_type: json['login_type'] ?? "manual",
    );
  }
}
