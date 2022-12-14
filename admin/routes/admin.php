<?php

use Carbon\Carbon;
use App\Http\Controllers\Admin\AdminAuthController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\BusinessController;
use App\Http\Controllers\Admin\MenuTypeController;
use App\Http\Controllers\Admin\AllergiesController;
use App\Http\Controllers\Admin\MealSizeController;
use App\Http\Controllers\Admin\UserBusinessController;
use App\Http\Controllers\Admin\WorkoutLevelsController;
use App\Http\Controllers\Admin\ExerciseController;
use App\Http\Controllers\Admin\WorkoutController;
use App\Http\Controllers\Admin\WorkoutExerciesController;
use App\Http\Controllers\Admin\PrayerController;
use App\Http\Controllers\Admin\UserPrayerController;
use App\Http\Controllers\Admin\PushNotificationController;
use App\Http\Controllers\Admin\AdminSettingController;

use App\Http\Controllers\Admin\IngredientController;
use App\Http\Controllers\Admin\MealCategoryController;
use App\Http\Controllers\Admin\MealCookwareController;
use App\Http\Controllers\Admin\RecipeController;
use App\Http\Controllers\Admin\SubscriptionPlanController;


Route::match(['get','post'],'/login',[AdminAuthController::class,'Login']);
Route::get('logout',[AdminAuthController::class, 'logout']);


Route::group(['middleware' => \App\Http\Middleware\RedirectIfNotAdmin::class],function(){
	Route::group(['namespace'=>'Admin'],function(){
		Route::get('/dashboard',[DashboardController::class,'Dashboard']);
        Route::match(['get','post'],'/update-profile',[DashboardController::class,'UpdateProfile']);
        Route::match(['get','post'],'change-password',[DashboardController::class, 'ChangePassword']);
        Route::get('/view-profile',[DashboardController::class,'ViewProfile']);

        //subscription plan
        Route::get('/subscription-plan',[SubscriptionPlanController::class,'Index']);
        Route::get('/destroy-subscription-plan/{id}', [SubscriptionPlanController::class,'DeleteSubscriptionPlan']);
        Route::get('/subscription-types/{id}', [SubscriptionPlanController::class,'ViewSubscriptionTypes']);
        Route::match(['post','get'],'/edit-subscription-plan/{id}', [SubscriptionPlanController::class,'EditSubscriptionPlan']);
        Route::get('/destroy-subscription-sub-plan/{id}', [SubscriptionPlanController::class,'DeleteSubscriptionSubPlan']);
        Route::match(['post','get'],'/edit-subscription-sub-plan/{id}', [SubscriptionPlanController::class,'EditSubscriptionSubPlan']);

        //usersupdate-profile
        Route::get('/users',[UserController::class,'Index']);
        Route::get('/destroy-user/{id}', [UserController::class,'DeleteUser']);
        Route::get('/user-view/{id}', [UserController::class,'UserView']);
        Route::get('/excel-export', [UserController::class,'ExcelExport']);
        Route::get('/block-user',[UserController::class,'BlockUser']);

        //business
        Route::get('/business-category',[BusinessController::class,'Index']);
        Route::match(['get','post'],'/add-business-category', [BusinessController::class,'AddBusiness']);
        Route::get('/destroy-business-category/{id}',  [BusinessController::class,'BlockBusiness']);
        Route::match(['get','post'],'/edit-business-category/{id}', [BusinessController::class,'EditBusiness']);

        //menu type
        Route::get('/menu-type',[MenuTypeController::class,'Index']);
        Route::match(['get','post'],'/add-menu-type',[MenuTypeController::class,'AddMenuType']);
        Route::match(['get','post'],'/edit-menu-type/{id}', [MenuTypeController::class,'EditMenuType']);
        Route::get('/destroy-menu-type/{id}',  [MenuTypeController::class,'DeleteMenuType']);


        //allergies route list 
        Route::get('/allergies',[AllergiesController::class,'Index']);
        Route::match(['get','post'],'/add-allergies',[AllergiesController::class,'AddAllergy']);
        Route::match(['get','post'],'/edit-allergies/{id}',[AllergiesController::class,'EditAllergy']);
        Route::get('/destroy-allergies/{id}',  [AllergiesController::class,'BlockAllergy']);

        //meal size route list 
        Route::get('/mealsize',[MealSizeController::class,'Index']);
        Route::match(['get','post'],'/add-mealsize',[MealSizeController::class,'AddMealSize']);
        Route::match(['get','post'],'/edit-mealsize/{id}',[MealSizeController::class,'EditMealSize']);
        Route::get('/destroy-mealsize/{id}',  [MealSizeController::class,'BlockMealSize']);

        //user business route list 
        Route::get('/user-business',[UserBusinessController::class,'Index']);
        Route::get('/business-timing/{id}',[UserBusinessController::class,'BusinessTiming']);
        Route::get('/business-service/{id}',[UserBusinessController::class,'BusinessService']);

        // workout levels route list 
        Route::get('/workout-level',[WorkoutLevelsController::class,'Index']);
        Route::match(['get','post'],'/add-workout-level',[WorkoutLevelsController::class,'AddWorkoutLevel']);
 
        //admin setting  
        Route::get('get-setting',[AdminSettingController::class,'Index']);
        Route::match(['get','post'],'add-commission',[AdminSettingController::class,'AddCommission']);
        Route::match(['get','post'],'edit-commission/{id}',[AdminSettingController::class,'EditCommission']);
        Route::get('/destroy-commission/{id}',  [AdminSettingController::class,'BlockCommission']);

        // exercise  route list 
        Route::get('/exercise',[ExerciseController::class,'Index']);
        Route::match(['get','post'],'/add-exercise',[ExerciseController::class,'AddExercise']);
        
        // workout  route list 
        Route::get('/workout',[WorkoutController::class,'Index']);
        Route::match(['get','post'],'/add-workout',[WorkoutController::class,'AddWorkout']);
        
        // workout  route list 
        Route::get('/workout-exercise',[WorkoutExerciesController::class,'Index']);
        Route::match(['get','post'],'/add-workout-exercise',[WorkoutExerciesController::class,'AddWorkoutExercise']);

        // admin paryer route list 
        Route::get('/prayer',[PrayerController::class,'Index']);
        Route::match(['get','post'],'/edit-prayer/{id}',[PrayerController::class,'EditPrayer']);
        
        // user paryer route list 
        Route::get('/user-prayer',[UserPrayerController::class,'Index']);
        Route::match(['get','post'],'/edit-response/{id}',[UserPrayerController::class,'ResponsePrayer']);
        Route::get('/prayer-category',[UserPrayerController::class,'PrayerCategory']);
        Route::match(['get','post'],'/add-prayer-category',[UserPrayerController::class,'AddPrayerCategory']);
        Route::match(['get','post'],'/edit-prayer-category/{id}',[UserPrayerController::class,'EditPrayerCategory']);
        Route::get('/destroy-prayer-category/{id}',[UserPrayerController::class,'DeletePrayerCategory']);

        //ingredients
        Route::get('/ingredients',[IngredientController::class,'Index']);
        Route::match(['get','post'],'/add-ingredient',[IngredientController::class,'AddIngredient']);
        Route::match(['get','post'],'/edit-ingredient/{id}', [IngredientController::class,'EditIngredient']);
        Route::get('/destroy-ingredient/{id}',  [IngredientController::class,'DeleteIngredient']);

        //meal categories
        Route::get('/meal-categories',[MealCategoryController::class,'Index']);
        Route::match(['get','post'],'/add-meal-category',[MealCategoryController::class,'AddMealCategory']);
        Route::match(['get','post'],'/edit-meal-category/{id}', [MealCategoryController::class,'EditMealCategory']);
        Route::get('/destroy-meal-category/{id}',  [MealCategoryController::class,'DeleteMealCategory']);

        //meal cookware
        Route::get('/meal-cookware',[MealCookwareController::class,'Index']);
        Route::match(['get','post'],'/add-meal-cookware',[MealCookwareController::class,'AddMealCookware']);
        Route::match(['get','post'],'/edit-meal-cookware/{id}', [MealCookwareController::class,'EditMealCookware']);
        Route::get('/destroy-meal-cookware/{id}',  [MealCookwareController::class,'DeleteMealCookware']);

        //recipes
        Route::get('/recipes',[RecipeController::class,'Index']);
        Route::get('/view-recipe/{id}',[RecipeController::class,'ViewRecipe']);
        Route::match(['get','post'],'/add-recipe',[RecipeController::class,'AddRecipe']);
        Route::match(['get','post'],'/edit-recipe/{id}', [RecipeController::class,'EditRecipe']);
        Route::get('/destroy-recipe/{id}',  [RecipeController::class,'DeleteRecipe']);

        //push notification 
        Route::get('/push-notification',[PushNotificationController::class,'Index']);
        Route::get('/get-push-notification',[PushNotificationController::class,'GetPushRecorde']);
        Route::match(['get','post'],'/create-notification', [PushNotificationController::class,'CreateNotification']);
    });
});
?>