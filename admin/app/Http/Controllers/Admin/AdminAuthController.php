<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Hash;
use Auth,Exception;


class AdminAuthController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('admin.guest', ['except' => 'logout']);
    }

    /**
     * [adminlogin Admin login]
     * @param  Request $request [description]
     * @return [type]           [description]
     */

    public function Login(Request $request)
    {
    	if ($request->isMethod('post')) {
    		$this->validate($request, [
                'email' => 'required|email',
                'password' => 'required',
            ]);
            // attempt login
            if (auth()->guard('admin')->attempt(['email'=>$request->email,'password'=>$request->password])) {
                return redirect('admin/dashboard');
            }else{
                return back()->with('error','Invalid Username|Password');
            }
    	}else{
    		return view('admin.account.login');
    	}
    }
    
    /**
     * [logout logot users]
     * @return [type] [description]
     */
    public function logout()
    {
        // logout by guard
        auth('admin')->logout();
        // return redirect('admin/login')->with('success','Successfully logout');
        return redirect('admin/login');

    }
}
