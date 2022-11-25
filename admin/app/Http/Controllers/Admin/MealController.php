<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MealSize;

class MealController extends Controller
{
    /**
     * index view file
     */
    public function index(){
        //get meal size list 
        $getData = MealSize::where('is_deleted','0')->get();
        // index view  file     
        return view('admin.meal.index',compact('getData'));
    }

    /**
     *  add meal size 
     */
    public function addMealSize(Request $req){
        
        if($req->isMethod('post')){
            $messages = [
                'meal_description.string' => "Please be maximum 50 characters "
            ];
            $this->validate($req, [
                'meal_description' => 'string|min:1|max:50',
                'meal_name' => 'required',
            ],$messages);
            // add new meal size 
             $addMealSize = new MealSize;
             $addMealSize->name = $req->meal_name;
             $addMealSize->description =$req->meal_description;
             if($addMealSize->save()){
                return redirect('admin/mealsize')->with('success', 'Meal Size created successfully.');
            }else{
                return redirect('admin/mealsize')->with('error', 'Something went wrong.');
            }

        }else{
            // add  meal size form file 
            return view('admin.meal.addmeal');
        }
    }

    /**
     * edit meal size 
     */
    public function editMealSize(Request $req,$id){

        $getMealSize = MealSize::where('id',$id)->where('is_deleted','0')->first();
        if($req->isMethod('post')){
            $messages = [
                'meal_description.string' => "Please be maximum 50 characters "
            ];
            $this->validate($req, [
                'meal_description' => 'string|min:1|max:50',
                'meal_name' => 'required',
            ],$messages);
            // update meal size
            $getMealSize->name = $req->meal_name;
            $getMealSize->description =$req->meal_description;
            if($getMealSize->save()){
                return redirect('admin/mealsize')->with('success', 'Meal Size update successfully.');
            }else{
                return redirect('admin/mealsize')->with('error', 'Something went wrong.');
            }
        }else{
            // add  meal size form file 
            return view('admin.meal.editmeal',compact('getMealSize'));
        }

    }

    /**
     * block meal size 
     */
    public function blockMealSize($id)
    {
        $checkMeal = MealSize::find($id);
        if ($checkMeal->is_deleted == "0") {
            $checkMeal->is_deleted = "1";
            $checkMeal->save();
            return redirect('admin/mealsize')->with('success', 'Meal Size  blocked successfully.');
        }
    }


}
