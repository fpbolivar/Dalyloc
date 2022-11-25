<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\MenuType;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class MenuTypeController extends Controller
{
    public function Index(){
         $getData=MenuType::where('is_deleted', '0')->get();
        return view('admin.menutype.index',compact('getData'));
    }

    public function AddMenuType(Request $req, ImageHelper $imageHelper){
        if($req->isMethod('post')){
           
            $this->validate($req, [
                'name' => 'required',
                'description' => 'max:80',
                'image' => 'mimes:jpeg,png,jpg'
            ]);

            $menuType  =  new MenuType;
            $menuType->name = $req->name;
            $menuType->description = $req->description;
            if($req->has('image')){
                $path = '/images/menu-type';
                $menuType->image = $imageHelper->UploadImage($req->image,$path);
            }    
            if($menuType->save()){
                return redirect('admin/menu-type')->with('success', 'Menu type created successfully.');
            }else{
                return redirect('admin/menu-type')->with('error', 'Something went wrong.');
            }
            // dd($req->All());
        }else{
            return view('admin.menutype.addmenutype');
        }
        
    }

    public function DeleteMenuType($id)
    {

        $menuType = MenuType::find($id);
        /* if ($menuType->is_deleted == "1") {
            $menuType->is_deleted = "0";
            $menuType->save();
            return redirect('admin/menu-type')->with('success', 'Menu type restored successfully.');
        } else { */
            $menuType->is_deleted = "1";
            $menuType->save();
            return redirect('admin/menu-type')->with('success', 'Menu type deleted successfully.');
        // }
    }

    public function EditMenuType(Request $request, $id, ImageHelper $imageHelper){
        $editMenuType = MenuType::where('id',$id)->first();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'name' => 'required',
                'description' => 'max:80',
                'image' => 'mimes:jpeg,png,jpg'
            ]);
            //if has image
            if($request->has('image') && $request->image != ''){
                $path = '/images/menu-type';
                $editMenuType->name = $request->name;
                $editMenuType->description = $request->description;
                if($editMenuType->image != null){
                    $imagePath = public_path($editMenuType->image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editMenuType->image = $imageHelper->UploadImage($request->image,$path);
                if($editMenuType->save()){
                    return redirect('admin/menu-type')->with('success', 'Menu type updated successfully.');
                }else{
                    return redirect('admin/menu-type')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editMenuType->name = $request->name;
                $editMenuType->description = $request->description;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editMenuType->image, 1);
                    $editMenuType->image = null;
                }
                if($editMenuType->save()){
                    return redirect('admin/menu-type')->with('success', 'Menu type updated successfully.');
                }else{
                    return redirect('admin/menu-type')->with('error', 'Something went wrong.');
                }
            }
        }else{
                return view('admin.menutype.editmenutype',compact('editMenuType')); 
            }
    }



}
