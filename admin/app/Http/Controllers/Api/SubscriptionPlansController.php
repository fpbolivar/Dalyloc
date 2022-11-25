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

class SubscriptionPlansController extends Controller
{
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
                'message' => 'No Plans are there'
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
                'message' => 'No Plans are there'
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
        $checkSubscription = UserSubscription::whereuser_id(auth()->user()->id)->where('plan_operation',$request->plan_operation)->first();
        $today = date('Y-m-d');
        if($checkSubscription != null){
            $isActive = 0;
            if($checkSubscription->end_date >= $today && $checkSubscription->subscription_status == 'active')
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
                'message' => 'No data found'
            ]);
        }



    }
    public function StripeUserSubscription(Request $request, SubscriptionHelper $helper){
        $validator = Validator::make($request->all(),[
            'plan_id' => 'required|exists:subscription_plans,id',
            'type' => 'required',
            'transaction_id' => 'required',
            // 'promo_code' => 'nullable|exists:promo_codes,name',
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
            $AlreadyActiveSubscription = UserSubscription::whereuser_id(auth()->user()->id)->whereIn('subscription_status',['active'])->where('plan_id',$request->plan_id)->orderBy('id','DESC')->first();
            if (!is_null($AlreadyActiveSubscription)) {
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Already subscribed to a plan.'
                ]);
            }else{
                $plan = SubscriptionPlans::where('id',$request->plan_id)->first();
                $plan_detail = SubscriptionSubPlans::where('subscription_plan_id',$request->plan_id)->where('type',$request->type)->first();
                // dd($plan_detail->type_of_operation);
                $subscriptionDate = $helper->GetSubscriptionDates($plan_detail);
                $userSubscription = new UserSubscription;
                $userSubscription->user_id = auth()->user()->id;
                $userSubscription->plan_id  = $request->plan_id;
                $userSubscription->sub_plan_id  = $plan_detail->id;
                $userSubscription->plan_type  = $plan_detail->type;
                $userSubscription->plan_operation  = $plan_detail->type_of_operation;
                $userSubscription->subscription_id  = $request->transaction_id;
                // $userSubscription->promo_code_id = $promo_code_id;
                $userSubscription->start_date  = $subscriptionDate['start_date'];
                $userSubscription->end_date  = $subscriptionDate['expire_date'];
                $userSubscription->amount  =  $plan_detail->amount;
                $userSubscription->subscription_status  = 'active';
                $userSubscription->subscription_type  = 'stripe';
                $userSubscription->save();

                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'success',
                    'details'=> User::with('UserSubscription')->whereid(auth()->user()->id)->first()
                ]);
            }


        }catch (\Exception $e) {
            return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => $e->getMessage()
                ]);
        }
    }

    public function StripeUserCancelSubscription(Request $request){
        $validator = Validator::make($request->all(),[
            'plan_id' => 'required|exists:subscription_plans,id',
            // 'promo_code' => 'nullable|exists:promo_codes,name',
        ]);
         // if validation fails
    	if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        } 
        $UserSubscription = UserSubscription::whereuser_id(auth()->user()->id)->whereIn('subscription_status',['active'])->where('plan_id',$request->plan_id)->orderBy('id','DESC')->first();
        if (!is_null($UserSubscription)) {
            // $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET'));
            // $cancelSubscription = $stripe->subscriptions->cancel($UserSubscription->subscription_id);
            // $UserSubscription->subscription_status = $cancelSubscription->status;
            $UserSubscription->subscription_status = 'cancel';
            $UserSubscription->cancel_date = date('Y-m-d');
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
