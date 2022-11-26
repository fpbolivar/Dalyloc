<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MealCookware;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class MealCookwareController extends Controller
{
    public function Index(){
         $getData=MealCookware::where('is_deleted', '0')->get();
        return view('admin.meal-cookware.index',compact('getData'));
    }

    public function AddMealCookware(Request $request, ImageHelper $imageHelper){
        if($request->isMethod('post')){
           
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);

            $mealCookware  =  new MealCookware;
            $mealCookware->name = $request->name;
            $mealCookware->description = $request->description;
            if($request->has('image')){
                $path = '/images/meal-cookware';
                $mealCookware->image = $imageHelper->UploadImage($request->image,$path);
            }    
            if($mealCookware->save()){
                return redirect('admin/meal-cookware')->with('success', 'Meal cookware created successfully.');
            }else{
                return redirect('admin/meal-cookware')->with('error', 'Something went wrong.');
            }
            // dd($req->All());
        }else{
            return view('admin.meal-cookware.addmealcookware');
        }
        
    }

    public function DeleteMealCookware($id)
    {

        $mealCookware = MealCookware::find($id);
        $mealCookware->is_deleted = "1";
        $mealCookware->save();
        return redirect('admin/meal-cookware')->with('success', 'Meal cookware deleted successfully.');
    }

    public function EditMealCookware(Request $request, $id, ImageHelper $imageHelper){
        $editMealCookware = MealCookware::where('id',$id)->first();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
            //if has image
            if($request->has('image') && $request->image != ''){
                $path = '/images/meal-cookware';
                $editMealCookware->name = $request->name;
                $editMealCookware->description = $request->description;
                if($editMealCookware->image != null){
                    $imagePath = public_path($editMealCookware->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editMealCookware->image = $imageHelper->UploadImage($request->image,$path);
                if($editMealCookware->save()){
                    return redirect('admin/meal-cookware')->with('success', 'Meal cookware updated successfully.');
                }else{
                    return redirect('admin/meal-cookware')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editMealCookware->name = $request->name;
                $editMealCookware->description = $request->description;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editMealCookware->image, 1);
                    $editMealCookware->image = null;
                }
                if($editMealCookware->save()){
                    return redirect('admin/meal-cookware')->with('success', 'Meal cookware updated successfully.');
                }else{
                    return redirect('admin/meal-cookware')->with('error', 'Something went wrong.');
                }
            }
        }else{
                return view('admin.meal-cookware.editmealcookware',compact('editMealCookware')); 
            }
    }



}
