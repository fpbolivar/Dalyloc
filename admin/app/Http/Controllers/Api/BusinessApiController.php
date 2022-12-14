<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\Model\BusinessCategory;
use App\Models\Model\UserBusiness;
use App\Models\Model\UserBusinessService;
use App\Helper\ImageHelper;
use App\Models\Model\UserBusinessTiming;


class BusinessApiController extends Controller
{
    public function GetAllBusinessCategory(Request $request){

        $allBusinessCategory = BusinessCategory::where('is_deleted','0')->orderBy('business_category_name')->get();
        // $allSubTask = CreateSubtask::where('user_id',$userId)->where('date_format',$date)->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $allBusinessCategory,
            ]);
    }

    //user create business
    public function CreateUserBusiness(Request $request, ImageHelper $imageHelper){
         // validate
    	 $validator = Validator::make($request->all(),[
            'business_name' => 'required',
            'business_email' => 'required|email',
            // 'business_address'=> 'required',
            // 'lat'=> 'required',
            // 'lng'=> 'required',
            'business_category_id'=> 'required',
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
        $AlreadyUserHasBusiness = UserBusiness::where('user_id',auth()->user()->id)->first();
        if (!is_null($AlreadyUserHasBusiness)) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Already Has a Business.'
            ]);
        }else{
            $checkBusinessSlug = UserBusiness::where('slug',\Str::slug($request->business_name))->first();
            $createUserBusiness = new UserBusiness;
            $createUserBusiness->user_id = auth()->user()->id;
            if($request->has('slot_interval')){
                $createUserBusiness->slot_interval = $request->slot_interval;
            }     
            $createUserBusiness->business_name = $request->business_name;
            // $createUserBusiness->online_booking = $request->online_booking;
            if($checkBusinessSlug){
                $createUserBusiness->slug = \Str::slug($request->business_name).'_'.rand(10,100);
            }else{
                $createUserBusiness->slug = \Str::slug($request->business_name);
            }
             //if has image
             if($request->has('business_image')){
                $path = '/images/user-business';
                $createUserBusiness->business_img = $imageHelper->UploadImage($request->business_image,$path);
            }
            $createUserBusiness->business_email = $request->business_email;
            // $createUserBusiness->business_address = $request->business_address;
            // $createUserBusiness->lat = $request->lat;
            // $createUserBusiness->lng = $request->lng;
            $createUserBusiness->business_category_id = $request->business_category_id;
            if($createUserBusiness->save()){
                $url = env('BOOKING_URL');
                $slug = $createUserBusiness->slug;
                $booking_url = $url . $slug;
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' =>'Business Created Successfully.',
                    'user_business' => $createUserBusiness,
                    'booking_url'=>$booking_url
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'Something Went Wrong.',
                ]);
            }
       }

    }


      //user update business
      public function UpdateUserBusiness(Request $request, ImageHelper $imageHelper){
        // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
           'business_name' => 'required',
           'business_email' => 'required|email',
           // 'business_address'=> 'required',
           // 'lat'=> 'required',
           // 'lng'=> 'required',
           'business_category_id'=> 'required',
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
           $checkBusinessSlug = UserBusiness::where('slug',\Str::slug($request->business_name))->first();
           $updateUserBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
           if($updateUserBusiness){
            //$updateUserBusiness->user_id = auth()->user()->id;
           if($request->has('slot_interval')){
            $updateUserBusiness->slot_interval = $request->slot_interval;
        }     
        $updateUserBusiness->business_name = $request->business_name;

        if($checkBusinessSlug){
            $updateUserBusiness->slug = \Str::slug($request->business_name).'_'.rand(10,100);
        }else{
            $updateUserBusiness->slug = \Str::slug($request->business_name);
        }
         //if has image
         if($request->has('business_image')){
            $path = '/images/user-business';
            $updateUserBusiness->business_img = $imageHelper->UploadImage($request->business_image,$path);
        }
        $updateUserBusiness->business_email = $request->business_email;
        $updateUserBusiness->business_address = $request->business_address;
        $updateUserBusiness->lat = $request->lat;
        $updateUserBusiness->lng = $request->lng;
        $updateUserBusiness->business_category_id = $request->business_category_id;
        if($updateUserBusiness->save()){
            $url = env('BOOKING_URL');
            $slug = $updateUserBusiness->slug;
            $booking_url = $url . $slug;
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' =>'Business Updated Successfully.',
                'user_business' => $updateUserBusiness,
                'booking_url'=>$booking_url
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Something Went Wrong.',
            ]);
        }
           }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found'
            ]);
           }
           
   }

    //get user business
    public function GetUserBusiness(){
        $userBusiness = UserBusiness::with('UserBusinessCategory','UserBusinessTiming','UserBusinessService')->where('user_id',auth()->user()->id)->first();
        if($userBusiness != null){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $userBusiness,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
    }
    
    //add or update deposit percentage
    public function DepositPercentage(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
            'deposit_percentage' =>'required'
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
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
               $userBusiness->deposit_percentage = $request->deposit_percentage;
                if($userBusiness->save()){
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'deposit_percentage' => $userBusiness['deposit_percentage'],
                    ]);
                }else{
                       return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' =>'Something Went Wrong.',
                    ]); 
                }
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
    }
    
        //get deposit percentage
    public function GetDepositPercentage(Request $request){
         // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
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
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'deposit_percentage' => $userBusiness['deposit_percentage'],
                    ]);
   
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'No data found.',
            ]);
        }
    }
      //get get acceptance
      public function GetAcceptance(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
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
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'acceptance' => $userBusiness['is_acceptance'],
                    ]);
   
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
      }
      
    //add or update acceptance
    public function Acceptance(Request $request){
         // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
            'acceptance' =>'required'
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
          $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
               $userBusiness->is_acceptance = $request->acceptance;
                if($userBusiness->save()){
                    //dd($userBusiness);
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'acceptance' => $userBusiness['is_acceptance'],
                    ]);
                }else{
                       return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' =>'Something Went Wrong.',
                    ]); 
                }
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
    }

      //add or update payment active for business setting
    public function ActivePayment(Request $request){
         // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
            'is_active_payment' =>'required'
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
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
             $userBusiness->is_active_payment = $request->is_active_payment;
                if($userBusiness->save()){
                    //dd($userBusiness);
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'is_active_payment' => $userBusiness['is_active_payment'],
                    ]);
                }else{
                       return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' =>'Something Went Wrong.',
                    ]); 
                }
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
    }
         
    //get active payment of business setting
    public function GetActivePayment(Request $request){
         // validate
        $validator = Validator::make($request->all(),[
            'user_business_id'=>'required|exists:user_business,id',
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
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->user_business_id)->first();
        if($userBusiness){
                        return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'is_active_payment' => $userBusiness['is_active_payment'],
                    ]);
   
        }else{
             return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.',
            ]);
        }
    } 
    //edit user business slot interval
    public function EditUserBusinessSlotInterval(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'business_id' => 'required',
            'slot_interval' => 'required'
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

        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->business_id)->first();
        if($userBusiness){
            if($userBusiness->slot_interval == $request->slot_interval){
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Business Slot Interval Already Exists. Please Choose a Different One.',
                ]);
            }else{
                $userBusiness->slot_interval = $request->slot_interval;
                if($userBusiness->save()){
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'Slot Interval Is Updated Successfully.',
                    ]);
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Something Went Wrong.',
                    ]);
                }
    
            }
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.',
            ]);
        }
    }

    //get online booking setting
    public function GetOnlineBookingSetting(Request $request){
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->first();
        if($request->has('online_booking')){
            //update
            $userBusiness->online_booking = $request->online_booking;
            if($userBusiness->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' =>$userBusiness
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
                'status' => true,
                'status_code' => true,
                'data' =>$userBusiness
            ]);
        }
    }

    //create user business service
    public function CreateUserBusinessService(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'business_id' => 'required|exists:user_business,id',
            'service_name' => 'required',
            'service_price'=> 'required',
            'service_time'=> 'required',
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

        //check
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->business_id)->first();
        if($userBusiness){
            $createService = new UserBusinessService;
            $createService->user_id = auth()->user()->id;
            $createService->business_id = $request->business_id;
            $createService->service_name = $request->service_name;
            $createService->service_price = $request->service_price;
            $createService->service_time = $request->service_time;
            $createService->deposit_percentage = $request->deposit_percentage;
            if($request->has('service_online_booking')){
                $createService->service_online_booking = $request->service_online_booking;
            }
            if($createService->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Business Service Created Successfully.',
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.',
                ]);
            }

        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Not Found.',
            ]);
        }

        
    }

    //edit user business service
    public function EditUserBusinessService(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'business_service_id' => 'required|exists:user_business_services,id',
            'business_id' => 'required|exists:user_business,id',
            'service_name' => 'required',
            'service_price'=> 'required',
            'service_time'=> 'required',
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
        $userBusinessService = UserBusinessService::where('id',$request->business_service_id)->where('user_id',auth()->user()->id)->where('business_id',$request->business_id)->first();
        if($userBusinessService){
            $userBusinessService->user_id = auth()->user()->id;
            $userBusinessService->business_id = $request->business_id;
            $userBusinessService->service_name = $request->service_name;
            $userBusinessService->service_price = $request->service_price;
            $userBusinessService->service_time = $request->service_time;
            $userBusinessService->deposit_percentage = $request->deposit_percentage;
            
            if($request->has('service_online_booking')){
                $userBusinessService->service_online_booking = $request->service_online_booking;
            }
            if($userBusinessService->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Business Service Updated Successfully.',
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.',
                ]);
            }
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Service Not Found.',
            ]);
        }

    }

    //delete user business service
    public function DeleteUserBusinessService(Request $request){
            // rules
            $rules = [
                'business_id' => 'required',
                'business_service_id' => 'required|exists:user_business_services,id'
            ];
            $validator = Validator::make($request->all(), $rules);
            // if validator fails
            if ($validator->fails()) {
                return response()->json([
                    "message" => $validator->messages()->first(),
                    "status" => false,
                    'status_code' => true
                ]);
            }else{
                $userBusinessService = UserBusinessService::where('id',$request->business_service_id)->where('user_id',auth()->user()->id)->where('business_id',$request->business_id)->where('is_deleted','0')->first();
                if($userBusinessService){
                    $userBusinessService->is_deleted = '1';
                    if($userBusinessService->save()){
                        return response()->json([
                            'status' => true,
                            'status_code' => true,
                            'message' => 'Business Service Deleted Successfully.',
                        ]);
                    }else{
                        return response()->json([
                            'status' => false,
                            'status_code' => true,
                            'message' => 'Something Went Wrong.',
                        ]);
                    }
                }else{
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Business Service Not Found.',
                    ]);
                }

            }
    }

    //get all user business services
    public function GetAllUserBusinessService(Request $request){
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
        $userBusinessService = UserBusinessService::where('user_id',auth()->user()->id)->where('business_id',$request->business_id)->where('is_deleted','0')->get();
        if($userBusinessService){
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

    /**
    * update deposite
    */
    public function UpdateDeposite(Request $req){
        //get in  request  id , businessid , deposit percentage
        if($req->business_id && $req->id && $req->deposit_percentage){
           $updateDeposit = UserBusinessService::where('is_deleted','0')->where('business_id',$req->business_id)->where('id',$req->id)->first();
           if($updateDeposit){
               $updateDeposit->deposit_percentage = $req->deposit_percentage;
               //save deposit percentage
               $updateDeposit->save();
               return response()->json([
                 'status' => true,
                 'status_code' => true,
                 'data' =>$updateDeposit,
             ]);
           }else{
              return response()->json([
                  'status' => false,
                  'status_code' => true,
                  'error' =>'error'
              ]);
           }
           
        }
      
     }


    //get user business service detail
    public function GetUserBusinessServiceDetail(Request $request){
           // validate
    	 $validator = Validator::make($request->all(),[
            'business_service_id' => 'required|exists:user_business_services,id',
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

        $data = UserBusinessService::where('user_id',auth()->user()->id)->where('id',$request->business_service_id)->first();
        if($data){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $data,
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Services Not Found.',
            ]);
        }
    }
    //create user business timing
    public function CreateUserBusinessTiming(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'business_id' => 'required|exists:user_business,id',
            // 'day' => 'required',
            // 'isClosed'=> 'required',
            // 'open_time'=> 'required',
            // 'close_time'=> 'required',

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

        //check business exist
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->business_id)->first();

        //if already has time
        $userBusinessTimingExist = UserBusinessTiming::where('user_id',auth()->user()->id)->where('business_id',$request->business_id)->first();
        if($userBusinessTimingExist){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'You Have Already Scheduled Your Business.'
            ]);
        }
        if($userBusiness){
            //dd(count($request->timing));
            foreach($request->timing as $timing){
                $userBusinessTiming = new UserBusinessTiming;
                $userBusinessTiming->user_id = auth()->user()->id;
                $userBusinessTiming->business_id = $request->business_id;
                $userBusinessTiming->day = $timing['day'];
                $userBusinessTiming->isClosed = $timing['is_closed'];
                $userBusinessTiming->open_time = $timing['open_time'];
                $userBusinessTiming->close_time = $timing['close_time'];
                $userBusinessTiming->save();
            }

                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Business Timing Created Successfully.',
                ]);
            
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Not Found.',
            ]);
        }

    }

    //edit user business timing
    public function EditUserBusinessTiming(Request $request){
         // validate
    	 $validator = Validator::make($request->all(),[
            'business_id' => 'required|exists:user_business,id',
            // 'day' => 'required',
            // 'isClosed'=> 'required',
            // 'open_time'=> 'required',
            // 'close_time'=> 'required',

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
        
        //check business exist
        $userBusiness = UserBusiness::where('user_id',auth()->user()->id)->where('id',$request->business_id)->first();
        if($userBusiness){
            $userBusinessTimings = UserBusinessTiming::where('business_id',$request->business_id)->get();
            if($userBusinessTimings){
                $updateTiming=[];
                for ($i=0; $i < count($request->timing); $i++) {
                    
                    $checkId =[];
                    if(!empty($request->timing[$i]['timing_id'])){
                        $checkId = $request->timing[$i]['timing_id'];
                    }else{
                        $checkId = '0';
                    }
    
                    $updateTiming[] = array(
                    'timing_id' =>$checkId,
                    'day'=> $request->timing[$i]['day'],
                    'is_closed' => $request->timing[$i]['is_closed'],
                    'open_time' => $request->timing[$i]['open_time'],
                    'close_time' => $request->timing[$i]['close_time'],
                    );
                }
               
            foreach($updateTiming as $key){
                if ($key['timing_id'] == '0') {
                    $userBusinessTiming = new UserBusinessTiming;
                    $userBusinessTiming->user_id = auth()->user()->id;
                    $userBusinessTiming->business_id = $request->business_id;
                    $userBusinessTiming->day = $key['day'];
                    $userBusinessTiming->isClosed = $key['is_closed'];
                    $userBusinessTiming->open_time = $key['open_time'];
                    $userBusinessTiming->close_time = $key['close_time'];
                    $userBusinessTiming->save();

                }else{
                    $userBusinessTiming =  UserBusinessTiming::find($key['timing_id']);
                    $userBusinessTiming->user_id = auth()->user()->id;
                    $userBusinessTiming->day = $key['day'];
                    $userBusinessTiming->isClosed = $key['is_closed'];
                    $userBusinessTiming->open_time = $key['open_time'];
                    $userBusinessTiming->close_time = $key['close_time'];
                    $userBusinessTiming->save();
                }

            }
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Business Timing Updated Successfully.',
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Business Timings Not Found.',
                ]);
            }
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Business Not Found.',
            ]);
        }

    }

}
