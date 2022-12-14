<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\AdminSetting;

class AdminSettingController extends Controller
{
     /**
     *  index view file 
     */
    public function Index(){
        //get  admin commission list 
        $getData = AdminSetting::where('is_deleted','0')->get();
        // index view  file     
        return view('admin.adminsetting.index',compact('getData'));
    }

    public function AddCommission(Request $req){
        if($req->isMethod('post')){
            $this->validate($req, [
                'admin_commission' => 'required',
                
            ]);
            $addCommission  = new  AdminSetting;
            $addCommission->admin_commission = $req->admin_commission;
            if($addCommission->save()){
                return redirect('admin/get-setting')->with('success', 'Commission add successfully.');
            }else{
                return redirect('admin/get-setting')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.adminsetting.addadminsetting');
        }
        
    }
    public function EditCommission(Request $req, $id){
        $updateCommission = AdminSetting::where('id',$id)->where('is_deleted','0')->first();
        if($req->isMethod('post')){
            $this->validate($req, [
                'admin_commission' => 'required',
                
            ]);
            $updateCommission->admin_commission = $req->admin_commission;
            if($updateCommission->save()){
                return redirect('admin/get-setting')->with('success', 'Commission add successfully.');
            }else{
                return redirect('admin/get-setting')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.adminsetting.editadminsetting',compact('updateCommission'));
        }
        
    }

    public function BlockCommission($id)
    {
        $commission = AdminSetting::find($id);
        if ($commission->is_deleted == "0") {
            $commission->is_deleted = "1";
            $commission->save();
            return redirect('admin/get-setting')->with('success', 'Commission Deleted successfully.');
        }
    }

}
