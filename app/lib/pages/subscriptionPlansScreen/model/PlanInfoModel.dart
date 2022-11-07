enum PlanType { free, monthly, yearly }

extension PlanTypeString on String {
  PlanType get planType {
    switch (this) {
      case 'free':
        return PlanType.free;
      case 'monthly':
        return PlanType.monthly;
      case 'yearly':
        return PlanType.yearly;
      default:
        return PlanType.free;
    }
  }
}

extension TopicExtension on PlanType {
  String get rawValue {
    switch (this) {
      case PlanType.free:
        return 'free';
      case PlanType.monthly:
        return 'month';
      case PlanType.yearly:
        return 'year';
    }
  }
}

enum ContentType {
  choice,
  text,
}

class PlanInfoModel {
  String title = "";
  String description = "";
  String btnTitle = "";
  String price = "";
  String image = "";
  ContentType contextType = ContentType.text;
  PlanType periodDuration;

  PlanInfoModel(
      {this.title = "",
      this.description = "",
      this.btnTitle = "",
      this.price = "",
      this.image = "",
      this.contextType = ContentType.text,
      this.periodDuration = PlanType.monthly});
}
