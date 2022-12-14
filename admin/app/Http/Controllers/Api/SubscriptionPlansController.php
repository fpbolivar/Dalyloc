<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\SubscriptionPlans;
use App\Models\Model\UserSubscription;
use Validator;
use App\Helper\SubscriptionHelper;
use App\Models\User;
use App\Models\Model\SubscriptionSubPlans;
use Illuminate\Support\Arr;

class SubscriptionPlansController extends Controller
{   

    public function GetUserCards(){
        try{
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $user = User::select('stripe_customer_id')->whereid(auth()->user()->id)->first();
            $cards = [];
            if(!is_null($user->stripe_customer_id)){
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                $cardData = $stripe->customers->allSources(
                    $user->stripe_customer_id,
                    ['object' => 'card']
                  );
                  
                  $customer = $stripe->customers->retrieve( $user->stripe_customer_id,[]);
                  
                //   print_r($customer->default_source);

                //   $defaultCard = $stripe->customers
                foreach($cardData['data'] as $card){
                    if($customer->default_source == $card['id'] )
                    {
                        $default = "1";
                    }
                    else
                    {
                         $default = "0";
                    }
                    $cards[] = [
                            "id" => $card['id'],
                            "object" => $card['object'],
                            "brand" => $card['brand'],
                            "country" => $card['country'],
                            "funding" => $card['funding'],
                            "last4" => $card['last4'],
                            "default" => $default
                    ];
                }
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => "Success",
                "cards"=>$cards
            ]);
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e->getMessage()
            ]);
        }
            
    }
    
    public function UpdateDefaultCard(Request $request)
    {
        try{
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $user = User::select('stripe_customer_id')->whereid(auth()->user()->id)->first();
            $cards = [];
            if(!is_null($user->stripe_customer_id)){
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));

                $updatecustomer = $stripe->customers->update($user->stripe_customer_id ,['default_source'=> $request->card_id]);
                
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => "Success"
            ]);
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e->getMessage()
            ]);
        }
    }
    
    public function DeleteCard(Request $request)
    {
        try{
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $user = User::select('stripe_customer_id')->whereid(auth()->user()->id)->first();
            $cards = [];
            if(!is_null($user->stripe_customer_id)){
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                
                $stripe->customers->deleteSource($user->stripe_customer_id, $request->card_id,[]);
                
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => "Success"
            ]);
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e->getMessage()
            ]);
        }
    }

    public function CreateCardToken(Request $request){
        // validate
        $validator = Validator::make($request->all(),[
            'card_number' => 'required',
            'exp_month' => 'required',
            'exp_year' => 'required',
            'cvc' => 'required',
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
        try{
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            // get user stripe customer id
            $user = User::select('stripe_customer_id','phone_no')->whereid(auth()->user()->id)->first();
            if(is_null($user->stripe_customer_id)){
                // create customer and update to user
                $customer = $stripe->customers->create([
                    'phone' => $user->phone_no,
                    'description' => "customer with phone : ".$user->phone_no,
                ]);
                // update to user
                $update = User::whereid(auth()->user()->id)->update(["stripe_customer_id"=>$customer->id]);
                // select updated
                $user = User::select('stripe_customer_id','email')->whereid(auth()->user()->id)->first();
            }
            // create token
            $token = $stripe->tokens->create([
                            'card' => [
                                'number' => $request->card_number,
                                'exp_month' => $request->exp_month,
                                'exp_year' => $request->exp_year,
                                'cvc' => $request->cvc
                            ],
                        ]);
            // create token
            $customer = $stripe->customers->retrieve(
                            $user->stripe_customer_id,
                            []
                        );
            $card = null;
            if(!is_null($customer->sources)){
                foreach ( $customer->sources['data'] as $source ) {
                    if ( $source['fingerprint'] == $token['card']->fingerprint ) {
                        $card = $source;
                    }
                }
            }
            if ( is_null( $card ) ) {
                $card = $stripe->customers->createSource($user->stripe_customer_id ,['source' => $token->id]);
            }
            $updatecustomer = $stripe->customers->update($user->stripe_customer_id ,['default_source'=> $card->id]);
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => "Success",
                'customer_id'=>$updatecustomer->id
            ]);
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e->getMessage()
            ]);
        }
    }

    public function GetPlans(){
        $allPlans = SubscriptionPlans::with('SubscriptionSubPlans')->get();
        if($allPlans){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'allPlans' => $allPlans
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => 'No Plans Are There.'
            ]);
        }
    }

    //user active plan list
    public function GetUserActivePlans(){
        $allActivePlans = UserSubscription::with('Detail')->whereuser_id(auth()->user()->id)->whereIn('subscription_status',['active'])->orderBy('id','DESC')->get();
        if($allActivePlans){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'activeplans' => $allActivePlans
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => 'No Plans Are There.'
            ]);
        }
    }

    public function GetUserActivePlansByType(Request $request){
        $validator = Validator::make($request->all(),[
            'plan_operation' => 'required',
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
        $isActive = 0;
        $checkSubscription = UserSubscription::whereuser_id(auth()->user()->id)->where('plan_operation',$request->plan_operation)->where('subscription_status','active')->first();
        $today = date('Y-m-d');
        if($checkSubscription != null){
            if($checkSubscription->end_date >= $today)
            {
                $isActive = 1;
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'isActive' => $isActive
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Data Not Found.'
            ]);
        }
    }

    public function StripeUserSubscription(Request $request, SubscriptionHelper $helper){
        $validator = Validator::make($request->all(),[
            'sub_plan_id' => 'required|exists:subscription_sub_plans,id'
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
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
            //check if already subscribed
            $AlreadyActiveSubscription = UserSubscription::whereuser_id(auth()->user()->id)->whereIn('subscription_status',['active'])->where('sub_plan_id',$request->sub_plan_id)->orderBy('id','DESC')->first();
            if (!is_null($AlreadyActiveSubscription)) {
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Already Subscribed To a Plan.'
                ]);
            }else{
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                 $cardData = $stripe->customers->allSources(
                    $user->stripe_customer_id,
                    ['object' => 'card']
                  );
                //   dd($cardData);
                 if(empty($cardData['data'])) {
                     return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'response_code'=> 404,
                        'message' => 'Please Add Payment Method.'
                    ]);
                 }
                $planDetails = SubscriptionSubPlans::with("Plan")->where('id',$request->sub_plan_id)->first();
               
                if(is_null($planDetails)){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => 'Invalid Plan.'
                    ]);
                }
                
                
               
                
                
                $stripePriceId = $planDetails->subscription_price_id;
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                $subscriptionData = $stripe->subscriptions->create([
                    'customer' => $customerId,
                    'items' => [
                        ['price' => $stripePriceId],
                    ],
                ]);
	    	    $startDate = date('Y-m-d');
                $userSubscription = new UserSubscription;
                $userSubscription->user_id = auth()->user()->id;
                $userSubscription->plan_id  = $planDetails->Plan->id;
                $userSubscription->sub_plan_id  = $planDetails->id;
                $userSubscription->plan_type  = $planDetails->type;
                $userSubscription->plan_operation  = $planDetails->type_of_operation;
                $userSubscription->subscription_id  = $subscriptionData->id;
                $userSubscription->start_date  = $startDate;
                $userSubscription->end_date = date('Y-m-d', $subscriptionData->current_period_end);
                $userSubscription->amount  =  $planDetails->amount;
                $userSubscription->subscription_status  = 'active';
                $userSubscription->subscription_type  = 'stripe';
                if($userSubscription->save()){
                    $userDetails = User::with('UserSubscription')->whereid(auth()->user()->id)->first();
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'success',
                        'details'=> $userDetails
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

    public function StripeUserCancelSubscription(Request $request){
        $validator = Validator::make($request->all(),[
            'subscription_id' => 'required|exists:user_subscriptions,id'
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
        $UserSubscription = UserSubscription::whereuser_id(auth()->user()->id)->whereIn('subscription_status',['active'])->where('id',$request->subscription_id)->orderBy('id','DESC')->first();
        if (!is_null($UserSubscription)) {
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $GetSubscription = $stripe->subscriptions->retrieve(
                $UserSubscription->subscription_id,
                []
              );
            // current period cancel subscription
            $UserSubscription->cancel_date = date('Y-m-d', strtotime("-1 day",$GetSubscription->current_period_end));
            $UserSubscription->subscription_status = 'cancel';
            // current period end date
            $UserSubscription->end_date = date('Y-m-d', $GetSubscription->current_period_end);
            $UserSubscription->save();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => 'Subscription cancelled successfully',
                'details'=> User::with('UserSubscription')->whereid(auth()->user()->id)->first()
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'No Active subscribtion'
            ]);
        }
    }
}
