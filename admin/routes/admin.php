<?php

use Carbon\Carbon;
use App\Http\Controllers\Admin\AdminAuthController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\BusinessController;

Route::match(['get','post'],'/login',[AdminAuthController::class,'Login']);
Route::get('logout',[AdminAuthController::class, 'logout']);


Route::group(['middleware' => \App\Http\Middleware\RedirectIfNotAdmin::class],function(){
	Route::group(['namespace'=>'Admin'],function(){
		Route::get('/dashboard',[DashboardController::class,'Dashboard']);
        Route::match(['get','post'],'/update-profile',[DashboardController::class,'UpdateProfile']);
        Route::match(['get','post'],'change-password',[DashboardController::class, 'ChangePassword']);

        //users
        Route::get('/users',[UserController::class,'Index']);
        Route::get('/destroy-user/{id}', [UserController::class,'DeleteUser']);
        Route::get('/user-view/{id}', [UserController::class,'UserView']);

        //business
        Route::get('/business-category',[BusinessController::class,'Index']);
        Route::match(['get','post'],'/add-business-category', [BusinessController::class,'AddBusiness']);
        Route::get('/destroy-business-category/{id}',  [BusinessController::class,'BlockBusiness']);
        Route::match(['get','post'],'/edit-business-category/{id}', [BusinessController::class,'EditBusiness']);
    });
});
?>