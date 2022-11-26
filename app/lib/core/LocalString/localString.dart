class LocalString {
  static const lblDalyDoc = "Daly Doc";
  static String userName = "User";
  static String userMobileNo = "1234567890";

  static bool isRunningLoader = false;
  static const internetNot = "Connection lost.Check your internet connection.";

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
  static const lblSave = "Save";
  static const lblSubmit = "Submit";
  static const lblUpload = "Upload";
  static const lblNotification = "Notifications";
  static const lblSubscription = "Subscription";

  static const lblActive = "Active";
  static const lblCreate = "Create";
  static const lblUpdate = "Update";
  static const lblPlan = "Plan";

  static const lblPlaceReminder = "A place to keep your reminder";
  static const lblInboxMsg =
      "Your inbox is a brain dump for everything you need to do, But don't yet know when you want to do them.";
  static const lblSkip = "SKIP";
  static const lblGoalSetting = "Goal Setting";
  static const lblDeposit = "Deposits";
  static const lblBookingAcceptance = "Booking Acceptance";

  static const lblTimeSlotsAvailabilty = "Time Slots Availabilty";
  static const lblDepositDescription =
      "Require clients to pay (%) a deposit at the time of booking. ";
  static const lblBookingLinkDc =
      "Let client book online 24/7 on your free booking webiste.";
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
  static const lblCongratulation = "Congratulation";
  static const lblSignUpDescription =
      "To manage daily plans, getting reminder about tasks, events create an account. ";
  static const lblBusinessDescription =
      "To manage daily plans, getting reminder about tasks, events create an business. ";
  static const lblBusinessCongratsDescription =
      "You gain access to proceed your business at next level. ";
  static const lblCreateAnAccount = "Create an account";
  static const lblCreateAnBusiness = "Create Business";
  static const lblDc1 =
      "Good morning, Lord! Today's a new day, a chance for a new start. Yesterday is gone and with it any regrets, mistakes, or failures I may have experienced. It's a good day to be glad and give thanks, and I do, Lord. Thank you for today, a new opportunity to love, give, and be all that you want me to be.";
  static const lblAmomentofPrayerDc =
      "Good morning, Lord!\nToday's a new day, a chance for a new start. Yesterday is gone and with it any regrets, mistakes, or failures I may have experienced. It's a good day to be glad and give thanks, and I do, Lord. Thank you for today, a new opportunity to love, give, and be all that you want me to be";
  static const lblAmomentofPrayer = "A moment of Prayer";
  static const lblPrayer = "Prayer";
  static const lblLetsPray = "Let's Pray";

  static const lblBusinessTiming = "Business Timing ";
  static const lblBusinessDetails = "Business Details";
  static const lblServiceDetail = "Service Detail";

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
  static const lblBizSettingNavTitle = "Business Settings";
  //PLACEHOLDER
  static const plcMobileNo = "Mobile No";
  static const plcEnterMobileNo = "Enter Mobile No";
  static const plcPassword = "Passsword";
  static const plcCurrentPassword = "Current Passsword";

  static const plcOTP = "Six digits OTP Code";
  static const plcAddress = "Address";
  static const plcCNFPassword = "Confirm Passsword";
  static const plcLongLat = "Longitude/Latitude";
  static const plcEmail = "Email";
  static const plcName = "Name";
  static const plcEnterTitle = "Enter title ";
  static const plcNeedToAddMoreNotes = "Need to add more notes";
  static const plcBusinessEmail = "Business Email";
  static const plcBusinessName = "Business Name";

  static const plcServiceName = "Service Name";
  static const plcServicePrice = "Business Price";
  static const plcDuration = "Duration";

  //MESSAGES
  static const msgEmail = "Enter email";
  static const msgTaskName = "Enter Task Name";
  static const msgInValidEmail = "Invalid email format";
  static const msgNotes = "Enter Notes";
  static const msgSessionExpired = "Session expired";
  static const msgUpdateTask = "Successfully,Task has been Update.";
  static const msgCreatedTask = "Successfully,Task has been created.";
  static const msgSelectTime = "Select Time";
  static const msgSelectDate = "Select Date";
  static const msgSelectHowLong = "Select HowLong option";
  static const msgSelectHowOften = "Select HowOften option";
  static const msgDeleteTask = "Do you want to delete task?";
  static const msgSyncAndLogout = "  Syncing & Sign Out";
  static const msgWantBuyPlanTask =
      "Would you like to buy a subscription plan?";
  static const msgCancelPlan = "Would you like to cancel a subscription plan?";
  static const msgCancelSubscription =
      "Successfully, cancelled your  subscription.";
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
