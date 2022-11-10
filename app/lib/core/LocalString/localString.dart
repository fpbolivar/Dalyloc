import 'package:daly_doc/utils/exportPackages.dart';

class LocalString {
  static const lblDalyDoc = "Daly Doc";
  static String userName = "User";
  static String userMobileNo = "1234567890";

  static bool isRunningLoader = false;
  static const internetNot = "Connection lost.Check your internet connection.";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const lblChosseOne = "Choose one.";
  static const lblPersonal = "Personal";
  static const lblBusiness = "Business";
  static const lblStayOrganized = "Stay Organized ";
  static const lblDaily = ' Daily.';
  static const lblGetStarted = "Get Started";
  static const lblChooseSchedule = "Choose how to schedule";
  static const lblSendEmail = "Send email";
  static const lblSendText = "Send text";
  static const lblCopyLink = "Copy link";
  static const lblBookInterView = "Book a interview";
  static const lblSend = "Send";
  static const lblSubmit = "Submit";
  static const lblNotification = "Notification";
  static const lblSubscription = "Subscription";

  static const lblActive = "Active";
  static const lblCreate = "Create";
  static const lblPlan = "Plan";

  static const lblPlaceReminder = "A place to keep your reminder";
  static const lblInboxMsg =
      "Your inbox is a brain dump for everything you need to do, But don't yet know when you want to do them.";
  static const lblSkip = "SKIP";
  static const lblGoalSetting = "Goal Setting";
  static const lblLogin = "Login";
  static const lblLetsStart = "Let’s Get\nStarted";
  static const lblLetsStartDescription =
      "Your daily planner app to help you\norganise your life";
  static const lblLetsStarLoginDescription =
      "Welcome back you’ve\nbeen missed!";
  static const lblGoalSettingDes =
      "Create the goal, break it down into habits & smaller, more achievable steps and tasks.";
  static const lblDailyPlanner = "Daily Planner";
  static const lblDailyPlannerDes =
      "Your daily planner app to help you organise your life, automating you success towards achieving you goals each day.";
  static const lblContinueWithFB = "Continue with Facebook";
  static const lblContinueWithGoogle = "Continue with Google";
  static const lblOrContinueWith = "Or continue with";
  static const lblForgotPassword = "Forgot Password?";
  static const lblResend = "Resend code?";
  static const lblSignIn = "Sign In";
  static const lblDontHaveAccnt = "You don’t have an account ";
  static const lblSignUp = "SignUp";

  static const lblVerify = "Verify";
  static const lblSignUpDescription =
      "To manage daily plans, getting reminder about tasks, events create an account. ";
  static const lblCreateAnAccount = "Create an account";
  static const lblChangePassword = "Change Password";
  static const lblForgotPasswordNavTitle = "Forgot\nPassword?";
  static const lblForgotPasswordDescription =
      "Don’t worry! It happens. Please enter the mobile number associated with you account.";
  static const lblOTPVerify = "Enter OTP code\nto verify";
  static const lblOTPVerifyDescription =
      "Please enter your verification code for verify your mobile number";
  static const lblotpTFHint = "OTP Code";
  static const lblCreateNewPasswordNavTitle = "Create new\nPassword?";
  static const lblCreateNewPasswordDescription =
      "Your new password must be differnet from previous used passwords.";
  static const lblSettingNavTitle = "Settings";
  //PLACEHOLDER
  static const plcMobileNo = "Mobile No";
  static const plcEnterMobileNo = "Enter Mobile No";
  static const plcPassword = "Passsword";
  static const plcCurrentPassword = "Current Passsword";
  static const plcName = "Name";
  static const plcOTP = "Six digits OTP Code";
  static const plcCNFPassword = "Confirm Passsword";
  static const plcEmail = "Email";
  getFCMToken() {}

  // Future<String?> _getId() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else if (Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }
}
