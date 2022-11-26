<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Ingredient;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class IngredientController extends Controller
{
    public function Index(){
         $getData=Ingredient::where('is_deleted', '0')->get();
        return view('admin.ingredients.index',compact('getData'));
    }

    public function AddIngredient(Request $request, ImageHelper $imageHelper){
        if($request->isMethod('post')){
           
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);

            $ingredient =  new Ingredient;
            $ingredient->name = $request->name;
            if($request->has('image')){
                $path = '/images/ingredients';
                $ingredient->image = $imageHelper->UploadImage($request->image,$path);
            }    
            if($ingredient->save()){
                return redirect('admin/ingredients')->with('success', 'Ingredient created successfully.');
            }else{
                return redirect('admin/ingredients')->with('error', 'Something went wrong.');
            }
            // dd($req->All());
        }else{
            return view('admin.ingredients.addingredient');
        }
        
    }

    public function DeleteIngredient($id)
    {

        $ingredient = Ingredient::find($id);
        $ingredient->is_deleted = "1";
        $ingredient->save();
        return redirect('admin/ingredients')->with('success', 'Ingredient deleted successfully.');
    }

    public function EditIngredient(Request $request, $id, ImageHelper $imageHelper){
        $editIngredient = Ingredient::where('id',$id)->first();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
            //if has image
            if($request->has('image') && $request->image != ''){
                $path = '/images/ingredients';
                $editIngredient->name = $request->name;
                if($editIngredient->image != null){
                    $imagePath = public_path($editIngredient->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editIngredient->image = $imageHelper->UploadImage($request->image,$path);
                if($editIngredient->save()){
                    return redirect('admin/ingredients')->with('success', 'Ingredient updated successfully.');
                }else{
                    return redirect('admin/ingredients')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editIngredient->name = $request->name;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editIngredient->image, 1);
                    $editIngredient->image = null;
                }
                if($editIngredient->save()){
                    return redirect('admin/ingredients')->with('success', 'Ingredient updated successfully.');
                }else{
                    return redirect('admin/ingredients')->with('error', 'Something went wrong.');
                }
            }
        }else{
                return view('admin.ingredients.editingredient',compact('editIngredient')); 
            }
    }



}
