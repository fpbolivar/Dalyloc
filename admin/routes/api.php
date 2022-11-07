<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiSocialLoginController;
use App\Http\Controllers\Api\AuthApiController;
use App\Http\Controllers\Api\ApiProfileController;
use App\Http\Controllers\Api\ResetPasswordController;


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

	});
    // v5.0
  
});

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
