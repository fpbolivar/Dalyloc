<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserBusiness;
use App\Models\User;
use App\Models\Model\UserBusinessTiming;
use App\Models\Model\UserBusinessService;
use App\Models\Model\UserAppointment;
use App\Models\Model\AppointmentPayment;
use App\Models\Model\CreateTask;
use App\Models\Model\AdminSetting;
use App\Helper\PushHelper;
use Datetime;
// use Stripe\StripeClient;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Session;
use Stripe;

class WebAppointmentController extends Controller
{

    private $stripe;
    public function __construct()
    {
        $this->stripe =new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
    }

   
    /**
     * get current url for browser
     */
    public function GetCurrentUrl(){
        $currentURL = url()->current();
        $urlArray= explode('/',$currentURL);
        return $slug = end($urlArray);

    }

    /**
     * get current url and find slug 
     * get sluge related user business timing and user business service
     */
    public function WebBooking(){
        //get url slug 
        $slug = $this->GetCurrentUrl();
        // get slug related user business
        $getData = UserBusiness::with('User')->where('slug',$slug)->first();

        if($getData){
            //get user business timing
            $getTime = UserBusinessTiming::where('business_id',$getData->id)->get();
            //get user business service
            $getServices = UserBusinessService::where('business_id',$getData->id)->get();
            // dump($getData->id);
            // dd($getServices);
             if($getData->online_booking == 1){
                    //check online booing accept true
                    $online_booking = true;
                    return view('web.webbooking',compact('getTime','getServices','getData',"online_booking"));
                }else{
                    //check online booing accept true
                    $online_booking = false;
                    $msg ="Online bookings are not available at the moment ";
                    return view('web.webbooking',compact('getTime','getServices','getData','online_booking','msg'))->with('error', 'Workout level  created successfully.');
                }
           
        }else{
            // error 404  file  
            return view('web.web404');
        }
    }

    /**
     * get time slot selected day  
     */
    public function GetTimeSlot(Request $req){
        $timestamp = strtotime($req->date);
       // day name
        $day = date('l', $timestamp); 
        $business_id =$req->business_id;
        //get business time slot
        $businessTime = UserBusinessTiming::where('business_id',$business_id)->where('day',$day)->first();
        // dd( $businessTime );
        // check user  business is available or  not 
        $business = UserBusiness::where('id',$business_id)->first();
        // get slot interval time 
        $slot_interval = $business->slot_interval;
        // we can check user select date slot  available or  not 
        $appointment = UserAppointment::where('appt_date',$req->date)->where('business_id',$business_id)->get();

        if(!empty($businessTime)){
           if($businessTime->isClosed == 0){
                $openTime = $businessTime->open_time;
                $closeTime =  date("H:i:s", strtotime($businessTime->close_time));
                $slot = date('H:i:s ', strtotime($openTime.' +'.$slot_interval.' minutes'));
                $data = [];
                for ($i=0; $slot <= $closeTime; $i++) {     
                    $data[$i] = [ 
                        'start' => date('H:i:s', strtotime($openTime)),
                        // 'end' => date('H:i:s', strtotime($slot)),
                    ];
                    $openTime = $slot;
                    $slot = date('H:i:s',strtotime($openTime. ' +'.$slot_interval.' minutes'));
                }
                // dump($data);
            //    check booked slot
                foreach($data as $i => $slots){
                    
                    $data[$i]['is_booked'] = 0; 
                    foreach($appointment as $bookesSlot){
                        if($bookesSlot->appt_start_time <= $slots['start'] && $slots['start'] < $bookesSlot->appt_end_time){
                            $data[$i]['is_booked'] = 1; 
                        }
                    }
                }
                // dd($businessTime);
                // dd($data);
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'businessTime' => $businessTime,
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
        // return response()->json(['success'=>'Got Simple Ajax Request.','request'=>$req->all()]);
        
    }

    /**
     * buy services 
     */
    public function SelectService(Request $req){
        //business id 
        $id = $req->id;
       //get business service
        $getServices = UserBusinessService::where('business_id',$id)->get();
        //check timing
        $getTime = UserBusinessTiming::where('business_id',$id)->get();
        if($req->isMethod('post') && $id ){
            Session::put('business_service', $req->service_id[0]); 
            $service_id =  explode(',',$req->service_id[0]);
            $service = UserBusinessService::whereIn('id',$service_id)->get();
            $deposit =0;
            foreach ($service as  $value) {
                    if($value->deposit_percentage  && $value->service_price){
                        //calculate advanced payment 
                         $amount  = $value->service_price * $value->deposit_percentage/(100);
                         // add amount in deposit
                         $deposit +=  $amount;
                    }
            }
            Session::put('deposit_amount', $deposit); 
            // Session::flush('deposit_amount');
            return redirect(env('WEB_URL').'/check/time/'.$id);
        }else{
            return view('web.webselectservice',compact('getServices'));
        }
    }

    /**
     *  select time slote 
     */
    public function TimeStaff(Request $req){
        $business_id = $req->id;
        $amount =  Session::get('deposit_amount'); 
        if($req->isMethod('post')){
                $apt_date = $req->app_date;
                $apt_time = date('H:i:s', strtotime($req->app_time));
                $data = [
                "business_id" => $business_id,
                "apt_date" => $apt_date,
                "apt_time" => $apt_time,
                ];
                session()->push('data', $data);
                return redirect(env('WEB_URL').'/contact/detail');

        }else{
        return view('web.webbusinesstime',compact('business_id','amount'));
        }
      
    }


    /**
     *  appoint payment  
     */
    public function AppointmentPayment($data){
        // user card  detail  
        $card= [
            "card_name" => $data['card_name'],
            "card_number" => $data['card_number'],
            "card_cvv" => $data['card_cvv'],
            "card_month" =>$data['card_month'],
            "card_year" => $data['card_year'],
            "amount" => $data['app_amount'],
        ];
         // create payment token    
        $token = $this->createToken($card);

        if (!empty($token['error'])) {
            return  $error = ['error'=> $token['error']];
        }
        if (empty($token['id'])) {
            return $error=['error' =>'Payment failed'];
        }
        // check token id  and amount 
        if($token['id'] != 0 && $card['amount'] != 0 ){
             // make payment 
            $charge = $this->createCharge($token['id'],$card['amount']);
             //payment status  
            if ($charge['status'] == 1) {
                // payment succeeded
                return $charge;
            }else{
                // payment failed
                return $charge;
            }
        }else{

            return $error=['error' =>'Enter Amount'];
        }
       
    }

    /**
     * create payment token 
     */
    private function createToken($cardData)
    {
        $token = null;
        try {
            $token = $this->stripe->tokens->create([
                'card' => [
                    'number' => $cardData['card_number'],
                    'exp_month' => $cardData['card_month'],
                    'exp_year' => $cardData['card_year'],
                    'cvc' => $cardData['card_cvv']
                ]
            ]);
        } catch (CardException $e) {
            $token['error'] = $e->getError()->message;
        } catch (Exception $e) {
            $token['error'] = $e->getMessage();
        }
        return $token;
    }


    /**
     * make payment 
     */
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


    /**
     *  fill user contact detail 
     */
    public function GetContactDetail(Request $req,PushHelper $helper) {
        //  get user selected slot , business , time 
        // slote detail  in  businessid , appointment id  , appointment date
        $sloteDetail = Session::get('data');
        // payment  amount 
        $amount =  Session::get('deposit_amount'); 
        // post request 
        if($req->isMethod('post')){
            // check amount 
            if($req->has('app_amount') && $req->app_amount != 0){
                // amount is not zero 
                    $this->validate($req, [
                        'booking_name' => 'required',
                        'booking_phone_no' => 'required',
                        'booking_email' => 'required',
                        'booked_user_message' => 'required',
                        'card_name' => 'required',
                        'card_number' => 'required',
                        'card_cvv' => 'required',
                        'card_month' => 'required',
                        'card_year' => 'required',
                    
                    ]);
                    $bookingUser = $req->All();
                    // make payment 
                    $card = $this->AppointmentPayment($bookingUser)->toArray();
                    // check  payment status
                    if(array_key_exists("status",$card) && $card['status'] == 'succeeded' ){
                        // payment status  succeeded
                        $checkUser = User::where('is_deleted', '0')->where('phone_no',$req->booking_phone_no)->orWhere('email',$req->booking_email)->first();
                        $business_id = $sloteDetail[0]['business_id'];
                        $userBusiness = UserBusiness::with('User')->where('id',$business_id)->first();
                        $slotTime =$userBusiness->slot_interval;
                        $userBusinessId =$userBusiness->user_id;
                        $userId =$checkUser?$checkUser->id:null ;
                        $deviceToken =$userBusiness->User?$userBusiness->User->device_token:null;  
                        $userBusinessEmail =$userBusiness->User->email; 
                        Session::put('userBusinessEmail', $userBusinessEmail); 
                        $appt_status =$userBusiness->is_active_payment == 1 ?"pending":"accepted";
                        $title = 'User  Appointment';
                        $msg = $bookingUser['booked_user_message'];
                        $notification_type = 'Business Meeting';
                        $notification_source = 'web'; 
                        $status ='';
                        // check user outsider or not
                        if($checkUser){
                                // add appointment 
                                $appointment = $this->AddAppointment($bookingUser,$sloteDetail,$appt_status,$slotTime,$userId,$userBusinessId,$deviceToken);
                                // user appointment create task  
                                $createTask = $this->CreateTaskUser($sloteDetail,$slotTime,$bookingUser,$userId);
                                // check appointment status  and  create task  status 
                                if($appointment['status'] == true &&  $createTask['status']== true){
                                    $status = true;
                                    // appointment id
                                    $appt_id = $appointment['appt_id'];
                                    // add payment record
                                    $payment = $this->AddAppointmentRecord($card,$sloteDetail,$userBusinessId,$userId,$appt_id);
                                }
                            }else{// user is outsider

                                // add appointment 
                                $appointment = $this->AddAppointment($bookingUser,$sloteDetail,$appt_status,$slotTime,$userId,$userBusinessId,$deviceToken);
                                // check appointment status
                                if($appointment['status'] == true){
                                    $status = true;
                                    // appointment id
                                    $appt_id = $appointment['appt_id'];
                                    // add payment record
                                    $payment = $this->AddAppointmentRecord($card,$sloteDetail,$userBusinessId,$userId,$appt_id);
                                }
                            }
                           // user business   
                        if($userBusiness->is_active_payment == 1 && $status == true ){
                                if(!empty($deviceToken)){
                                    $helper->SendNotification($deviceToken,$title,$msg,$userBusinessId,$notification_type,$notification_source);
                                }
                                Session::flush('deposit_amounts');
                                Session::flush('data');
                                return redirect()->back()->with('success', 'Your Appointment Has Been Sent To Business Owner. You Will Be Notified Shortly.');
                        }elseif($userBusiness->is_active_payment == 0 && $status == true) {
                                if(!empty($deviceToken)){
                                    $helper->SendNotification($deviceToken,$title,$msg,$userBusinessId,$notification_type,$notification_source);
                                }
                                Session::flush('deposit_amounts');
                                Session::flush('data');
                                return redirect()->back()->with('success', 'Your Appointment Has Been Booked Successfully.');
                        }
                    }elseif($card['error']){
                        return redirect()->back()->with('error', $card['error']);
                    }

            }else{  
                // amount is zero
                    $this->validate($req, [
                        'booking_name' => 'required',
                        'booking_phone_no' => 'required',
                        'booking_email' => 'required',
                        'booked_user_message' => 'required'
                    ]);
                    $checkUser = User::where('is_deleted', '0')->where('phone_no',$req->booking_phone_no)->orWhere('email',$req->booking_email)->first();
                    $business_id = $sloteDetail[0]['business_id'];
                    $userBusiness = UserBusiness::with('User')->where('id',$business_id)->first();
                    $bookingUser = $req->All();
                    $slotTime =$userBusiness->slot_interval;
                    $userBusinessId =$userBusiness->user_id;
                    $userId =$checkUser?$checkUser->id:null ;
                    $deviceToken =$userBusiness->User?$userBusiness->User->device_token:null;  
                    $userBusinessEmail =$userBusiness->User->email; 
                    Session::put('userBusinessEmail', $userBusinessEmail); 
                    $appt_status =$userBusiness->is_active_payment == 1 ?"pending":"accepted";
                    $title = 'User  Appointment';
                    $msg = $bookingUser['booked_user_message'];
                    $notification_type = 'Business Meeting';
                    $notification_source = 'web'; 
                    $status ='';
                    if($checkUser){ 
                        $business_service =  Session::get('business_service');
                        $service_detail  = $this->AddBusinessService($business_service);
                        $appointment = $this->AddAppointment($bookingUser,$sloteDetail,$appt_status,$slotTime,$userId,$userBusinessId,$service_detail);
                        $createTask = $this->CreateTaskUser($sloteDetail,$slotTime,$bookingUser,$userId);
                        if($appointment['status'] == true &&  $createTask['status']== true){
                            $status = true;
                            $appt_id = $appointment['appt_id'];
                        }
                    }else{
                        $business_service =  Session::get('business_service');
                        $service_detail  = $this->AddBusinessService($business_service);
                        // dd('service_detailgewt',$service_detail);
                        if(count($service_detail) != 0){
                            $appointment = $this->AddAppointment($bookingUser,$sloteDetail,$appt_status,$slotTime,$userId,$userBusinessId,$service_detail);
                            if($appointment['status'] == true){
                                $status = true;
                                $appt_id = $appointment['appt_id'];
                            }
                        }
                        
                    }
                    if($userBusiness->is_active_payment == 1 && $status == true ){
                        if(!empty($deviceToken)){
                            $helper->SendNotification($deviceToken,$title,$msg,$userBusinessId,$notification_type,$notification_source);
                        }
                        Session::flush('deposit_amounts');
                        Session::flush('data');
                        return redirect()->back()->with('success', 'Your Appointment Has Been Sent To Business Owner. You Will Be Notified Shortly.');
                    }elseif($userBusiness->is_active_payment == 0 && $status == true) {
                        if(!empty($deviceToken)){
                            $helper->SendNotification($deviceToken,$title,$msg,$userBusinessId,$notification_type,$notification_source);
                        }
                        Session::flush('deposit_amounts');
                        Session::flush('data');
                        return redirect()->back()->with('success', 'Your Appointment Has Been Booked Successfully.');
                    }

            }
            
          

        }else{
            return view('web.webcontactdetail',compact('amount'));
        }
    }

    /**
      * add user  appointment 
      */
    public function AddAppointment($bookingUser,$sloteDetail,$appt_status,$slotTime,$userId,$userBusinessId,$service_detail){
        dd($service_detail['amount']);
        $createUserAppointment = new UserAppointment;
        $end_time = date('H:i:s',strtotime($sloteDetail[0]['apt_time']. ' +'.$slotTime.' minutes'));
        $createUserAppointment->booked_user_id = $userId ? $userId : "";
        $createUserAppointment->booked_user_name =$bookingUser['booking_name'];
        $createUserAppointment->booked_user_phone_no = $bookingUser['booking_phone_no'];
        $createUserAppointment->booked_user_email = $bookingUser['booking_email'];
        $createUserAppointment->booked_user_message = $bookingUser['booked_user_message'];
        $createUserAppointment->appt_status	 = $appt_status;
        $createUserAppointment->appt_date	 = $sloteDetail[0]['apt_date'];
        $createUserAppointment->appt_start_time	 = $sloteDetail[0]['apt_time'];
        $createUserAppointment->appt_end_time	 = $end_time;
        $createUserAppointment->business_id	 = $sloteDetail[0]['business_id'] ? $sloteDetail[0]['business_id']:'';
        $createUserAppointment->business_user_id= $userBusinessId;
        $createUserAppointment->total_payment= $service_detail['amount'];
        $createUserAppointment->service_detail= $service_detail['services'];
        // $createUserAppointment->admin_commission_percentage= $admin_commission_percentage;
        // $createUserAppointment->admin_commission_amt= $admin_commission_amt;

        dd($createUserAppointment);
        if($createUserAppointment->save()){
            $appt_id =$createUserAppointment->id;
            $taskOwer = $this->CreateTaskOwner($createUserAppointment);
            if($taskOwer['onwetask'] == true){
                return  $userAppointment =[ 'status' =>true,'appt_id' => $appt_id ];
            }else{
                return  $userAppointment =[ 'onwetask' =>false  ];
            }
        }else{
                return  $userAppointment =[ 'status' =>false  ];
        }
     }

     /**
      * user create task 
      */
    public function CreateTaskUser($sloteDetail,$slotTime,$bookingUser,$userId){
        $end_time = date('H:i:s',strtotime($sloteDetail[0]['apt_time']. ' +'.$slotTime.' minutes'));
        $newCreateTask = new  CreateTask;
        $newCreateTask->t_id = str_replace(".","",microtime(true));
        $newCreateTask->email =  $bookingUser['booking_email'];
        $newCreateTask->task_name = " User  Appointment";
        $newCreateTask->user_id =  $userId;
        $newCreateTask->note = $bookingUser['booked_user_message'];;
        $newCreateTask->task_type =  "user_appointment";
        $newCreateTask->date_format =  $sloteDetail[0]['apt_date'];
        $newCreateTask->start_task_time = $sloteDetail[0]['apt_time'];
        $newCreateTask->end_task_time =  $end_time;
        if($newCreateTask->save()){
            return $createTask=[ 'status' =>true ];
        }else{
            return $createTask=[ 'status' =>false ];
        }
    }

    /**
     * business owner create task 
    */
    public function CreateTaskOwner($appt){
        $email = Session::get('userBusinessEmail');
        $newCreateTask = new  CreateTask;
        $newCreateTask->user_id =  $appt->business_user_id;
        $newCreateTask->t_id = str_replace(".","",microtime(true));
        $newCreateTask->email =  $email;
        $newCreateTask->task_name = "Business Appointment";
        $newCreateTask->task_type = "business_appointment";
        $newCreateTask->note = $appt->booked_user_message;
        $newCreateTask->date_format =$appt->appt_date;
        $newCreateTask->start_task_time = $appt->appt_start_time;
        $newCreateTask->end_task_time =  $appt->appt_end_time;
        $newCreateTask->business_appt_id = $appt->id;
        if($newCreateTask->save()){
            Session::flush('userBusinessEmail');
            return   $createTask=[ 'onwetask' =>true];
        }else{
            return $createTask=[ 'onwetask' =>false ];
        }
    }
    
    /**
     * add  appointment payment recod 
     */
    public function AddAppointmentRecord($card,$sloteDetail,$userBusinessId,$userId,$appt_id){
            $addNew =new AppointmentPayment;
            $addNew->user_booked_id =$userId?$userId:"";
            $addNew->business_id =$sloteDetail[0]['business_id'];
            $addNew->business_user_id =$userBusinessId;
            $addNew->appt_id =$appt_id;
            $addNew->stripe_transaction_id =$card['balance_transaction'];
            $addNew->payment_status =$card['status'];
            $addNew->payment_method =$card['payment_method_details']['type'];
            $addNew->amount_paid =$card['amount'];
            if($addNew->save()){
                return $payment=[ 'AppointmentPayment' =>true];
            }else{
                return $payment=[ 'AppointmentPayment' =>false ];
            }

    }

    public function  AddBusinessService($service){
        $getData=[];
        $serviceDetail =[];
        $total_amount=0;
        $test=[];
        if(!empty($service)){
            $service_id =  explode(',',$service);
            $serviceList = UserBusinessService::whereIn('id',$service_id)->get();
            foreach ($serviceList as $value) {
                $test['name'] = $value->service_name;
                $test['service_price'] = $value->service_price;
                $test['deposit_percentage'] = $value->deposit_percentage;
                $test['service_time'] = $value->service_time;
                array_push($serviceDetail,$test);
                $total_amount+=$value->service_price;
                
            }
               $output = array_map(function($element) {
                    return (object) $element;
                }, $serviceDetail);
                return  $getData=[
                    'amount' =>$total_amount,
                    'services'=>$output,

                ];
                 
        }

    }
}
