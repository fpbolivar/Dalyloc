<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MealSize;

class MealSizeController extends Controller
{
    /**
     * index view file
     */
    public function Index(){
        //get meal size list 
        $getData = MealSize::where('is_deleted','0')->get();
        // index view  file     
        return view('admin.mealsize.index',compact('getData'));
    }

    /**
     *  add meal size 
     */
    public function AddMealSize(Request $req){
        
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
            return view('admin.mealsize.addmealsize');
        }
    }

    /**
     * edit meal size 
     */
    public function EditMealSize(Request $req,$id){

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
            return view('admin.mealsize.editmealsize',compact('getMealSize'));
        }

    }

    /**
     * block meal size 
     */
    public function BlockMealSize($id)
    {
        $checkMeal = MealSize::find($id);
        if ($checkMeal->is_deleted == "0") {
            $checkMeal->is_deleted = "1";
            $checkMeal->save();
            return redirect('admin/mealsize')->with('success', 'Meal Size  deleted successfully.');
        }
    }


}
