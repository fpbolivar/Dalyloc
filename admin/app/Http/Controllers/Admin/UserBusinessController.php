<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserBusiness;

class UserBusinessController extends Controller
{
    public function index(){
        //get all user business list 
        $getData = UserBusiness::with('User','UserBusinessCategory')->get();
        // index view  file     
        return view('admin.userbusiness.index',compact('getData'));
    }


}
