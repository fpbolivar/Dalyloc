<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MenuType;
use App\Models\Model\MealSize;
use App\Models\Model\Allergy;
use App\Models\Model\MealCookware;
use App\Models\Model\Recipe;
use App\Models\Model\Ingredient;
use App\Models\Model\MealCategory;
use App\Models\Model\UserMealDetail;
use App\Models\Model\UserMealPlan;
use Validator;


class ApiMealController extends Controller
{
    public function GetMenuType(){
        $allMenuType = MenuType::where('is_deleted','0')->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allMenuType,
            ]);
    
    }
    
    public function GetMealSize(){
        $allMealSize = MealSize::where('is_deleted','0')->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allMealSize,
            ]);
    
    }
    
    public function GetAllergies(){
        $allAllergy = Allergy::where('is_deleted','0')->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allAllergy,
            ]);
    
    }

    public function GetMealCookware(){
        $allMealCookware = MealCookware::where('is_deleted','0')->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allMealCookware,
            ]);
    
    }
    
    //get only 4 records of recipes
    public function GetRecipes(){
        $allMealCategorys = MealCategory::where('is_deleted','0')->get();
        $allRecipe = Recipe::where('is_deleted','0')->get();

        foreach($allMealCategorys as $allMealCategory){
            $recipe = array();
            foreach($allRecipe as $key){
                $meal_category_id = explode(",",$key->meal_category_id);
                if(in_array($allMealCategory->id, $meal_category_id)){
                    array_push($recipe,$key);
                }
                //only 4 records ll b sent 
                if(count($recipe) <= 4){
                    $allMealCategory['recipes']=$recipe;
                }
            }
        }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allMealCategorys,
            ]);
    
    }
    
    public function GetRecipesByCategory(Request $request){
            // validate
    	 $validator = Validator::make($request->all(),[
            'meal_category_id' => 'required|exists:meal_categories,id',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $allMealCategory = MealCategory::where('is_deleted','0')->where('id',$request->meal_category_id)->first();
        if($allMealCategory){
            $allRecipe = Recipe::where('is_deleted','0')->get();

            $recipe = array();
            foreach($allRecipe as $key){
                $meal_category_id = explode(",",$key->meal_category_id);
                if(in_array($allMealCategory->id, $meal_category_id)){
                    array_push($recipe,$key);
                }
                    $allMealCategory['recipes']=$recipe;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allMealCategory,
            ]);
    
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.',
            ]);
        }
    }
        
    public function GetSingleRecipe(Request $request){
           // validate
    	 $validator = Validator::make($request->all(),[
            'recipe_id' => 'required|exists:recipes,id',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $recipe = Recipe::with('Ingredients','Instructions')->where('is_deleted','0')->where('id',$request->recipe_id)->first();
        foreach($recipe->ingredients as $key){
            $ingredient_id = $key->ingredient;
            $ingredient = Ingredient::where('id',$ingredient_id)->get();
            $key['ingredient_detail'] = $ingredient;
        }
            $meal_category_ids = explode(",", $recipe->meal_category_id);
            $menutype_ids = explode(",", $recipe->menu_type_id);
            $meal_cookware_ids = explode(",", $recipe->meal_cookware_id);

            $menuType = MenuType::whereIn('id',$menutype_ids)->get();
            $mealCategory = MealCategory::whereIn('id',$meal_category_ids)->get();
            $mealCookware = MealCookware::whereIn('id',$meal_cookware_ids)->get();

            $recipe['menu_type'] = $menuType;
            $recipe['meal_category'] = $mealCategory;
            $recipe['meal_cookware'] = $mealCookware;
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $recipe,
            ]);
    
    }

    //user recipe single
    public function GetUserSingleRecipe(Request $request){
        // validate
      $validator = Validator::make($request->all(),[
         'recipe_id' => 'required|exists:recipes,id',
     ]);
      // if validation fails
       if ($validator->fails()) {
         $error = $validator->messages()->all();
         return response()->json([
             'status' => false,
             'status_code' => true,
             'message' =>$error[0]
         ]);
     }
     $recipe = Recipe::with('Ingredients','Instructions')->where('id',$request->recipe_id)->first();
     foreach($recipe->ingredients as $key){
         $ingredient_id = $key->ingredient;
         $ingredient = Ingredient::where('id',$ingredient_id)->get();
         $key['ingredient_detail'] = $ingredient;
     }
         $meal_category_ids = explode(",", $recipe->meal_category_id);
         $menutype_ids = explode(",", $recipe->menu_type_id);
         $meal_cookware_ids = explode(",", $recipe->meal_cookware_id);

         $menuType = MenuType::whereIn('id',$menutype_ids)->get();
         $mealCategory = MealCategory::whereIn('id',$meal_category_ids)->get();
         $mealCookware = MealCookware::whereIn('id',$meal_cookware_ids)->get();

         $recipe['menu_type'] = $menuType;
         $recipe['meal_category'] = $mealCategory;
         $recipe['meal_cookware'] = $mealCookware;
         return response()->json([
             'status' => true,
             'status_code' => true,
             'data' => $recipe,
         ]);
 
 }
    public function CreateUserMealPlan(Request $request){
        if($request->has('meal_plans') && (!empty($request->meal_plans))){
            foreach($request->meal_plans as $key){
                $createUserMealPlan = new UserMealPlan;
                $createUserMealPlan->user_id = auth()->user()->id;
                $createUserMealPlan->recipe_id = $key['recipes_id'];
                $createUserMealPlan->cooking_date = $key['cooking_date'];
                $createUserMealPlan->save();
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => 'Meal Plan Created Successfully.',
            ]);
    
        }else{
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => 'Please Select a Recipe.',
            ]);
    
        }
    }
    public function GetUserMealPlan(){
        $getDates = UserMealPlan::groupBy('cooking_date')->where('user_id',auth()->user()->id)->orderBy('cooking_date','DESC')->get(['cooking_date']);
        foreach($getDates as $getDate){
            $recipes = UserMealPlan::with('UserMealPlanRecipes')->where('user_id',auth()->user()->id)->where('cooking_date',$getDate->cooking_date)->get();
            $getDate['recipes'] = $recipes;
        }

        return response()->json([
            'status' => true,
            'status_code' => true,
            'user_meal_plan' => $getDates,
        ]);
 
    }
    public function CreateUserMealDetail(Request $request){
        $userMealDetail = UserMealDetail::where('user_id',auth()->user()->id)->first();
        if($userMealDetail){
            //update
            if($request->has('menu_type_id')){
                $userMealDetail->menu_type_id = $request->menu_type_id;
            }
            elseif($request->has('allergies_id') && (!empty($request->allergies_id))){
                $userMealDetail->allergies_id = implode(",",$request->allergies_id);
            }
            elseif($request->has('allergies_id') && (empty($request->allergies_id))){
                $userMealDetail->allergies_id = null;
            }
            elseif($request->has('dislikes_id') && (!empty($request->dislikes_id))){
                $userMealDetail->dislikes_id = implode(",",$request->dislikes_id);
            }
            elseif($request->has('dislikes_id') && (empty($request->dislikes_id))){
                $userMealDetail->dislikes_id = null;
            }
            elseif($request->has('meal_size_id')){
                $userMealDetail->meal_size_id = $request->meal_size_id;
            }
            if($userMealDetail->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Success',
                    '$userMealDetail' => $userMealDetail
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.',
                ]);
            }
        }else{
            //create
            $createUserMealDetail = new UserMealDetail;
            $createUserMealDetail->user_id = auth()->user()->id;
            if($request->has('menu_type_id')){
                $createUserMealDetail->menu_type_id = $request->menu_type_id;
                if($createUserMealDetail->save()){
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'Success',
                        'data' => $userMealDetail
                    ]);
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Something Went Wrong.',
                    ]);
                }
            }
        }
    }

    //get user meal detail
    public function GetUserMealDetail(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'type' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $userMealDetail = UserMealDetail::where('user_id',auth()->user()->id)->first();
        if($userMealDetail)
        {
            //return all menu type if type diet
        if($request->type == 'diet'){
            $menu_type_id = $userMealDetail->menu_type_id;
            $allmenuTypes = MenuType::where('is_deleted','0')->get();
            foreach($allmenuTypes as $allmenuType){
                if($allmenuType->id == $menu_type_id){
                    $allmenuType['user_selected'] = 1;
                }else{
                    $allmenuType['user_selected'] = 0;
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allmenuTypes
            ]);
        }
        //return all meal size if type mealsize
        elseif($request->type == 'mealsize'){
            $meal_size_id = $userMealDetail->meal_size_id;
            $allMealSizes = MealSize::where('is_deleted','0')->get();
            foreach($allMealSizes as $allMealSize){
                if($allMealSize->id == $meal_size_id){
                    $allMealSize['user_selected'] = 1;
                }else{
                    $allMealSize['user_selected'] = 0;
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allMealSizes
            ]);

        }

        //return all allergies if type allergies
        elseif($request->type == 'allergies'){
            $allergies_id = $userMealDetail->allergies_id;
            $allergies_id_arr = explode(",",$allergies_id);
            $allAllergies = Allergy::where('is_deleted','0')->get();
            foreach($allAllergies as $allAllergy){
                if(in_array($allAllergy->id, $allergies_id_arr)){
                    $allAllergy['user_selected'] = 1;
                }else{
                    $allAllergy['user_selected'] = 0;
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allAllergies
            ]);

        }

           //return all dislike if type dislike
           elseif($request->type == 'dislike'){
            $dislike_id = $userMealDetail->dislikes_id;
            $alldislike_id_arr = explode(",",$dislike_id);
            $alldislikes = Allergy::where('is_deleted','0')->get();
            foreach($alldislikes as $alldislike){
                if(in_array($alldislike->id, $alldislike_id_arr)){
                    $alldislike['user_selected'] = 1;
                }else{
                    $alldislike['user_selected'] = 0;
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$alldislikes
            ]);

        }
        }else{
            //return all menu type if type diet
        if($request->type == 'diet'){
            $allmenuTypes = MenuType::where('is_deleted','0')->get();
            foreach($allmenuTypes as $allmenuType){
                    $allmenuType['user_selected'] = 0;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allmenuTypes
            ]);
        }
        //return all meal size if type mealsize
        elseif($request->type == 'mealsize'){
            $allMealSizes = MealSize::where('is_deleted','0')->get();
            foreach($allMealSizes as $allMealSize){
 
                    $allMealSize['user_selected'] = 0;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allMealSizes
            ]);

        }

        //return all allergies if type allergies
        elseif($request->type == 'allergies'){
            $allAllergies = Allergy::where('is_deleted','0')->get();
            foreach($allAllergies as $allAllergy){
                    $allAllergy['user_selected'] = 0;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$allAllergies
            ]);

        }

           //return all dislike if type dislike
           elseif($request->type == 'dislike'){
            $alldislikes = Allergy::where('is_deleted','0')->get();
            foreach($alldislikes as $alldislike){
                    $alldislike['user_selected'] = 0;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$alldislikes
            ]);

        }
        }
        
    }
    
    public function GetSelectedMealIds(){
                $userMealDetail = UserMealDetail::where('user_id',auth()->user()->id)->first();
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' =>$userMealDetail
                ]);
    
    }
    public function GetNotificationSetting(Request $request){
        $userMealDetail = UserMealDetail::where('user_id',auth()->user()->id)->first();
        if($request->has('is_notification')){
            //update
            $userMealDetail->is_notification = $request->is_notification;
            if($userMealDetail->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' =>$userMealDetail
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'Something Went Wrong.'
                ]);
            }
        }else{
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$userMealDetail
            ]);
        }
        
    }
    
    public function AddMealSetting(Request $req){
        $user = UserMealDetail::where("user_id",auth()->user()->id)->first();
        if($user != null){
            if($req->meal_notify != null){
                $user->meal_notify = $req->meal_notify;
            }
            if($req->meal_daily_count != null){
                $user->meal_daily_count = $req->meal_daily_count;
            }
            if($req->meal_start_time != null){
                $user->meal_start_time = $req->meal_start_time;

            }
            if($req->meal_end_time != null){
                $user->meal_end_time = $req->meal_end_time;
            }
            if($user->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' => $user,
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'data not found.'
                ]);
            }
        }
    }

    public function GetMealSetting(){
        $getMealDetail = UserMealDetail::where("user_id",auth()->user()->id)->first();
        if($getMealDetail){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $getMealDetail,
            ]);
        }

    }


    public function cron(){
        \Artisan::call('user:meal');
    }
}
