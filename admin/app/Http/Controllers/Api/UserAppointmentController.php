<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\BusinessCategory;
use App\Models\Model\UserBusiness;
use Validator;
use App\Models\Model\UserBusinessService;
use App\Models\Model\UserBusinessTiming;
use App\Models\User;
use App\Helper\PushHelper;
use App\Models\Model\UserAppointment;

class UserAppointmentController extends Controller
{
    //get all business categories
    public function GetBusinessCategoriesList(){
        $allBusinessCategories = BusinessCategory::where('is_deleted','0')->get();
        if(count($allBusinessCategories) != 0){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allBusinessCategories,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.',
            ]);
        }
    }

    //get user business based on business category id
    public function GetBusinessList(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
            'business_category_id' => 'required|exists:business_category,id',
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
        // $checkUser =  
        $businessCategory = BusinessCategory::where('id',$request->business_category_id)->first();
        $allBusiness = UserBusiness::with('UserBusinessTiming','UserBusinessService')->where('business_category_id',$request->business_category_id)->where('user_id','!=',auth()->user()->id)->where('online_booking','!=','0')->get();
        if(count($allBusiness) != 0){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'business_category' => $businessCategory,
                'business' => $allBusiness,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.',
            ]);
        }
    }

    //appointment business slot
    public function AppointmentBusinessSlot(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
        'appointment_date' => 'required',
        'business_id' => 'required|exists:user_business,id'
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
        $timestamp = strtotime($request->appointment_date);
        $day = date('l', $timestamp);
        //find business timing
        $businessTime = UserBusinessTiming::where('business_id',$request->business_id)->where('day','=',$day)->first();
        $business = UserBusiness::where('id',$request->business_id)->first();
        $businessSlotInterval = $business->slot_interval;
        $bookedSlots = UserAppointment::where('appt_date',$request->appointment_date)->where('business_id',$request->business_id)->get();
        if($businessTime != null){
            if($businessTime->isClosed == 0){
                $startTime = $businessTime->open_time;
                $endTime = $businessTime->close_time;

                $data = [];

                $slot = date('H:i:s', strtotime($startTime.' +'.$businessSlotInterval.' minutes'));
                for ($i=0; $slot <= $endTime; $i++) {             
                    $data[$i] = [ 
                        'start' => date('H:i:s', strtotime($startTime)),
                        // 'end' => date('H:i:s', strtotime($slot)),
                    ];
            
                    $startTime = $slot;
                    $slot = date('H:i:s',strtotime($startTime. ' +'.$businessSlotInterval.' minutes'));
                }

                //check booked slot
                    foreach($data as $i => $slots){
                        $data[$i]['is_booked'] = 0; 
                        foreach($bookedSlots as $bookesSlot){
                            if($bookesSlot->appt_start_time <= $slots['start'] && $slots['start'] < $bookesSlot->appt_end_time){
                               $data[$i]['is_booked'] = 1; 
                            }
                        }
                    }
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'slots' => $data,
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Business Is Closed.',
                ]);
            }
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.',
            ]);
        }
    }

    //get appointment screen with user detail
    public function GetBusinessById(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
            'business_id' => 'required|exists:user_business,id',
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
        $businessDetail = UserBusiness::where('id',$request->business_id)->where('user_id','!=',auth()->user()->id)->first();
        if($businessDetail != null){
            $userDetail = User::where('id',auth()->user()->id)->first();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'businessDetail' => $businessDetail,
                'userDetail' => $userDetail
            ]);
        }else{
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => 'Business Not Found.',
            ]);
        }
    }
    //create user business appointment
    public function CreateUserBusinessAppointment(Request $request, PushHelper $helper){
          // validate
          $validator = Validator::make($request->all(),[
            'business_id' => 'required',
            'business_user_id' => 'required',
            'booked_user_name' => 'required',
            'booked_user_phone_no' => 'required',
            'booked_user_email' => 'required',
            'appt_date' => 'required',
            'appt_start_time' => 'required'
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

        $userBusiness = UserBusiness::where('id',$request->business_id)->where('user_id','!=',auth()->user()->id)->first();
        $userBusinessDeatil = User::where('id',auth()->user()->id)->first();

        if($userBusiness != null){
            $interval = $userBusiness->slot_interval;
            $appt_end_time = date('H:i:s', strtotime($request->appt_start_time.' +'.$interval.' minutes'));
                $createUserAppointment = new UserAppointment;
                $createUserAppointment->booked_user_id = auth()->user()->id;
                $createUserAppointment->booked_user_name = $request->booked_user_name;
                $createUserAppointment->booked_user_phone_no = $request->booked_user_phone_no;
                $createUserAppointment->booked_user_email = $request->booked_user_email;
                $createUserAppointment->booked_user_message = $request->booked_user_message;
                $createUserAppointment->appt_date = $request->appt_date;
                $createUserAppointment->appt_start_time = $request->appt_start_time;
                $createUserAppointment->appt_end_time = $appt_end_time;
                $createUserAppointment->business_id = $userBusiness->id;
                $createUserAppointment->business_user_id = $userBusiness->user_id;
                $title = 'User  Appointment';
                $msg = $request->booked_user_message;
                $business_user_id = $request->business_user_id;
                $notification_source = 'app'; 
                $notification_type = 'Business Meeting';
                    //is_acceptance = 0 means accept all appointments automatically
                    if($userBusiness->is_acceptance==0){
                        $createUserAppointment->appt_status = 'accepted';
                        $deviceToken = $userBusinessDeatil->device_token;
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                        $message = 'Your Appointment Has Been Booked Successfully.';

                    }else{
                        $createUserAppointment->appt_status = 'pending';
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                        $message = 'Your Appointment Has Been Sent To Business Owner. You Will Be Notified Shortly.';
                    }
                    $createUserAppointment->save();
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => $message
                    ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.'
            ]);
        }    
    }
}
