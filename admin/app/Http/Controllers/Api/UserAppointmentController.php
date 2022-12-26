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
//use App\Helper\PushHelper;
use App\Models\Model\UserAppointment;
use App\Models\Model\CreateTask;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Stripe\Stripe;
use App\Helper\SubscriptionHelper;
use App\Models\Model\AppointmentPayment;
use App\Helper\AppointmentPushHelper;
use App\Models\Model\NotificationLogRecord;
use App\Models\Model\AdminSetting;
use App\Models\Model\UserAppointmentRating;
use DB;

class UserAppointmentController extends Controller
{

    private $stripe;
    public function __construct()
    {
        $this->stripe = new StripeClient(env('STRIPE_SECRET_KEY'));
    }
    //notification log record
    private function NotificationLogRecord($sendBy,$sendTo,$userId,$businessOwnerId,$businessId,$eventId,$title,$message,$notification_type,$notification_source){
        	$data = array( 'notification_type' => $notification_type );
        	$notificationLogSave = new NotificationLogRecord;
			$notificationLogSave->send_by = $sendBy;
			$notificationLogSave->send_to = $sendTo;
			$notificationLogSave->user_id = $userId;
			if($sendBy == 'User'){
			    $notificationLogSave->send_by_id = $userId;
			    $notificationLogSave->send_to_id = $businessOwnerId;
			}
			elseif($sendBy == 'Business Owner'){
			     $notificationLogSave->send_by_id = $businessOwnerId;
			    $notificationLogSave->send_to_id = $userId;
			}
			$notificationLogSave->business_owner_id = $businessOwnerId;
			$notificationLogSave->business_id = $businessId;
			$notificationLogSave->event_id = $eventId;
			$notificationLogSave->notification_title = $title;
			$notificationLogSave->notification_description = $message;
			$notificationLogSave->notification_type = $notification_type;
			$notificationLogSave->data_payload = json_encode($data);
			$notificationLogSave->notification_date = date("Y-m-d H:i:s");
			$notificationLogSave->notification_source = $notification_source;
			$notificationLogSave->status = 'TRUE';
			$notificationLogSave->save();
    }
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
         
        $businessCategory = BusinessCategory::where('id',$request->business_category_id)->first();
        $allBusiness = UserBusiness::with('UserBusinessTiming','UserBusinessService')->where('business_category_id',$request->business_category_id)->where('user_id','!=',auth()->user()->id)->where('online_booking','!=','0')->where('is_deleted','0')->get();
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

    //get specific service detail
    public function GetServiceDetailById(Request $request){
             // validate
             $validator = Validator::make($request->all(),[
                'service_id' => 'required',
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
        $service = UserBusinessService::where('id',$request->service_id)->first();
        if($service){
            $userBusiness = UserBusiness::where('id',$service->business_id)->first();
            $advance = 0;
            if($userBusiness->is_active_payment == 1)
            {
                if($service->deposit_percentage != null && $service->deposit_percentage != 0){
                    $totalServicePrice = $service->service_price;
                    $advance = $totalServicePrice * $service->deposit_percentage / 100;
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'advance' =>$advance,
                ]);
        }else{
            return response()->json([
            'status' => false,
            'status_code' => true,
            'message' =>'Data Not Found.',
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
        $bookedSlots = UserAppointment::where('appt_date',$request->appointment_date)->where('business_id',$request->business_id)->where('appt_status','!=','cancelled')->get();
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
                        foreach($bookedSlots as $bookedSlot){
                            if($bookedSlot->appt_start_time <= $slots['start'] && $slots['start'] < $bookedSlot->appt_end_time){
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
                'message' => 'Business Timing Is Not Added Yet By The Business Owner.',
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
       //get all user business services
      public function GetBusinessOwnerService(Request $request){
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
        $userBusinessService = UserBusinessService::where('user_id','!=',auth()->user()->id)->where('business_id',$request->business_id)->where('is_deleted','0')->get();
        if(count($userBusinessService) != 0){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $userBusinessService,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Services Not Found.',
            ]);
        }

    }

    //get business services by business id
    public function GetAdvanceAmt(Request $request){
             // validate
             $validator = Validator::make($request->all(),[
                'business_id' => 'required',
                'service_id' => 'required'
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
            //check service payment is active or not(is_active_payment = 1 means active)
                if($userBusiness->is_active_payment == 1){
                    $serviceDetail = UserBusinessService::where('id',$request->service_id)->where('is_deleted','0')->first();
                    if($serviceDetail){
                        $total_service_price = $serviceDetail->service_price;
                        $deposit_percentage = $serviceDetail->deposit_percentage;
                        $pay_advance = $total_service_price * $deposit_percentage /100;
                        return response()->json([
                            'status' => false,
                            'status_code' => true,
                            'advance' => $pay_advance
                        ]);
                    }else{
                        return response()->json([
                            'status' => false,
                            'status_code' => true,
                            'message' => 'Selected Service Is Blocked By Business Owner. Please Select another one.'
                        ]);
                    }
                }
    }

    //create user business appointment
    public function CreateUserBusinessAppointment(Request $request, AppointmentPushHelper $helper){
          // validate
          $validator = Validator::make($request->all(),[
            'business_id' => 'required',
            'business_user_id' => 'required',
            'booked_user_name' => 'required',
            'booked_user_phone_no' => 'required',
            'booked_user_email' => 'required',
            'appt_date' => 'required',
            'appt_start_time' => 'required',
            't_id' => 'required',
            'service_id' => 'required',
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
        $userBusinessDeatil = User::where('id',$userBusiness->user_id)->first();
        if($userBusinessDeatil == null){
             return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Business Owner Not Found.'
                    ]);
        }
        $user = User::where('id',auth()->user()->id)->first();
        $service = UserBusinessService::where('id',$request->service_id)->first();
        $serviceDetail = [];
        $test=[];
        $test['id'] = $service->id;
        $test['name'] = $service->service_name;
        $test['service_price'] = $service->service_price;
        $test['deposit_percentage'] = $service->deposit_percentage;
        $test['service_time'] = $service->service_time;        
         array_push($serviceDetail,$test);
         $output = array_map(function($element) {
          return (object) $element;
          }, $serviceDetail);
        //check slot is already booked
        $bookedSlots = UserAppointment::where('appt_date',$request->appt_date)->where('business_id',$request->business_id)->where('appt_status','!=','cancelled')->get();
        if(count($bookedSlots) != 0){
            foreach($bookedSlots as $bookesSlot){
                if($bookesSlot->appt_start_time <= $request->appt_start_time && $request->appt_start_time < $bookesSlot->appt_end_time){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Selected Slot is already booked. Please choose another one.'
                    ]);
                }
            }
        }


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
                $createUserAppointment->service_detail = $serviceDetail;
                $createUserAppointment->appt_from = 'app';
                $title = 'User Appointment';
                $msg = 'You have a new Appoinment';
                $business_user_id = $request->business_user_id;
                $notification_source = 'app'; 
                $notification_type = 'user_appointment';
                          
                    //is_acceptance = 0 means accept all appointments automatically
                    if($userBusiness->is_acceptance==0){
                        $createUserAppointment->appt_status = 'accepted';
                        $deviceToken = $userBusinessDeatil->device_token;
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                              //if payment active and advance payment 0 then set full payment in pending
                              if($userBusiness->is_active_payment == 1){
                                $servicePrice = $service->service_price;
                                $createUserAppointment->pending_payment = $servicePrice;
                                $createUserAppointment->total_payment = $servicePrice;
                                $createUserAppointment->payout_status = 'unpaid';
                                $adminpercent = AdminSetting::where('id',1)->first();
                                if($adminpercent){
                                        $createUserAppointment->admin_commission_percentage = $adminpercent->option_value;
                                        $totalServicePrice = $service->service_price;
                                        $adminCommission = $totalServicePrice * $adminpercent->option_value / 100;
                                        $createUserAppointment->admin_commission_amt = $adminCommission;
                                        }
                                $message = 'Your Appointment Has Been Booked Successfully for $' .$servicePrice;
                            }else{
                                $message = 'Your Appointment Has Been Booked Successfully.';
                            }
                    }else{
                        $createUserAppointment->appt_status = 'pending';
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                          //if payment active and advance payment 0 then set full payment in pending
                          if($userBusiness->is_active_payment == 1){
                            $servicePrice = $service->service_price;
                            $createUserAppointment->pending_payment = $servicePrice;
                            $createUserAppointment->total_payment = $servicePrice;
                            $createUserAppointment->payout_status = 'unpaid';
                            $message = 'Your Appointment for $'.$servicePrice. ' Has Been Sent To Business Owner. You Will Be Notified Shortly.';
                        }else{
                            $message = 'Your Appointment Has Been Sent To Business Owner. You Will Be Notified Shortly.';
                        }
                    }
                    $createUserAppointment->save();
                    //create task for booked user
                    $createTask = new CreateTask;
                    $createTask->user_id = auth()->user()->id;
                    $createTask->t_Id = $request->t_id;
                    $createTask->email = $createUserAppointment->booked_user_email;
                    $createTask->task_name = "Appointment";
                    $createTask->task_type = "user_appointment";
                    $createTask->note = $createUserAppointment->booked_user_message;
                    $createTask->date_format = $createUserAppointment->appt_date;
                    $createTask->start_task_time = $createUserAppointment->appt_start_time;
                    $createTask->end_task_time = $createUserAppointment->appt_end_time; 
                    $createTask->business_appt_id = $createUserAppointment->id; 
                    $createTask->save();

                    //create task for business owner
                    $createTask = new CreateTask;
                    $createTask->user_id = $createUserAppointment->business_user_id;
                    $createTask->t_Id = $request->t_id;
                    $createTask->email = $userBusiness->business_email;
                    $createTask->task_name = "Business Appointment";
                    $createTask->task_type = "business_appointment";
                    $createTask->note = $createUserAppointment->booked_user_message;
                    $createTask->date_format = $createUserAppointment->appt_date;
                    $createTask->start_task_time = $createUserAppointment->appt_start_time;
                    $createTask->end_task_time = $createUserAppointment->appt_end_time; 
                    $createTask->business_appt_id = $createUserAppointment->id; 
                    $createTask->save();
                    
                    $booked_user_id = $createUserAppointment->booked_user_id;
                    $business_owner_id = $createUserAppointment->business_user_id;
                    $business_id =  $createUserAppointment->business_id;
                    $event_id = $createUserAppointment->id;
                    $notification_type = 'user_appointment';
                    $notification_source = 'app'; 
                    $history = $this->NotificationLogRecord("User","Business Owner",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
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

     //create user business appointment with advance payment
    public function CreateUserBusinessAppointmentWithAdvance(Request $request, AppointmentPushHelper $helper){
          // validate
          $validator = Validator::make($request->all(),[
            'business_id' => 'required',
            'business_user_id' => 'required',
            'booked_user_name' => 'required',
            'booked_user_phone_no' => 'required',
            'booked_user_email' => 'required',
            'appt_date' => 'required',
            'appt_start_time' => 'required',
            't_id' => 'required',
            'service_id' => 'required',
            'card_number' => 'required',
            'exp_month' => 'required',
            'exp_year' => 'required',
            'cvc' => 'required'
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }

        $userBusiness = UserBusiness::where('id',$request->business_id)->where('user_id','!=',auth()->user()->id)->first();
        $userBusinessDeatil = User::where('id',$userBusiness->user_id)->first();
        $user = User::where('id',auth()->user()->id)->first();
        $service = UserBusinessService::where('id',$request->service_id)->first();
        $serviceDetail = [];
        $test=[];
        $test['id'] = $service->id;
        $test['name'] = $service->service_name;
        $test['service_price'] = $service->service_price;
        $test['deposit_percentage'] = $service->deposit_percentage;
        $test['service_time'] = $service->service_time;        
         array_push($serviceDetail,$test);
         $output = array_map(function($element) {
          return (object) $element;
          }, $serviceDetail);
        //check slot is already booked
        $bookedSlots = UserAppointment::where('appt_date',$request->appt_date)->where('business_id',$request->business_id)->where('appt_status','!=','cancelled')->get();
        if(count($bookedSlots) != 0){
            foreach($bookedSlots as $bookesSlot){
                if($bookesSlot->appt_start_time <= $request->appt_start_time && $request->appt_start_time < $bookesSlot->appt_end_time){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Selected Slot is already booked. Please choose another one.'
                    ]);
                }
            }
        }

        if($userBusiness != null){
            $totalServicePrice = $service->service_price;
            $pendingAmount = $totalServicePrice - $request->advance_payment;
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
                $createUserAppointment->appt_from = 'app';
                $title = 'User Appointment';
                $msg = 'You have a new Appoinment';
                $business_user_id = $request->business_user_id;
                $notification_source = 'app'; 
                $notification_type = 'user_appointment';
                $createUserAppointment->pending_payment = $pendingAmount;
                $createUserAppointment->amount_paid = $request->advance_payment;
                $createUserAppointment->service_detail = $serviceDetail;
                $createUserAppointment->total_payment = $totalServicePrice;
                $createUserAppointment->payout_status = 'unpaid';
                   $adminpercent = AdminSetting::where('id',1)->first();
                                if($adminpercent){
                                        $createUserAppointment->admin_commission_percentage = $adminpercent->option_value;
                                        $totalServicePrice = $service->service_price;
                                        $adminCommission = $totalServicePrice * $adminpercent->option_value / 100;
                                        $createUserAppointment->admin_commission_amt = $adminCommission;
                                        }
                $token = $this->createToken($request);
                if (!empty($token['error'])) {
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'error' => $token['error'],
        
                    ]);
                }
                if (empty($token['id'])) {
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'message'=>'Payment failed.',
                        'error' => 'failed',
        
                    ]);
                }
                if($token['id'] && $request->advance_payment) {
                    $charge =$this->createCharge($token['id'], $request->advance_payment);
                    if($charge->id != null){
                    //is_acceptance = 0 means accept all appointments automatically
                    if($userBusiness->is_acceptance==0){
                        $createUserAppointment->appt_status = 'accepted';
                        $deviceToken = $userBusinessDeatil->device_token;
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                        $message = 'Your Appointment Has Been Booked Successfully with advance payment $'.$request->advance_payment. '. Pending Payment is $'.$pendingAmount;

                    }else{
                        $createUserAppointment->appt_status = 'pending';
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                        $message = 'Your Appointment Has Been Sent To Business Owner with payment $'.$request->advance_payment. '. You Will Be Notified Shortly And your pending Payment is $'.$pendingAmount;
                    }
                        $createUserAppointment->save();
                        $userAdvancePayment = new AppointmentPayment;
                        $userAdvancePayment->user_booked_id = auth()->user()->id;
                        $userAdvancePayment->business_id  = $request->business_id;
                        $userAdvancePayment->appt_id  = $createUserAppointment->id;
                        $userAdvancePayment->business_user_id  = $userBusiness->user_id;
                        $userAdvancePayment->payment_status  = 'partial';
                        $userAdvancePayment->payment_method  = 'online';
                        $userAdvancePayment->stripe_transaction_id  = $charge->id;
                        $userAdvancePayment->amount_paid  = $request->advance_payment;
                        $userAdvancePayment->save();

                    }else{
                        return response()->json([
                            'status' => false,
                            'status_code' => false,
                            'message'=>'Error.',
                        ]);
                    }
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'message'=>'Token or advance payment is not found.',
                    ]);
                }
                  
                    //create task for booked user
                    $createTask = new CreateTask;
                    $createTask->user_id = auth()->user()->id;
                    $createTask->t_Id = $request->t_id;
                    $createTask->email = $createUserAppointment->booked_user_email;
                    $createTask->task_name = "Appointment";
                    $createTask->task_type = "user_appointment";
                    $createTask->note = $createUserAppointment->booked_user_message;
                    $createTask->date_format = $createUserAppointment->appt_date;
                    $createTask->start_task_time = $createUserAppointment->appt_start_time;
                    $createTask->end_task_time = $createUserAppointment->appt_end_time; 
                    $createTask->business_appt_id = $createUserAppointment->id; 
                    $createTask->save();

                    //create task for business owner
                    $createTask = new CreateTask;
                    $createTask->user_id = $createUserAppointment->business_user_id;
                    $createTask->t_Id = $request->t_id;
                    $createTask->email = $userBusiness->business_email;
                    $createTask->task_name = "Business Appointment";
                    $createTask->task_type = "business_appointment";
                    $createTask->note = $createUserAppointment->booked_user_message;
                    $createTask->date_format = $createUserAppointment->appt_date;
                    $createTask->start_task_time = $createUserAppointment->appt_start_time;
                    $createTask->end_task_time = $createUserAppointment->appt_end_time; 
                    $createTask->business_appt_id = $createUserAppointment->id; 
                    $createTask->save();
                    
                    $booked_user_id = $createUserAppointment->booked_user_id;
                    $business_owner_id = $createUserAppointment->business_user_id;
                    $business_id =  $createUserAppointment->business_id;
                    $event_id = $createUserAppointment->id;
                    $notification_type = 'user_appointment';
                    $notification_source = 'app'; 
                    $history = $this->NotificationLogRecord("User","Business Owner",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
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
    
    //pay advance deposit
    public function AppointmentAdvancePayment(Request $request, SubscriptionHelper $helper){
        $validator = Validator::make($request->all(),[
            'advance_amt' => 'required',
            'business_id' => 'required',
            'service_id' => 'required',
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
        $userBusiness = UserBusiness::where('id',$request->business_id)->where('user_id','!=',auth()->user()->id)->first();
        $serviceDetail = UserBusinessService::where('id',$request->service_id)->where('is_deleted','0')->first();
        $total_service_price = $serviceDetail->service_price;
        $pending_price = $total_service_price - $request->advance_amt;
        //check plan
        try {
            // get customer id
            $user = User::select('stripe_customer_id')->whereid(auth()->user()->id)->first();
            if(is_null($user)){
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "Invalid User."
                ]);
            }
            $customerId = $user->stripe_customer_id;
            if($customerId == null){
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'response_code'=> 404,
                    'message' => 'Please Add Payment Method.'
                ]);
            }else{
            
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                 $cardData = $stripe->customers->allSources(
                    $user->stripe_customer_id,
                    ['object' => 'card']
                  );
                 if(empty($cardData['data'])) {
                     return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'response_code'=> 404,
                        'message' => 'Please Add Payment Method.'
                    ]);
                 }
                 $advancePrice = $request->advance_amt;
                if($advancePrice == 0){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Invalid Price.'
                    ]);
                }
                $cardId = $cardData['data'][0]->id;
                if($cardId){
                    $token = $this->createToken($cardId, $advancePrice, $user->stripe_customer_id);
	    	    $startDate = date('Y-m-d');
                $userAdvancePayment = new AppointmentPayment;
                $userAdvancePayment->user_booked_id = auth()->user()->id;
                $userAdvancePayment->business_id  = $request->business_id;
                $userAdvancePayment->business_user_id  = $userBusiness->user_id;
                $userAdvancePayment->payment_status  = 'partial';
                $userAdvancePayment->payment_method  = 'online';
                $userAdvancePayment->advance_transaction_id  = $charge->id;
                $userAdvancePayment->advance_payment  = $advancePrice;
                $userAdvancePayment->pending_payment = $pending_price;
                $userAdvancePayment->service_id  =  $request->service_id;
                $userAdvancePayment->service_price  =  $total_service_price;
                if($userAdvancePayment->save()){
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'success',
                        'data'=> $userAdvancePayment
                    ]);   
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => "something went wrong."
                    ]);
                }
                }

    
        }
        }catch (\Exception $e) {
           
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e
            ]);
        }
    }

    // public function EphemeralKey(Request $req)
    // {    
    //     $user = User::whereid(auth()->user()->id)->first();   
    //     $user_id = auth()->user()->id;
    //     $user_email = auth()->user()->email;
    //     $customer_id = auth()->user()->stripe_customer_id;
    //     $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));

    //     if(!empty($customer_id)){
    //         $key = $stripe->ephemeralKeys->create(
    //             [ 'customer' => $customer_id],
    //             ['stripe_version' => '2022-08-01']);

    //         return response()->json([
    //             'status' => true,
    //             'status_code' => true,
    //             'key' => $key,
    //             'customer' => $customer_id
    //         ]);
    //     }else{
    //         $customer = $stripe->customers->create([
    //             'phone' => $user->phone_no,
    //         ]);
    //         $key = $stripe->ephemeralKeys->create(
    //             [ 'customer' => $customer['id']],
    //             ['stripe_version' => '2022-08-01']);
    //         $user->stripe_customer_id = $customer->id;
    //         $user->save();
    //         return response()->json([
    //             'status' => true,
    //             'status_code' => true,
    //             'key' => $key,
    //             'customer' => $customer['id']
    //         ]);
    //     }
    //     // return $key;
    // }
    private function createToken($cardData)
    {
        $token = null;
        try {
            $token = $this->stripe->tokens->create([
                'card' => [
                    'number' => $cardData['card_number'],
                    'exp_month' => $cardData['exp_month'],
                    'exp_year' => $cardData['exp_year'],
                    'cvc' => $cardData['cvc']
                ]
            ]);
        } catch (CardException $e) {
            $token['error'] = $e->getError()->message;
        } catch (Exception $e) {
            $token['error'] = $e->getMessage();
        }
        return $token;
    }
    private function createCharge($tokenId, $amount)
    {
        $charge = null;
      
        try {
            $charge = $this->stripe->charges->create([
                'amount' => $amount * 100,
                'currency' => 'usd',
                'source' => $tokenId,
                'description' => 'Test payment',
            ]);
        } catch (Exception $e) {
            $charge['error'] = $e->getMessage();
        }
        
      
        return $charge;
    }

    //get user appointments list
    public function GetUserAppointmentsList(){
        $list = UserAppointment::where('booked_user_id',auth()->user()->id)->orderby('created_at', 'desc')->get();
        foreach($list as $key){
                    $getBusiness = UserBusiness::where('id',$key->business_id)->where('user_id','!=',auth()->user()->id)->first();
                    $key['business_name'] = $getBusiness->business_name;
        }
         if($list){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'success',
                    'data'=> $list
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
      //get all business appointment detail
    public function GetUserAppointmentDetailById(Request $request){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('booked_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
         if($data){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'success',
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
    //cancel user business appointment
    public function CancelUserAppointment(Request $request, AppointmentPushHelper $helper){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('booked_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
         if($data){
             if($data->appt_status == 'cancelled'){
                  return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "Appointment Is Already Cancelled."
                ]);
             }
             $delete = CreateTask::where('business_appt_id',$request->appt_id)->delete();
             $data->appt_status = 'cancelled';
             $userBusiness = UserBusiness::where('id',$data->business_id)->where('user_id','!=',auth()->user()->id)->first();
             if($userBusiness){
                $userBusinessDeatil = User::where('id',$userBusiness->user_id)->first();
                if($userBusinessDeatil){
                    //send notification to business owner
                    $title = 'Cancel User Appointment';
                    $msg = 'User has been cancelled the Appoinment';
                    $business_user_id = $data->business_user_id;
                    $notification_source = 'app'; 
                    $notification_type = 'user_appointment';
                        //is_acceptance = 0 means accept all appointments automatically
                            $deviceToken = $userBusinessDeatil->device_token;
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                            }
                                $message = 'Your Appointment Has Been Cancelled Successfully.';
                }
             }
     
             $data->save();
             $booked_user_id = $data->booked_user_id;
                                $business_owner_id = $data->business_user_id;
                                $business_id =  $data->business_id;
                                $event_id = $data->id;
                                $notification_type = 'user_appointment';
                                $notification_source = 'app'; 
                    $history = $this->NotificationLogRecord("User","Business Owner",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Appointment Has Been Cancelled Successfully.',
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
    //reschedule user appointment
     public function RescheduleUserAppointment(Request $request,AppointmentPushHelper $helper){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
            'appt_date' => 'required',
            'appt_start_time' => 'required'
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $checkTime = date("H:i:s");
        $date = date('Y-m-d');
        $data = UserAppointment::where('booked_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
        if($request->appt_date == $date && $data->appt_date == $date){
            $addTime = date("H:i:s",strtotime($checkTime)+ 60 * 60);
           if($addTime >= $data->appt_start_time){
                return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Sorry! Now You Are Not Able To Reschedule The Appointment Due To Shortage Of Time As You Just Reschedule It Atleat One Hour Before The Appoinment Time.'
            ]);
           }
        }
        //check slot is already booked
        $bookedSlots = UserAppointment::where('appt_date',$request->appt_date)->where('business_id',$data->business_id)->where('appt_status','!=','cancelled')->get();
        if(count($bookedSlots) != 0){
            foreach($bookedSlots as $bookesSlot){
                if($bookesSlot->appt_start_time <= $request->appt_start_time && $request->appt_start_time < $bookesSlot->appt_end_time){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Selected Slot is already booked. Please choose another one.'
                    ]);
                }
            }
        }
         if($data){
             if($data->appt_status == 'cancelled'){
                  return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "Cancelled Appointment Cannot Be Updated."
                ]);
             }
              if($data->appt_status == 'rejected'){
                  return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "Sorry! Your Appointment Has been Rejected By Business Owner."
                ]);
             }
               if($data->appt_status == 'completed'){
                  return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "Your Appoinment is Already Completed. Please Create a new one."
                ]);
             }
            $userBusiness = UserBusiness::where('id',$data->business_id)->where('user_id','!=',auth()->user()->id)->first();
            $userBusinessDeatil = User::where('id',$userBusiness->user_id)->first();
            $interval = $userBusiness->slot_interval;
            $appt_end_time = date('H:i:s', strtotime($request->appt_start_time.' +'.$interval.' minutes'));
                $data->appt_date = $request->appt_date;
                $data->appt_start_time = $request->appt_start_time;
                $data->appt_end_time = $appt_end_time;
                $title = 'Reschedule User Appointment';
                $msg = 'User has rescheduled the Appoinment';
                $business_user_id = $data->business_user_id;
                $notification_source = 'app'; 
                    //is_acceptance = 0 means accept all appointments automatically
                    if($userBusiness->is_acceptance==0){
                        $data->appt_status = 'accepted';
                        $deviceToken = $userBusinessDeatil->device_token;
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                            $message = 'Your Appointment Has Been Rescheduled Successfully.';
                    }else{
                        $data->appt_status = 'pending';
                        if (!empty($deviceToken)) {
                            $helper->SendNotification($deviceToken,$title,$msg,$business_user_id,$notification_type,$notification_source);
                        }
                            $message = 'Appointment Has Been Rescheduled And Sent To Business Owner Successfully. You Will Be Notified Shortly.';
                    }
                if($data->save()){
                                $booked_user_id = $data->booked_user_id;
                                $business_owner_id = $data->business_user_id;
                                $business_id =  $data->business_id;
                                $event_id = $data->id;
                                $notification_type = 'user_appointment';
                                $notification_source = 'app'; 
                    $history = $this->NotificationLogRecord("User","Business Owner",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                    //create task for booked user
                    $updateTask = CreateTask::where('business_appt_id',$request->appt_id)->get();
                    if($updateTask){
                        foreach($updateTask as $key){
                        $key->t_Id = $request->t_id;
                        $key->date_format = $request->appt_date;
                        $key->start_task_time = $request->appt_start_time;
                        $key->end_task_time = $appt_end_time; 
                        $key->save();  
                    }
                    }
                    return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => $message

                ]);  
                }else{
                     return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.'
                ]);  
                }
             
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
     //get business owner appointments list
    public function GetBusinessOwnerAppointmentsList(){
        $list = UserAppointment::where('business_user_id',auth()->user()->id)->orderby('created_at', 'desc')->get();
         if($list){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'success',
                    'data'=> $list
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
     //get business appointment detail
    public function GetBusinessOwnerAppointmentDetailById(Request $request){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('business_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
         if($data){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'success',
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
       //get business appointment detail
    public function AcceptUserAppointment(Request $request, AppointmentPushHelper $helper){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('business_user_id',auth()->user()->id)->where('id',$request->appt_id)->where('appt_status','pending')->first();
         if($data){
            $bookedUser = User::where('id',$data->booked_user_id)->first();
             $data->accepted;
              $title = 'Accepted User Appointment';
                $msg = 'Your Appoinment Has Been Accepted By The Business Owner.';
                $booked_user_id = $data->booked_user_id;
                $notification_source = 'app'; 
                $business_owner_id = $data->business_user_id;
                $business_id =  $data->business_id;
                $event_id = $data->id;
                $notification_type = 'business_appointment';
                        $data->appt_status = 'accepted';
                        $message = 'Appointment Has Been Accepted Successfully.';
                        $data->save();
                        if($bookedUser){
                        $history = $this->NotificationLogRecord("Business Owner","User",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                        $deviceToken = $bookedUser->device_token;
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$booked_user_id,$notification_type,$notification_source);
                            }   
                        }
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => $message,
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    
    //reject user appointment
    public function RejectUserAppointment(Request $request, AppointmentPushHelper $helper){
         // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('business_user_id',auth()->user()->id)->where('id',$request->appt_id)->where('appt_status','pending')->first();
         if($data){
            $bookedUser = User::where('id',$data->booked_user_id)->first();
             //delete created task for booked user and business owner
             $delete = CreateTask::where('business_appt_id',$request->appt_id)->delete();
             $data->appt_status = 'rejected';
             //send notification to booked user
                $title = 'Rejected User Appointment';
                $msg = 'Your appoinment has been Rejected by the business owner.';
                $booked_user_id = $data->booked_user_id;
                $business_owner_id = $data->business_user_id;
                $business_id =  $data->business_id;
                $event_id = $data->id;
                $notification_source = 'app'; 
                $notification_type = 'business_appointment';
                        if($bookedUser){
                        $history = $this->NotificationLogRecord("Business Owner","User",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                        $deviceToken = $bookedUser->device_token;
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$booked_user_id,$notification_type,$notification_source);
                            }  
                        }
             $data->save();
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Appointment Has Been Rejecetd Successfully.',
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    public function CompleteUserAppointment(Request $request, AppointmentPushHelper $helper){
         // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('business_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
         if($data){
            $bookedUser = User::where('id',$data->booked_user_id)->first();
             //delete created task for booked user and business owner
             //$delete = CreateTask::where('business_appt_id',$request->appt_id)->delete();
             $data->appt_status = 'completed';
             //send notification to booked user
                $title = 'Completed User Appointment';
                $msg = 'Business owner has completed the appoinment successfully.';
                $booked_user_id = $data->booked_user_id;
                $business_owner_id = $data->business_user_id;
                $business_id =  $data->business_id;
                $event_id = $data->id;
                $notification_source = 'app'; 
                $notification_type = 'business_appointment';
             $data->save();
                if($bookedUser){
                        $history = $this->NotificationLogRecord("Business Owner","User",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                        $deviceToken = $bookedUser->device_token;
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$booked_user_id,$notification_type,$notification_source);
                            }  
                        }
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Appointment Has Been Completed Successfully.',
                    'data'=> $data
                ]);   
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
            }
    }
    public function PayFullPyamentForAppointment(Request $request, AppointmentPushHelper $helper){
           // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
            'card_number' => 'required',
            'exp_month' => 'required',
            'exp_year' => 'required',
            'cvc' => 'required'
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('booked_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
        if($data){
          $pendingBalance = $data->pending_payment;
                 $token = $this->createToken($request);
                if (!empty($token['error'])) {
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'error' => $token['error'],
        
                    ]);
                }
                if (empty($token['id'])) {
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'message'=>'Payment failed.',
                        'error' => 'failed',
        
                    ]);
                }
                if($token['id'] && $pendingBalance) {
                    $charge =$this->createCharge($token['id'], $pendingBalance);
                    if($charge->id != null){
                        $data->appt_status = 'paid';
                        $data->pending_payment = 0;
                        $data->amount_paid = $pendingBalance;
                          $userBusiness = UserBusiness::where('id',$data->business_id)->where('user_id','!=',auth()->user()->id)->first();
                        $userBusinessDeatil = User::where('id',$userBusiness->user_id)->first();
                        //send notification to booked user
                        $title = 'Full Payment For Appointment';
                        $msg = 'User has been Paid for the appointment.';
                        if($userBusinessDeatil == null){
                             return response()->json([
                                        'status' => false,
                                        'status_code' => true,
                                        'message' => 'Business Owner Not Found.'
                                    ]);
                        }
                        $data->save();
                        $userAdvancePayment = new AppointmentPayment;
                        $userAdvancePayment->user_booked_id = auth()->user()->id;
                        $userAdvancePayment->business_id  = $data->business_id;
                        $userAdvancePayment->appt_id  = $request->appt_id;
                        $userAdvancePayment->business_user_id  = $data->business_user_id;
                        $userAdvancePayment->payment_status  = 'paid';
                        $userAdvancePayment->payment_method  = 'online';
                        $userAdvancePayment->stripe_transaction_id  = $charge->id;
                        $userAdvancePayment->amount_paid  = $pendingBalance;
                        $userAdvancePayment->save();
                           if($userBusinessDeatil){
                             $deviceToken = $userBusinessDeatil->device_token;
                                $booked_user_id = $data->booked_user_id;
                                $business_owner_id = $data->business_user_id;
                                $business_id =  $data->business_id;
                                $event_id = $data->id;
                                $notification_source = 'app'; 
                                $notification_type = 'user_appointment';
                                $history = $this->NotificationLogRecord("User","Business Owner",$booked_user_id,$business_owner_id,$business_id,$event_id,$title,$msg,$notification_type,$notification_source);
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$business_owner_id,$notification_type,$notification_source);
                            }  
                        }
                          return response()->json([
                            'status' => true,
                            'status_code' => true,
                            'message'=>'Payment successfully done.',
                        ]);

                    }else{
                        return response()->json([
                            'status' => false,
                            'status_code' => false,
                            'message'=>'Error.',
                        ]);
                    }
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => false,
                        'message'=>'Token or advance payment is not found.',
                    ]);
                }
                  
            
        }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]);
        }
    }
    
    public function AskForAppointmentPayment(Request $request){
        // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $data = UserAppointment::where('business_user_id',auth()->user()->id)->where('id',$request->appt_id)->where('appt_status','accepted')->first();
        if($data){
             $url = env('PAYMENT_URL');
                $appt_id = $request->appt_id;
                $payment_url = $url . $appt_id;
             return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message'=>'Payment Link has been sent to user successfully.',
                    'payment_url' => $payment_url
                ]); 
        }else{
             return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => "No Data Found."
                ]); 
        }
    }
    public function GetNotificationList(){
        //   $getDates = NotificationLogRecord::groupBy('created_at')->where('user_id',auth()->user()->id)->orderBy('created_at','DESC')->get(['created_at']);
           $getDates = NotificationLogRecord::select(
                            DB::raw("(DATE_FORMAT(created_at, '%Y-%m-%d')) as my_date")
                            )->where('send_by_id',auth()->user()->id)
                            ->orderBy('created_at')
                            ->groupBy(DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d')"))
                            ->get();
        foreach($getDates as $getDate){
            $notifications = NotificationLogRecord::where('send_by_id',auth()->user()->id)->whereDate('created_at',$getDate->my_date)->get();
            $getDate['notifications'] = $notifications;
        }

        return response()->json([
            'status' => true,
            'status_code' => true,
            'user_meal_plan' => $getDates,
        ]);
    }
    public function UserAppointmentRating(Request $request){
        // validate
          $validator = Validator::make($request->all(),[
            'appt_id' => 'required',
            'service_id' => 'required',
            'rating' => 'required'
        ]);
        //if validation fails
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
         $data = UserAppointment::where('booked_user_id',auth()->user()->id)->where('id',$request->appt_id)->first();
            if($data){
                $data->is_rating = '1';
                $data->save();
                $find = UserAppointmentRating::where('user_id',auth()->user()->id)->where('service_id',$request->service_id)->where('appt_id',$request->appt_id)->first();
                if($find){
                     return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Rating Is Already Added For This Service.'
                        ]);
                }
                $addRating = new UserAppointmentRating;
                $addRating->user_id = auth()->user()->id;
                $addRating->service_id = $request->service_id;
                $addRating->appt_id = $request->appt_id;
                $addRating->rating = $request->rating;
                $addRating->comment = $request->comment;
                    if($addRating->save()){
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'Rating Added Successfully.'
                        ]);
                    }else{
                         return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Something Went Wrong.'
                    ]);
                    }
            }else{
                 return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'No Appointment Found.'
                ]);
            }
    }
           
}
