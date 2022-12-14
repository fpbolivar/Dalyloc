<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use DB, Arr, AWS;
use App\Models\Model\Admin;
use Illuminate\Http\Request;
use App\Models\Model\BusinessCategory;
use App\Models\Model\UserBusiness;
use App\Models\Model\WorkoutLevel;
use App\Models\Model\MealCategory;
use App\Models\Model\PrayerCategory;

class DashboardController extends Controller
{
    /**
     * dashboard view file 
     * get count business category , user business
     * get count workout level , meal category, active user
     */
   public function Dashboard(Request $request)
    { 
        $getUser= User::where(['is_deleted'=>'0'])->get()->count();
        $getBusinessCat =  BusinessCategory::where(['is_deleted'=>'0'])->get()->count();
        $getUserBusines= UserBusiness::get()->count();
        $getWorkoutLevel =  WorkoutLevel::where(['is_deleted'=>'0'])->get()->count();
        $getMealCat =  MealCategory::where(['is_deleted'=>'0'])->get()->count();
        $getPrayerCat =  PrayerCategory::where(['is_deleted'=>'0'])->get()->count();
        return view('admin.dashboard.index',compact('getUser','getBusinessCat','getUserBusines','getWorkoutLevel','getMealCat','getPrayerCat'));
   }

   /**
    * view profile 
    */
   public function ViewProfile(Request $request){
        $admin = Admin::where('id',auth()->guard('admin')->user()->id)->first();
        return view('admin.profile.viewprofile',compact('admin'));
   }

   /**
    * update profile
    */
   public function UpdateProfile(Request $request)
   {
       $admin = Admin::where('id',auth()->guard('admin')->user()->id)->first();
       if ($request->isMethod('post')) {
           $this->validate($request, [
               'name' => 'required',
               'email' => 'required|unique:admins,email,'.$admin->id,
           ]);
          $admin = Admin::find(auth()->guard('admin')->user()->id);
          $admin->name = $request->name;
          $admin->email = $request->email;
          $admin->save();
          return back()->with('success','Profile updated successfully');
       }else{
           return view('admin.profile.profile',compact('admin'));
       }
   }

   
    /**
     * [ChangePassword description]
     * @param Request $req [description]
     */
    public function ChangePassword(Request $req)
    {
        if ($req->isMethod('post')) {
             $this->validate($req,[
                'old_password'=>['required','min:6'],
                'password'=>['required','min:6','confirmed'],
            ]);
            $admin = auth()->guard('admin')->user();
            if(\Hash::check($req->old_password, $admin->password))
            {
                $admin->password = bcrypt($req->password);
                $admin->save();

                return back()->with('success','Password updated successfully');
            } else {
                return back()->with('error','Old password not correct');
            }
        }
        return view('admin.profile.change-password');
    }

}
