<?php
namespace App\Helper;

use App\Models\Model\Plan;
use App\Models\Model\PromoCode;
use App\Models\User;
/**
 *  Image Upload Helper
 */
class SubscriptionHelper 
{
	
	public function ApplyCouponCheck($promo_code,$plan_id)
	{
		$promoCode = PromoCode::where('name',$promo_code)->where('startdate','<=',date('Y-m-d'))->first();
		if (is_null($promoCode)) {
			return [
                    'status' => false,
                    'status_code' => true,
                    'message' => 'This promo code not started yet'
                ];
		}
		if (!is_null($promoCode->expiration) && date('Y-m-d') >  $promoCode->expiration) {
			return [
                    'status' => false,
                    'status_code' => true,
                    'message' => 'This promo code is Expired'
                ];
		}
		
		$plan = Plan::where('id',$plan_id)->first();
		$promoCodeAmount =  $promoCode->amount;
		$planAmount =  $plan->amount;
		if ($promoCodeAmount > $planAmount) {
			return [
                    'status' => false,
                    'status_code' => true,
                    'message' => 'This promo code is not applicable for this plan'
                ];
		}
		return [
	                'status' => true,
	                'status_code' => true
            ];
	}

	public function CheckCustomerId($user_id,$stripe_token,$stripe)
	{
		try {
			$User = User::whereid($user_id)->first();
			if (is_null($User->stripe_customer_id)) {
				$customer = $stripe->customers->create([
				  'email' => $User->email,
	              'source'=> $stripe_token
				]);
				$User->stripe_customer_id = $customer->id;
				$User->save();
				$customerId = $User->stripe_customer_id;
			}else{
				// changes in code
				$customer = $stripe->customers->retrieve(
				  $User->stripe_customer_id
				);
				$updatecustomer = $stripe->customers->update(
				  $customer->id ,
				  [
				  	'source'=> $stripe_token,
				  ]
				);
				$customerId = $updatecustomer->id;
			}
			return [
                    'status' => true,
                    'status_code' => true,
                    'customer_id' => $customerId
                ];
		} catch (\Exception $e) {
			return [
                    'status' => false,
                    'status_code' => true,
                    'message' => $e->getMessage()
                ];
		}
	}


	public function CreateSubscriptionData($subscriptionData)
	{
		$arrayCreate = [
		  'customer' => $subscriptionData['customer_id'],
		  'items' => [
		    ['plan' => $subscriptionData['plan_id']],
		  ],
		];
		if ($subscriptionData['trial_period_days'] > 0) {
			$arrayCreate['trial_period_days'] = $subscriptionData['trial_period_days'];
		}
		if (!is_null($subscriptionData['coupon'])) {
			$arrayCreate['coupon'] = $subscriptionData['coupon'];
		}
		return $arrayCreate;
	}

	public function GetSubscriptionDates($planData)
	{
		// $date = date('Y-m-d h:i:s');
		$startDate = date('Y-m-d');
		$endDate = '';
        // $startDate = date('Y-m-d H:i:s', strtotime($date . ' +'.$trailDays.' day'));
        if ($planData->type == 'monthly') {
			$endDate = date('Y-m-d', strtotime('+1 month', strtotime($startDate)));
            // $endDate = date('Y-m-d H:i:s', strtotime($startDate . ' +1 month '.$planData->type.''));
        }elseif ($planData->type == 'annually') {
			$endDate = date('Y-m-d', strtotime('+1 year', strtotime($startDate)));
            // $endDate = date('Y-m-d H:i:s', strtotime($startDate . ' +'.$planData->interval_count.' '.$planData->type.''));
        }
        return ['start_date'=>$startDate,'expire_date'=>$endDate];
	}

}