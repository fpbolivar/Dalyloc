class UserDetailModel {
  String? id;
  String? name;
  String? age;
  String? dateOfBirth;
  String? weight;

  String? feet;
  String? inchse;

  UserDetailModel(
      {this.age,
      this.dateOfBirth,
      this.id,
      this.feet,
      this.inchse,
      this.name,
      this.weight});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      age: json['category_id'].toString(),
      id: json['service_id'].toString(),
      name: json['description'].toString(),
      dateOfBirth: json['category_type'].toString(),
      feet: json['tag'].toString(),
      inchse: json['type'].toString(),
      weight: json['id'].toString(),
    );
  }
}
