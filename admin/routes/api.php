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
 });

 Route::group(['namespace' => 'Api'], function ($router) {
	// with auth
	Route::group(['middleware' => ['user.api']], function() {
	    Route::get('get-profile',[ApiProfileController::class,'GetProfile']);
        Route::post('change-password',[ApiProfileController::class,'ChangePassword']);
        Route::post('edit-profile',[ApiProfileController::class,'EditProfile']);

        //Create user task
        Route::post('create-task',[CreateTaskController::class,'CreateTask']);
        Route::post('update-task',[CreateTaskController::class,'UpdateTask']);
        Route::get('delete-task/{id}',[CreateTaskController::class,'DeleteTask']);
        Route::get('all-task-by-date',[CreateTaskController::class,'AllTaskByDate']);

        //plans
        Route::get('get-plans',[SubscriptionPlansController::class,'GetPlans']);
        Route::get('get-user-active-plans',[SubscriptionPlansController::class,'GetUserActivePlans']);
        Route::post('stripe-user-cancel-subscription',[SubscriptionPlansController::class,'StripeUserCancelSubscription']);

        //stripe
        Route::post('stripe-user-subscription',[SubscriptionPlansController::class,'StripeUserSubscription']);
        
        //user business
        Route::post('create-user-business',[BusinessApiController::class,'CreateUserBusiness']);
        Route::get('get-user-business',[BusinessApiController::class,'GetUserBusiness']);
        Route::post('edit-user-business-slot-interval',[BusinessApiController::class,'EditUserBusinessSlotInterval']);

        //user business service
        Route::post('create-user-business-service',[BusinessApiController::class,'CreateUserBusinessService']);
        Route::post('edit-user-business-service',[BusinessApiController::class,'EditUserBusinessService']);
        Route::get('delete-user-business-service',[BusinessApiController::class,'DeleteUserBusinessService']);
        Route::get('get-all-user-business-service',[BusinessApiController::class,'GetAllUserBusinessService']);

        //user business timing
        Route::post('create-user-business-timing',[BusinessApiController::class,'CreateUserBusinessTiming']);
        Route::post('edit-user-business-timing',[BusinessApiController::class,'EditUserBusinessTiming']);


	});
    // v5.0
  
});

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
