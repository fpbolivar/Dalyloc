<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\AdminSetting;
use App\Models\Model\AppointmentPayment;
use App\Models\Model\UserAppointment;

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

    // public function AddCommission(Request $req){
    //     if($req->isMethod('post')){
    //         $this->validate($req, [
    //             'admin_commission' => 'required',
                
    //         ]);
    //         $addCommission  = new  AdminSetting;
    //         $addCommission->admin_commission = $req->admin_commission;
    //         if($addCommission->save()){
    //             return redirect('admin/get-setting')->with('success', 'Commission add successfully.');
    //         }else{
    //             return redirect('admin/get-setting')->with('error', 'Something went wrong.');
    //         }
    //     }else{
    //         return view('admin.adminsetting.addadminsetting');
    //     }
        
    // }

    public function GetSetting(Request $req){
        $updateCommission = AdminSetting::where('is_deleted','0')->where('id','1')->first();
        if($req->isMethod('post')){
            $this->validate($req, [
                'option_value' => 'required',    
            ]);
            $updateCommission->option_value = $req->option_value;
            if($updateCommission->save()){
                return redirect('admin/get-setting')->with('success', 'Commission updated successfully.');
            }else{
                return redirect('admin/get-setting')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.adminsetting.adminsetting',compact('updateCommission'));
        }
        
    }

    public function ExerciseTerms(Request $req){
        $update = AdminSetting::where('is_deleted','0')->where('id','2')->first();
        if($req->isMethod('post')){
            $this->validate($req, [
                'option_value' => 'required',    
            ]);
            $update->option_value = $req->option_value;
            if($update->save()){
                return redirect('admin/exercise-terms')->with('success', 'Exercise  Terms updated successfully.');
            }else{
                return redirect('admin/exercise-terms')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.exerciseterms.exerciseterms',compact('update'));
        }
        
    }

    // public function BlockCommission($id)
    // {
    //     $commission = AdminSetting::find($id);
    //     if ($commission->is_deleted == "0") {
    //         $commission->is_deleted = "1";
    //         $commission->save();
    //         return redirect('admin/get-setting')->with('success', 'Commission Deleted successfully.');
    //     }
    // }

    public function GetTransactions(){
        $data = AppointmentPayment::get();
        return view('admin.adminsetting.transactions',compact('data'));
    }

    //get appoinments
    public function GetAppoinments(){
        $data = UserAppointment::get();
        return view('admin.adminsetting.userappointment',compact('data'));
    }
}
