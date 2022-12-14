<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserPrayer;
use App\Models\Model\Prayer;
use App\Models\Model\PrayerCategory;
use App\Models\User;
use Tymon\JWTAuth\Facades\JWTAuth;
use Validator;
use Artisan;

class ApiPrayerController extends Controller
{
    /**
      * add new prayer form view file  
      */
    public function Create(Request $request){
            // validate
    	 $validator = Validator::make($request->all(),[
            'prayer_note' => 'required'
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        
        $cate = PrayerCategory::where('id',$request->category_id)->where('is_deleted','0')->first();
        if($cate){
            $createPrayer = new UserPrayer;
            $createPrayer->user_id = auth()->user()->id;
            $createPrayer->category_id = $request->category_id;
            $createPrayer->prayer_title = $cate->prayer_category_name;
            $createPrayer->prayer_note = $request->prayer_note;
            if($createPrayer->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' =>$createPrayer,
                    'message' => 'User Prayer Added Successfully.'

                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'Something Went Wrong.'
                ]);
            }
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Something Went Wrong.'
            ]);

        }
    }

    /**
     * login user get prayer's
     */
    public function GetPrayer(Request $request){
        $getPrayer = UserPrayer::with('PrayerResponse')->where('user_id',auth()->user()->id)->where('is_deleted','0')->orderBy('created_at','DESC')->get();
        if($getPrayer){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$getPrayer,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.'
            ]);
        }

    }

    /**
     * updater prayer 
     */
    public function UpdatePrayer(Request $request){
        $id = $request->id;
        //login user id get
        $updatePrayer = UserPrayer::where('id',$id)->where('user_id',auth()->user()->id)->where('is_deleted','0')->first();
        if($updatePrayer){
            //update prayer status
            $updatePrayer->prayer_status = strtolower($request->prayer_status);
            $updatePrayer->save();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$updatePrayer,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Something Went Wrong.'
            ]);
        }
    }

    /**
     * get admin panel prayer 
     */
    public function GetAdminPrayer(Request $request){
        $getAdminPrayer = Prayer::where('id',1)->where('is_deleted','0')->first();
        if($getAdminPrayer){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$getAdminPrayer,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.'
            ]);
        }
    }
    /**
     * prayer setting  
     */
    public function PrayerSetting(Request $req){
        $user = User::where("id",auth()->user()->id)->first();
        if( $user != null){
            if($req->prayer_notify != null){
                $user->prayer_notify = $req->prayer_notify;
            }
            if($req->prayer_daily_count != null){
                $user->prayer_daily_count = $req->prayer_daily_count;
            }
            if($req->prayer_start_time != null){
                $user->prayer_start_time = $req->prayer_start_time;

            }
            if($req->prayer_end_time != null){
                $user->prayer_end_time = $req->prayer_end_time;
            }
            if($user->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' => $user,
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'data not found.'
                ]);
            }
        }

    }
    public function GetPrayeSetting(){
        $getDetail = User::where('id',auth()->user()->id)->first();
        if($getDetail){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $getDetail,
            ]);
        }
    }
    
    public function cron(){
        Artisan::call('devotional:prayer');
    }


    public function GetPrayerCategory(Request $req){

       $getCategory = PrayerCategory::orderBy('prayer_category_name')->get();
       if($getCategory){
        return response()->json([
            'status' => true,
            'status_code' => true,
            'data' => $getCategory,
        ]);
    }
    }

}
