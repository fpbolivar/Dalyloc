<?php

use Carbon\Carbon;
use App\Http\Controllers\Admin\AdminAuthController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\BusinessController;
use App\Http\Controllers\Admin\MenuTypeController;
use App\Http\Controllers\Admin\AllergiesController;
use App\Http\Controllers\Admin\MealController;
use App\Http\Controllers\Admin\UserBusinessController;
use App\Http\Controllers\Admin\WorkoutLevelsController;
use App\Http\Controllers\Admin\ExerciseController;
use App\Http\Controllers\Admin\WorkoutController;
use App\Http\Controllers\Admin\WorkoutExerciesController;

use App\Http\Controllers\Admin\IngredientController;
use App\Http\Controllers\Admin\MealCategoryController;
use App\Http\Controllers\Admin\MealCookwareController;
use App\Http\Controllers\Admin\RecipeController;


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

        //menu type
        Route::get('/menu-type',[MenuTypeController::class,'Index']);
        Route::match(['get','post'],'/add-menu-type',[MenuTypeController::class,'AddMenuType']);
        Route::match(['get','post'],'/edit-menu-type/{id}', [MenuTypeController::class,'EditMenuType']);
        Route::get('/destroy-menu-type/{id}',  [MenuTypeController::class,'DeleteMenuType']);


        //allergies route list 
        Route::get('/allergies',[AllergiesController::class,'index']);
        Route::match(['get','post'],'/add-allergies',[AllergiesController::class,'addAllergy']);
        Route::match(['get','post'],'/edit-allergies/{id}',[AllergiesController::class,'editAllergy']);
        Route::get('/destroy-allergies/{id}',  [AllergiesController::class,'blockAllergy']);

        //meal size route list 
        Route::get('/mealsize',[MealController::class,'index']);
        Route::match(['get','post'],'/add-mealsize',[MealController::class,'addMealSize']);
        Route::match(['get','post'],'/edit-mealsize/{id}',[MealController::class,'editMealSize']);
        Route::get('/destroy-mealsize/{id}',  [MealController::class,'blockMealSize']);

        //user business route list 
        Route::get('/user-business',[UserBusinessController::class,'index']);


        
        // workout levels route list 
        Route::get('/workout-level',[WorkoutLevelsController::class,'index']);
        Route::match(['get','post'],'/add-workout-level',[WorkoutLevelsController::class,'addWorkoutLevel']);


        // exercise  route list 
        Route::get('/exercise',[ExerciseController::class,'index']);
        Route::match(['get','post'],'/add-exercise',[ExerciseController::class,'addExercise']);

        
        // workout  route list 
        Route::get('/workout',[WorkoutController::class,'index']);
        Route::match(['get','post'],'/add-workout',[WorkoutController::class,'addWorkout']);


        
        // workout  route list 
        Route::get('/workout-exercise',[WorkoutExerciesController::class,'index']);
        Route::match(['get','post'],'/add-workout-exercise',[WorkoutExerciesController::class,'addWorkoutExercise']);



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
    });
});
?>