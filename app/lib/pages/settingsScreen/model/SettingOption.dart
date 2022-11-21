import 'allPlanMode.dart';

enum SettingType { normal, logout, loading, refresh }

class SettingOption {
  String? title;
  int? section;
  SettingType? type;
  List<SubscriptionSubPlansModel>? subscriptionSubPlans;
  SettingOption(
      {this.title,
      this.section,
      this.type = SettingType.normal,
      this.subscriptionSubPlans});
}
