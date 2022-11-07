enum SettingType { normal, logout }

class SettingOption {
  String? title;
  int? section;
  SettingType? type;
  SettingOption({this.title, this.section, this.type = SettingType.normal});
}
