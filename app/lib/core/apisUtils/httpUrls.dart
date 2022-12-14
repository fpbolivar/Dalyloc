import '../localStore/localStore.dart';

class HttpUrls {
  var headers = {'Content-Type': 'application/json'};
  // ignore: constant_identifier_names
  static const WS_BASEURL =
      "https://codeoptimalsolutions.com/test/daly-doc/public/"; //"http://192.168.1.6/";
  //http://127.0.0.1:8000/api/auth/user-login
  // "https://codeoptimalsolutions.com/test/daly-doc/public/";
  static const WS_BASEURL2 =
      "https://codeoptimalsolutions.com/test/daly-doc/public";
  // ignore: constant_identifier_names
  static const WS_GOOGLELOGIN = "${WS_BASEURL}api/auth/google-login";
  // ignore: constant_identifier_names
  static const WS_FACEBOOKLOGIN = "${WS_BASEURL}api/auth/facebook-login";
  // ignore: constant_identifier_names
  static const WS_CREATEBUSINESS = "${WS_BASEURL}api/create-user-business";
  static const WS_EDITBUSINESSTIMESLOT =
      "${WS_BASEURL}api/edit-user-business-slot-interval";
  // ignore: constant_identifier_names
  static const WS_GETBUSINESS = "${WS_BASEURL}api/get-user-business";
  // ignore: constant_identifier_names
  static const WS_GETBUSINESSSERVICES =
      "${WS_BASEURL}api/get-all-user-business-service?business_id=";
  static const WS_GETBUSINESSOWNERSERVICES =
      "${WS_BASEURL}api/get-business-owner-services?business_id=";

  static const WS_GET_ADVANCE_PRICE_BYSERVICE_ID =
      "${WS_BASEURL}api/get-service-detail-by-id?service_id=";
  static const WS_GETBUSINESSSERVICES_BYID =
      "${WS_BASEURL}api/get-user-business-service-detail?business_service_id=";
  // ignore: constant_identifier_names
  static const WS_GETADMINPRAYER = "${WS_BASEURL}api/admin-prayer";
  static const WS_GET_PHYSICAL_LEVEL = "${WS_BASEURL}api/get-workout-level";
  static const WS_GET_WORKOUT_BY_LEVELID =
      "${WS_BASEURL}api/get-workouts-by-workout-level-id?workout_level_id=";
  // ignore: constant_identifier_names
  static const WS_GETPRAYERLIST = "${WS_BASEURL}api/prayer-list";
  // ignore: constant_identifier_names
  static const WS_CREATEPRAYER = "${WS_BASEURL}api/prayer-create";
  // ignore: constant_identifier_names
  static const WS_CHANGEPRAYERSTATUS = "${WS_BASEURL}api/prayer-update";

  // ignore: constant_identifier_names
  static const WS_CREATEBUSINESSSERVICES =
      "${WS_BASEURL}api/create-user-business-service";
  // ignore: constant_identifier_names
  static const WS_AddBankDetail = "${WS_BASEURL}api/add-business-bank";
  static const WS_UpdateBankDetail = "${WS_BASEURL}api/update-business-bank";
  static const WS_GET_TIME_SLOT = "${WS_BASEURL}api/appointment-business-slot";

  static const WS_GET_MY_APPOINTMENT =
      "${WS_BASEURL}api/get-user-appointments-list";

  static const WS_ADD_APPOINTMENT =
      "${WS_BASEURL}api/create-user-business-appointment";
  static const WS_ADD_APPOINTMENT_WITH_ADVANCE_PAY =
      "${WS_BASEURL}api/create-user-business-appointment-with-advance";
  // ignore: constant_identifier_names
  static const WS_CREATEBUSINESSTIMING =
      "${WS_BASEURL}api/edit-user-business-timing";
  // ignore: constant_identifier_names
  static const WS_UPDATEBUSINESSSERVICES =
      "${WS_BASEURL}api/edit-user-business-service";
  // ignore: constant_identifier_names
  static const WS_GETALLBUSINESSCATGORY =
      "${WS_BASEURL}api/auth/get-all-business-category";
  static const WS_GETALLBUSINESSCATGORY_ID =
      "${WS_BASEURL}api/get-business-list?business_category_id=";
  // ignore: constant_identifier_names
  static const WS_USERLOGIN = "${WS_BASEURL}api/auth/user-login";
  // ignore: constant_identifier_names
  static const WS_USERLOGOUT = "${WS_BASEURL}api/logout";

  // ignore: constant_identifier_names
  static const WS_USERREGISTER = "${WS_BASEURL}api/auth/user-register";
  // ignore: constant_identifier_names
  static const WS_GETUSERDATA = "${WS_BASEURL}api/get-profile";
  // ignore: constant_identifier_names
  static const WS_CREATETASK = "${WS_BASEURL}api/create-task";
  // ignore: constant_identifier_names
  static const WS_EDITTASK = "${WS_BASEURL}api/update-task?id=";
  // ignore: constant_identifier_names
  static const WS_DELETETASK = "${WS_BASEURL}api/delete-task/";
  // ignore: constant_identifier_names
  static const WS_GETALLTASK = "${WS_BASEURL}api/all-task-by-date?dateString=";
  // ignore: constant_identifier_names
  static const WS_OTPVERIFICATION =
      "${WS_BASEURL}api/auth/verify-phone-with-otp";
  // ignore: constant_identifier_names
  static const WS_OTPVERIFICATIONFORGOT =
      "${WS_BASEURL}api/auth/password/otp/verify";

  static const WS_SENT_OTP_TO_UPDATENUMBER =
      "${WS_BASEURL}api/auth/get-otp-for-google";
  static const WS_UPDATE_PROFILE = "${WS_BASEURL}api/edit-profile";
  // ignore: constant_identifier_names
  static const WS_CREATENEWPASSWORDAFTERFORGOT =
      "${WS_BASEURL}api/auth/password/reset";
  // ignore: constant_identifier_names
  static const WS_RESENDOTP =
      "${WS_BASEURL}api/auth/resend-authenticate-otp?user_id=";
  // ignore: constant_identifier_names
  static const WS_RESENDOTPFORGOT = "${WS_BASEURL}api/auth/password/resendotp";
  // ignore: constant_identifier_names
  static const WS_FORGOTPASSWORD = "${WS_BASEURL}api/auth/password/create";
  // ignore: constant_identifier_names
  static const WS_EDITUSERPROFILE = "${WS_BASEURL}api/auth/edit-profile";
  // ignore: constant_identifier_names
  static const WS_CHANGEPASSWORD = "${WS_BASEURL}api/change-password";
  // ignore: constant_identifier_names
  static const WS_GETALLPLANS = "${WS_BASEURL}api/get-plans";
  // ignore: constant_identifier_names
  static const WS_SUBCRIBEPLANS = "${WS_BASEURL}api/stripe-user-subscription";
  // ignore: constant_identifier_names
  static const WS_CANCELPLANS =
      "${WS_BASEURL}api/stripe-user-cancel-subscription";
  // ignore: constant_identifier_names
  static const WS_GETACTIVEPLANS = "${WS_BASEURL}api/get-user-active-plans";

//meal API
  static const WS_GETMENUVARIENT = "${WS_BASEURL}api/get-menu-type";
  static const WS_GETMEALSIZE = "${WS_BASEURL}api/get-meal-size";
  static const WS_GETALLERIES = "${WS_BASEURL}api/get-allergies";
  static const WS_GET_MEAL_ITEMS_BYTYPE =
      "${WS_BASEURL}api/get-user-meal-detail?type=";
  static const WS_CREATE_MEAL = "${WS_BASEURL}api/create-user-meal-detail";

  static const WS_PRAYERSETTING = "${WS_BASEURL}api/prayer-setting";
  static const WS_EXERCISESETTING = "${WS_BASEURL}api/exercise-setting";
  static const WS_MEALSETTING = "${WS_BASEURL}api/update-user-meal-setting";
  static const WS_GETPRAYERSETTING = "${WS_BASEURL}api/get-setting";
  static const WS_GETEXERCISESETTING = "${WS_BASEURL}api/get-exercise-setting";
  static const WS_GETMEALSETTING = "${WS_BASEURL}api/get-user-meal-setting";
  static const WS_GET_SELECTED_MEALPLAN =
      "${WS_BASEURL}api/get-selected-meal-ids";
  static const WS_GET_RECEIPE = "${WS_BASEURL}api/get-recipes";
  static const WS_GET_USER_RECEIPE = "${WS_BASEURL}api/get-user-meal-plan";
  static const WS_GET_RECEIPE_By_ID =
      "${WS_BASEURL}api/get-single-recipe?recipe_id=";
  static const WS_GET_MY_RECEIPE_By_ID =
      "${WS_BASEURL}api/get-user-single-recipe?recipe_id=";
  static const WS_GET_RECEIPE_BY_CAT_ID =
      "${WS_BASEURL}api/get-recipes-by-category?meal_category_id=";
  static const WS_GET_UPDATE_NOTIFICATION =
      "${WS_BASEURL}api/get-notification-setting";
  static const WS_GET_UPDATE_24TIMEFORMAT = "${WS_BASEURL}api/user-time-format";
  static const WS_GET_UPDATE_PAYMENT_ONLINE =
      "${WS_BASEURL}api/get-online-booking-setting";
  static const WS_GET_SET_WAKEUP_TIME = "${WS_BASEURL}api/user-wake-up";
  static const WS_GET_ACTIVEPAYMENT =
      "${WS_BASEURL}api/get-active-payment?user_business_id=";
  static const WS_GET_ACTIVESTATUS_BY_TYPE =
      "${WS_BASEURL}api/get-user-active-plans-by-type?plan_operation=";
  static const WS_SubmitSelectedMeal = "${WS_BASEURL}api/create-user-meal-plan";

  static const WS_ACCEPTANCEUPDATE = "${WS_BASEURL}api/acceptance";
  static const WS_UPDATEACTIVEPAYMENT = "${WS_BASEURL}api/active-payment";
  static const WS_DEPOSITPERCENTAGE = "${WS_BASEURL}api/update-deposit";
  static const WS_CreateMealSetup = "${WS_BASEURL}api/create-user-meal-detail";
  static const WS_AddCard = "${WS_BASEURL}api/create-card-token";
  static const WS_GetAllCard = "${WS_BASEURL}api/get-user-stripe-cards";
  static const WS_DefaultCardSet = "${WS_BASEURL}api/update-default-card";
  static const WS_DeleteCard = "${WS_BASEURL}api/delete-card";
  static const WS_PRAYER_CATEGORY = "${WS_BASEURL}api/get-category";
  static const WS_GET_EXERCISE_BY_WORKOUTID =
      "${WS_BASEURL}api/get-exercies-by-workout-id?workout_id=";
  static const WS_STARTWORKOUT = "${WS_BASEURL}api/create-user-workout";
  static const WS_COMPLETEWORKOUT =
      "${WS_BASEURL}api/complete-user-workout?workout_id=";
  static const WS_TERMSCONDTIONS =
      "${WS_BASEURL}api/get-exercise-term-conditions";

  static const WS_CANCEL_BOOKING =
      "${WS_BASEURL}api/cancel-user-appointment?appt_id=";

  static const WS_RESCHEDULE_BOOKING =
      "${WS_BASEURL}api/reschedule-user-appointment";

  static const WS_GET_USER_APPOINTMENTDETAILBY_ID =
      "${WS_BASEURL}api/get-user-appointment-detail-by-id?appt_id=";

  static const WS_GET_BIZOWNER_APPOINTMENTList =
      "${WS_BASEURL}api/get-business-owner-appointments-list";

  static const WS_ACCEPT_BOOKING =
      "${WS_BASEURL}api/accept-user-appointment?appt_id=";

  static const WS_COMPLETE_BOOKING =
      "${WS_BASEURL}api/complete-user-appointment?appt_id=";
  static const WS_ASK_FOR_PAYMENT =
      "${WS_BASEURL}api/ask-for-appointment-payment?appt_id=";

  static const WS_DELETE_ACCOUNT = "${WS_BASEURL}api/delete-account";

  static const WS_REJECT_BOOKING =
      "${WS_BASEURL}api/reject-user-appointment?appt_id=";
  static const WS_PENDING_DUE_PAYNOW =
      "${WS_BASEURL}api/pay-full-payment-for-appointment";

  static const WS_RATING_SUBMIT = "${WS_BASEURL}api/user-appointment-rating";
  static const WS_ACCEPT_TERMS_CONDS =
      "${WS_BASEURL}api/accept-exercise-term-conditions";
  static const WS_GET_BANK_DETAIL = "${WS_BASEURL}api/get-business-bank";
  static Future<Map<String, String>> headerData() async {
    return {
      "Authorization": await LocalStore().getToken(),
      "content-type": 'application/json',
    };
  }
}
