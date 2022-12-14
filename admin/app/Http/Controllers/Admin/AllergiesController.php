<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;
use App\Models\Model\Allergy;

class AllergiesController extends Controller
{
    /**
     *  index view file 
     */
    public function Index(){
        //get all allergy list 
        $getData = Allergy::where('is_deleted','0')->get();
        // index view  file     
        return view('admin.allergies.index',compact('getData'));
    }

    /**
     *  add allergies  view file 
     */
    public function AddAllergy(Request $req, ImageHelper $imageHelper)
    {

        if($req->isMethod('post')){
            $messages = [
                'image.dimensions' => "Image must be maximum 80x80 ",
                'allergies_name.required' => "The allergy name field is required."
                
            ];
            $this->validate($req, [
                'allergies_name' => 'required',
                'image' => 'mimes:jpeg,png,jpg|dimensions:max_width=80,max_height=80',
              
            ],$messages);
            //add new allergy
            $allergy = new Allergy;
            $allergy->name = $req->allergies_name;
            if($req->has('image')){
                $path = '/images/allergy';
                $allergy->image = $imageHelper->UploadImage($req->image,$path);
            }
            if($allergy->save()){
                return redirect('admin/allergies')->with('success', 'Allergy created successfully.');
            }else{
                return redirect('admin/allergies')->with('error', 'Something went wrong.');
            }

        }else{
        // add allergies view file     
        return view('admin.allergies.addallergies');
        }
    }

    /**
     * edit and update  allergies
     */
    public function EditAllergy(Request $req,$id, ImageHelper $imageHelper)
    {
        $getAllergy = Allergy::where('id',$id)->where('is_deleted','0')->first();
        // update  allergies  with image 
        if($req->isMethod('post')){
            $messages = [
                'image.dimensions' => "Image must be maximum 80x80 ",
                'allergies_name.required' => "The allergy name field is required."
                
            ];
            $this->validate($req, [
                'allergies_name' => 'required|max:50',
                'image' => 'mimes:jpeg,png,jpg|dimensions:max_width=80,max_height=80',
              
            ],$messages);
            if($req->has('image') && $req->image != ''){
                $path = '/images/allergy';
                $getAllergy->name = $req->allergies_name;
                if($getAllergy->image != null){
                    $imagePath = public_path($getAllergy->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $getAllergy->image = $imageHelper->UploadImage($req->image,$path);
                if($getAllergy->save()){
                    return redirect('admin/allergies')->with('success', 'Allergy updated successfully.');
                }else{
                    return redirect('admin/allergies')->with('error', 'Something went wrong.');
                }

            }
            else{
                // update  allergies  without  image 
                $getAllergy->name = $req->allergies_name;
                if($req->isDeleted == 1){
                    $check = $imageHelper->CheckFile($getAllergy->image, 1);
                    $getAllergy->image = null;
                }
                if($getAllergy->save()){
                    return redirect('admin/allergies')->with('success', 'Allergy updated successfully.');
                }else{
                    return redirect('admin/allergies')->with('error', 'Something went wrong.');
                }
            }

        }else{
            // edit allergies view file   
            return view('admin.allergies.editallergies',compact('getAllergy'));
        }

    }

    /**
     * block asllergy
     */
    public function BlockAllergy($id)
    {
        $allergy = allergy::find($id);
        if ($allergy->is_deleted == "0") {
            $allergy->is_deleted = "1";
            $allergy->save();
            return redirect('admin/allergies')->with('success', 'Allergy Deleted successfully.');
        }
    }


}
