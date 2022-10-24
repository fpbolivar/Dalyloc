<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function Index(Request $request)
    {    
        $allUsers = User::get();
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
            return redirect('admin/users')->with('success', 'User blocked successfully.');
        }
    }
}
