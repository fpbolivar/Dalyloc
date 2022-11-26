class FoodTagsModel {
  var title = "";
  var id = 0;
  bool selected = false;
  FoodTagsModel({this.title = "", this.id = 0, this.selected = false});

  factory FoodTagsModel.fromJson(Map<String, dynamic> json) {
    return FoodTagsModel(
      title: json['name'] == null ? "" : json['name'].toString(),
      id: json['id'] == null ? 0 : json['id'],
      selected: json['user_selected'].toString() == "1" ? true : false,
    );
  }
}
