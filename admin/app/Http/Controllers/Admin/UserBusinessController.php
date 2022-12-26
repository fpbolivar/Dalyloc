<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserBusiness;
use App\Models\Model\UserBusinessTiming;
use App\Models\Model\UserBusinessService;
use App\Models\Model\BusinessBank;

class UserBusinessController extends Controller
{
    public function Index(){
        //get all user business list 
        $getData = UserBusiness::with('User','UserBusinessCategory')->get();
        //dd($getData);
        // index view  file     
        return view('admin.userbusiness.index',compact('getData'));
    }

    public function BusinessTiming($id){
        $getData = UserBusinessTiming::where('business_id',$id)->get();
        return view('admin.userbusiness.timing',compact('getData'));
    }

    public function BusinessService($id){
        $getData = UserBusinessService::where('business_id',$id)->get();
        return view('admin.userbusiness.service',compact('getData'));
    }
    public function BusinessBank($id){
        $business = UserBusiness::where('id',$id)->first();
        $getData = BusinessBank::where('user_id',$business->user_id)->get();
        return view('admin.userbusiness.bank',compact('getData'));
    }
}
