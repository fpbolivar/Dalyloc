<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\WebAppointmentController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
// Route::get(env('BOOKING_URL'), function () {
    // Route::get("ldml", [WebAppointmentController::class,'WebBooking']);

// });\

Route::get(env('WEB_URL').'/{slug}', [WebAppointmentController::class,'WebBooking']);
Route::match(['post','get'],env('WEB_URL').'/select/service/{id}', [WebAppointmentController::class,'SelectService']);
Route::post(env('WEB_URL').'/getservice', [WebAppointmentController::class,'GetService']);
Route::match(['post','get'],env('WEB_URL').'/check/time/{id}', [WebAppointmentController::class,'TimeStaff']);
Route::match(['post','get'],env('WEB_URL').'/contact/detail',[WebAppointmentController::class,'GetContactDetail'])->name('contact-detail');
Route::post(env('WEB_URL').'/gettime/slot', [WebAppointmentController::class,'GetTimeSlot']);

// Route::post('/appointment/payment', [WebAppointmentController::class,'AppointmentPayment'])->name('appointment-payment');

