<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MealCategory;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class MealCategoryController extends Controller
{
    public function Index(){
         $getData=MealCategory::where('is_deleted', '0')->get();
        return view('admin.meal-categories.index',compact('getData'));
    }

    public function AddMealCategory(Request $request, ImageHelper $imageHelper){
        if($request->isMethod('post')){
           
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);

            $mealCategory =  new MealCategory;
            $mealCategory->name = $request->name;
            if($request->has('image')){
                $path = '/images/meal-categories';
                $mealCategory->image = $imageHelper->UploadImage($request->image,$path);
            }    
            if($mealCategory->save()){
                return redirect('admin/meal-categories')->with('success', 'Meal category created successfully.');
            }else{
                return redirect('admin/meal-categories')->with('error', 'Something went wrong.');
            }
            // dd($req->All());
        }else{
            return view('admin.meal-categories.addmealcategory');
        }
        
    }

    public function DeleteMealCategory($id)
    {

        $mealCategory = MealCategory::find($id);
        $mealCategory->is_deleted = "1";
        $mealCategory->save();
        return redirect('admin/meal-categories')->with('success', 'Meal category deleted successfully.');
    }

    public function EditMealCategory(Request $request, $id, ImageHelper $imageHelper){
        $editMealCategory = MealCategory::where('id',$id)->first();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
            //if has image
            if($request->has('image') && $request->image != ''){
                $path = '/images/meal-categories';
                $editMealCategory->name = $request->name;
                if($editMealCategory->image != null){
                    $imagePath = public_path($editMealCategory->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editMealCategory->image = $imageHelper->UploadImage($request->image,$path);
                if($editMealCategory->save()){
                    return redirect('admin/meal-categories')->with('success', 'Meal category updated successfully.');
                }else{
                    return redirect('admin/meal-categories')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editMealCategory->name = $request->name;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editMealCategory->image, 1);
                    $editMealCategory->image = null;
                }
                if($editMealCategory->save()){
                    return redirect('admin/meal-categories')->with('success', 'Meal category updated successfully.');
                }else{
                    return redirect('admin/meal-categories')->with('error', 'Something went wrong.');
                }
            }
        }else{
                return view('admin.meal-categories.editmealcategory',compact('editMealCategory')); 
            }
    }



}
