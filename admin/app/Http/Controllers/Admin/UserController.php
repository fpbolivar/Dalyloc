<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

use App\Models\Model\SubscriptionPlans;

class UserController extends Controller
{
    public function Index(Request $request)
    {    
        $allUsers =  User::where(['is_deleted'=>'0'])->get();
       return view('admin.users.index',compact('allUsers'));
    }
    
    public function DeleteUser($id){
        $deleteUser = User::find($id);

        if ($deleteUser->is_deleted == "1") {
            $deleteUser->is_deleted = "0";
            $deleteUser->save();
            return redirect('admin/users')->with('success', 'User restored successfully.');
        } else {
            $deleteUser->is_deleted = "1";
            $deleteUser->save();
            return redirect('admin/block-user')->with('success', 'User blocked successfully.');
        }
    }

    public function UserView($id){
        $user = User::with('UserSubscription')->find($id);
        //dd($user);
        return view('admin.users.detail',compact('user'));

    }

    public function BlockUser(){
        $allUsers =  User::where(['is_deleted'=>'1'])->get();
        return view('admin.users.blockuser',compact('allUsers'));
    }
    // public function ExcelExport(Request $req){
    //     return Excel::download(new UserExport, 'userexcel.xlsx');
    //    }
}
