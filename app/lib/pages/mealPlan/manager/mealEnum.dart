enum MealTypePlan { meal, exercise, devotional, smart }

extension TopicExtension on MealTypePlan {
  String get rawValue {
    switch (this) {
      case MealTypePlan.meal:
        return 'meal';
      case MealTypePlan.exercise:
        return 'exercise';
      case MealTypePlan.devotional:
        return 'devotional';
      case MealTypePlan.smart:
        return 'smart';
    }
  }
}
