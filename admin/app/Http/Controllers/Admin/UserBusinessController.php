<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserBusiness;
use App\Models\Model\UserBusinessTiming;
use App\Models\Model\UserBusinessService;

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


}
