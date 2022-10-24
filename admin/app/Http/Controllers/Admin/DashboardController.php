<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use DB, Arr, AWS;
use App\Models\Model\Admin;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
   public function Dashboard(Request $request)
   {    
      return view('admin.dashboard.index');
   }

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
