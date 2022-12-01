import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static var app = StripeService();
  Future<void> setup() async {
    Stripe.publishableKey =
        "pk_test_51IUWJAFH3Oyd7VR9WfGGAx1ZCXO1WqcF8eRO5YqB3VKg9mtCwW1jiTbF8njzFKu6b2aFDBZeHEQjJc14GHin5y0M009Mo1eRBK";
    // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    //Stripe.urlScheme = 'flutterstripe';
    return await Stripe.instance.applySettings();
  }
}
