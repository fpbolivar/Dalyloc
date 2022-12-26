<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiSocialLoginController;
use App\Http\Controllers\Api\AuthApiController;
use App\Http\Controllers\Api\ApiProfileController;
use App\Http\Controllers\Api\ResetPasswordController;
use App\Http\Controllers\Api\CreateTaskController;
use App\Http\Controllers\Api\SubscriptionPlansController;
use App\Http\Controllers\Api\BusinessApiController;
use App\Http\Controllers\Api\ApiMealController;
use App\Http\Controllers\Api\ApiUserWorkout;
use App\Http\Controllers\Api\ApiPrayerController;
use App\Http\Controllers\Api\UserAppointmentController;
use App\Http\Controllers\Api\BusinessBankController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::group(['prefix' => 'auth','namespace' => 'Api'], function ($router) {
    Route::post('user-register', [AuthApiController::class,'UserRegister']);
    Route::post('verify-phone-with-otp', [AuthApiController::class,'VerifyPhoneWithOtp']);
    Route::post('get-otp-for-google', [AuthApiController::class,'GetOtpForGoogle']);
    Route::post('user-login', [AuthApiController::class,'UserLogin']);
    Route::post('google-login', [ApiSocialLoginController::class,'GoogleLogin']);
    Route::post('facebook-login',  [ApiSocialLoginController::class,'FacebookLogin']);
    Route::get('resend-authenticate-otp', [AuthApiController::class,'ResendAuthenticateOtp']);
    //forgot password
    Route::post('password/create', [ResetPasswordController::class,'create']);
    Route::post('password/otp/verify', [ResetPasswordController::class,'OtpVerify']);
    Route::post('password/reset', [ResetPasswordController::class,'reset']);
    Route::post('password/resendotp', [ResetPasswordController::class,'ResendOTP']);

    //business catgeory
    Route::get('get-all-business-category',[BusinessApiController::class,'GetAllBusinessCategory']);

});

Route::group(['middleware' => ['user.api']], function() {
    Route::get('logout', [AuthApiController::class,'logout']);
    Route::get('delete-account', [AuthApiController::class,'DeleteAccount']);
 });

 Route::group(['namespace' => 'Api'], function ($router) {
	// with auth
    Route::get('prayer-cron', [ApiPrayerController::class,'cron']);
    Route::get('get-cron-meal',[ApiMealController::class,'cron']);
    
	Route::group(['middleware' => ['user.api']], function() {
	    Route::get('get-profile',[ApiProfileController::class,'GetProfile']);
        Route::post('change-password',[ApiProfileController::class,'ChangePassword']);
        Route::post('edit-profile',[ApiProfileController::class,'EditProfile']);
        Route::get('user-wake-up',[ApiProfileController::class,'UserWakeUp']);

        //user time format detail
        Route::get('user-time-format',[ApiProfileController::class,'UserTimeFormat']);

        //Create user task
        Route::post('create-task',[CreateTaskController::class,'CreateTask']);
        Route::post('update-task',[CreateTaskController::class,'UpdateTask']);
        Route::get('delete-task/{id}',[CreateTaskController::class,'DeleteTask']);
        Route::get('all-task-by-date',[CreateTaskController::class,'AllTaskByDate']);

        //get user and business oppointment detail by create task click
        //task type = user_appointment = user detail
        //task type = business_appointment = business ownr detail
        Route::post('get-appt-detail-create-task',[CreateTaskController::class,'GetApptDeatilCreateTask']); 
        // //get user and business oppointment detail by create task click
        // Route::get('get-business-appt-detail',[CreateTaskController::class,'GetBusinessApptDeatil']);  //task type = business_appointment
        // Route::get('get-user-appt-detail',[CreateTaskController::class,'GetUserApptDeatil']);  //task type = user_appointment

        //admin setting  
        Route::get('get-setting',[AdminSettingController::class,'Index']);

        //plans 
        Route::get('get-plans',[SubscriptionPlansController::class,'GetPlans']);
        
        // card and customer
        Route::post('create-card-token',[SubscriptionPlansController::class,'CreateCardToken']);
        Route::get('get-user-stripe-cards',[SubscriptionPlansController::class,'GetUserCards']);
        Route::post('update-default-card',[SubscriptionPlansController::class,'UpdateDefaultCard']);
        Route::post('delete-card',[SubscriptionPlansController::class,'DeleteCard']);
        
        // subscription
        Route::get('get-user-active-plans',[SubscriptionPlansController::class,'GetUserActivePlans']);
        Route::post('stripe-user-cancel-subscription',[SubscriptionPlansController::class,'StripeUserCancelSubscription']);
        Route::get('get-user-active-plans-by-type',[SubscriptionPlansController::class,'GetUserActivePlansByType']);

        //stripe
        Route::post('stripe-user-subscription',[SubscriptionPlansController::class,'StripeUserSubscription']);
        
        //user business
        Route::post('create-user-business',[BusinessApiController::class,'CreateUserBusiness']);
        Route::post('update-user-business',[BusinessApiController::class,'UpdateUserBusiness']);
        Route::get('get-user-business',[BusinessApiController::class,'GetUserBusiness']);
        Route::post('edit-user-business-slot-interval',[BusinessApiController::class,'EditUserBusinessSlotInterval']);
        Route::get('get-online-booking-setting',[BusinessApiController::class,'GetOnlineBookingSetting']);
        Route::post('deposit-percentage',[BusinessApiController::class,'DepositPercentage']);
        Route::get('get-deposit-percentage',[BusinessApiController::class,'GetDepositPercentage']);
        Route::get('get-acceptance',[BusinessApiController::class,'GetAcceptance']);
        Route::post('acceptance',[BusinessApiController::class,'Acceptance']);
        Route::get('get-active-payment',[BusinessApiController::class,'GetActivePayment']);
        Route::post('active-payment',[BusinessApiController::class,'ActivePayment']);

        //user business service
        Route::post('create-user-business-service',[BusinessApiController::class,'CreateUserBusinessService']);
        Route::post('edit-user-business-service',[BusinessApiController::class,'EditUserBusinessService']);
        Route::get('delete-user-business-service',[BusinessApiController::class,'DeleteUserBusinessService']);
        Route::get('get-all-user-business-service',[BusinessApiController::class,'GetAllUserBusinessService']);
        Route::get('get-user-business-service-detail',[BusinessApiController::class,'GetUserBusinessServiceDetail']);

        //user business timing
        Route::post('create-user-business-timing',[BusinessApiController::class,'CreateUserBusinessTiming']);
        Route::post('edit-user-business-timing',[BusinessApiController::class,'EditUserBusinessTiming']);

        //deposit
        Route::post('update-deposit', [BusinessApiController::class,'UpdateDeposite']);

        //get menu type
        Route::get('get-menu-type',[ApiMealController::class,'GetMenuType']);
        Route::get('get-meal-size',[ApiMealController::class,'GetMealSize']);
        Route::get('get-allergies',[ApiMealController::class,'GetAllergies']);
        Route::get('get-meal-cookware',[ApiMealController::class,'GetMealCookware']);
        Route::get('get-recipes',[ApiMealController::class,'GetRecipes']);
        Route::get('get-recipes-by-category',[ApiMealController::class,'GetRecipesByCategory']);
        Route::get('get-single-recipe',[ApiMealController::class,'GetSingleRecipe']);
        Route::get('get-user-single-recipe',[ApiMealController::class,'GetUserSingleRecipe']);
        
        //user meal plan
        Route::get('get-selected-meal-ids',[ApiMealController::class,'GetSelectedMealIds']);
        Route::post('create-user-meal-plan',[ApiMealController::class,'CreateUserMealPlan']);
        Route::get('get-user-meal-plan',[ApiMealController::class,'GetUserMealPlan']);
        Route::post('create-user-meal-detail',[ApiMealController::class,'CreateUserMealDetail']);
        Route::post('update-user-meal-setting',[ApiMealController::class,'AddMealSetting']);
        Route::get('get-user-meal-setting',[ApiMealController::class,'GetMealSetting']);
        
        Route::get('get-user-meal-detail',[ApiMealController::class,'GetUserMealDetail']);
        Route::get('get-notification-setting',[ApiMealController::class,'GetNotificationSetting']);

        //user workout
        Route::get('get-workout-level',[ApiUserWorkout::class,'GetWorkoutLevel']);
        Route::get('get-workouts-by-workout-level-id',[ApiUserWorkout::class,'GetWorkoutByWorkoutLevelId']);
        Route::get('get-exercies-by-workout-id',[ApiUserWorkout::class,'GetExerciseByWorkoutId']);
        Route::post('create-user-workout',[ApiUserWorkout::class,'CreateUserWorkout']);
        Route::get('complete-user-workout',[ApiUserWorkout::class,'CompleteUserWorkout']);
        Route::get('get-exercise-term-conditions',[ApiUserWorkout::class,'GetExericeTermConditions']);
        Route::post('accept-exercise-term-conditions',[ApiUserWorkout::class,'AcceptExericeTermConditions']);
        Route::post('exercise-setting', [ApiUserWorkout::class,'ExerciseSetting']);
        Route::get('get-exercise-setting', [ApiUserWorkout::class,'GetExerciseSetting']);

        // prayer route
        Route::post('prayer-create', [ApiPrayerController::class,'Create']);
        Route::get('prayer-list', [ApiPrayerController::class,'GetPrayer']);
        Route::post('prayer-update', [ApiPrayerController::class,'UpdatePrayer']);
        Route::get('admin-prayer', [ApiPrayerController::class,'GetAdminPrayer']);
            
        Route::post('prayer-setting', [ApiPrayerController::class,'PrayerSetting']);
        Route::get('get-setting', [ApiPrayerController::class,'GetPrayeSetting']);
        Route::get('get-category', [ApiPrayerController::class,'GetPrayerCategory']);

        //add bank
        Route::post('add-business-bank', [BusinessBankController::class,'AddBusinessBank']);
        Route::post('update-business-bank', [BusinessBankController::class,'UpdateBusinessBank']);
        Route::get('get-business-bank', [BusinessBankController::class,'GetBusinessBank']);

        //appointment
        Route::get('get-business-categories-list', [UserAppointmentController::class,'GetBusinessCategoriesList']);
        Route::get('get-business-list', [UserAppointmentController::class,'GetBusinessList']);
        Route::get('get-business-by-id', [UserAppointmentController::class,'GetBusinessById']);
        Route::get('get-business-owner-services', [UserAppointmentController::class,'GetBusinessOwnerService']);
        Route::get('get-service-detail-by-id', [UserAppointmentController::class,'GetServiceDetailById']);
        Route::get('get-advance-amt', [UserAppointmentController::class,'GetAdvanceAmt']);
        Route::post('appointment-business-slot', [UserAppointmentController::class,'AppointmentBusinessSlot']);
        Route::get('ephemeral-key', [UserAppointmentController::class,'EphemeralKey']);
        Route::post('advance-payment', [UserAppointmentController::class,'AdvancePayment']);
        Route::post('create-user-business-appointment', [UserAppointmentController::class,'CreateUserBusinessAppointment']);
        Route::post('create-user-business-appointment-with-advance', [UserAppointmentController::class,'CreateUserBusinessAppointmentWithAdvance']);
        Route::post('pay-full-payment-for-appointment', [UserAppointmentController::class,'PayFullPyamentForAppointment']);
        //pay advance for booking an appointment
        Route::post('appointment-advance-payment',[UserAppointmentController::class,'AppointmentAdvancePayment']);
        Route::post('user-appointment-rating',[UserAppointmentController::class,'UserAppointmentRating']);

        //appoinment user list
        Route::get('get-user-appointments-list', [UserAppointmentController::class,'GetUserAppointmentsList']);
        Route::get('get-user-appointment-detail-by-id', [UserAppointmentController::class,'GetUserAppointmentDetailById']);
        Route::get('cancel-user-appointment', [UserAppointmentController::class,'CancelUserAppointment']);
        Route::post('reschedule-user-appointment', [UserAppointmentController::class,'RescheduleUserAppointment']);
        Route::get('get-notification-list', [UserAppointmentController::class,'GetNotificationList']);
        
        
        //appoinment business list
        Route::get('get-business-owner-appointments-list', [UserAppointmentController::class,'GetBusinessOwnerAppointmentsList']);
        Route::get('get-business-owner-appointment-detail-by-id', [UserAppointmentController::class,'GetBusinessOwnerAppointmentDetailById']);
        Route::get('accept-user-appointment', [UserAppointmentController::class,'AcceptUserAppointment']);
        Route::get('reject-user-appointment', [UserAppointmentController::class,'RejectUserAppointment']);
        Route::get('complete-user-appointment', [UserAppointmentController::class,'CompleteUserAppointment']);
        Route::get('ask-for-appointment-payment', [UserAppointmentController::class,'AskForAppointmentPayment']);

	});
    // v5.0
  
});

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
