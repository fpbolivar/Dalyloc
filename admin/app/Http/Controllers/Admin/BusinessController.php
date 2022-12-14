<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\BusinessCategory;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;


class BusinessController extends Controller
{
    public function Index(){
        $allBusiness = BusinessCategory::orderBy('business_category_name')->get();
        return view('admin.business.index',compact('allBusiness'));
    }

    public function AddBusiness(Request $request, ImageHelper $imageHelper){
         //if post then add data
         if($request->isMethod('post')){
            $this->validate($request, [
                'business_category_name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
            $addBusiness = new BusinessCategory;
            $addBusiness->business_category_name = $request->business_category_name;
            //if has image
            if($request->has('image')){
                $path = '/images/business';
                $addBusiness->image = $imageHelper->UploadImage($request->image,$path);
            }
            if($addBusiness->save()){
                return redirect('admin/business-category')->with('success', 'Business Category created successfully.');
            }else{
                return redirect('admin/business-category')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.business.addbusiness');
        }
    }

    public function BlockBusiness($id)
    {
        $business = BusinessCategory::find($id);
        if ($business->is_deleted == "1") {
            $business->is_deleted = "0";
            $business->save();
            return redirect('admin/business-category')->with('success', 'Business Category restored successfully.');
        } else {
            $business->is_deleted = "1";
            $business->save();
            return redirect('admin/business-category')->with('success', 'Business Category blocked successfully.');
        }
    }

    public function EditBusiness(Request $request, $id, ImageHelper $imageHelper){
        $editBusiness = BusinessCategory::where('id',$id)->first();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'business_category_name' => 'required',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
              //if has image
              if($request->has('image') && $request->image != ''){
                $path = '/images/business';
                $editBusiness->business_category_name = $request->business_category_name;
                if($editBusiness->image != null){
                    $imagePath = public_path($editBusiness->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editBusiness->image = $imageHelper->UploadImage($request->image,$path);
                if($editBusiness->save()){
                    return redirect('admin/business-category')->with('success', 'Business Category updated successfully.');
                }else{
                    return redirect('admin/business-category')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editBusiness->business_category_name = $request->business_category_name;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editBusiness->image, 1);
                    $editBusiness->image = null;
                }
                if($editBusiness->save()){
                    return redirect('admin/business-category')->with('success', 'Business Category updated successfully.');
                }else{
                    return redirect('admin/business-category')->with('error', 'Something went wrong.');
                }
            }
        }else{
                return view('admin.business.editbusiness',compact('editBusiness')); 
        }
    }
}
