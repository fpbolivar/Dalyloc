class SubtaskModel {
  int? id;
  String? description;
  bool? isSelected;
  bool? isCompleted;
  SubtaskModel(
      {this.id,
      this.description,
      this.isSelected = false,
      this.isCompleted = false});
}
