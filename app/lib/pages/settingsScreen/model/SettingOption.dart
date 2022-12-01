import 'allPlanMode.dart';

enum SettingType { normal, logout, loading, refresh, toggle, counter, time }

class SettingOption {
  String? title;
  int? section;
  int? counter;
  String? time;

  bool? value;

  SettingType? type;
  List<SubscriptionSubPlansModel>? subscriptionSubPlans;
  SettingOption(
      {this.title,
      this.section,
      this.time,
      this.counter,
      this.value = false,
      this.type = SettingType.normal,
      this.subscriptionSubPlans});
}
