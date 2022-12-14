<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\SubscriptionPlans;
use App\Models\Model\SubscriptionSubPlans;

class SubscriptionPlanController extends Controller
{
    public function Index(){
        $allSubscriptionPlans =  SubscriptionPlans::get();
        return view('admin.subscriptionplan.index',compact('allSubscriptionPlans'));
    }

    //Change subscription status
    public function DeleteSubscriptionPlan($id){
        $subscriptionPlan = SubscriptionPlans::find($id);
        $subscriptionSubPlans = SubscriptionSubPlans::where('subscription_plan_id',$id)->get();

        if ($subscriptionPlan->is_deleted == "1") {
            $subscriptionPlan->is_deleted = "0";
            $subscriptionPlan->save();
            //block all belonged sub plans 
            if(count($subscriptionSubPlans) != 0){
                $subscriptionSubPlan = $subscriptionSubPlans->toArray();
                $ids = array_column($subscriptionSubPlan, 'id');
                $updateData = SubscriptionSubPlans::whereIn('id',$ids)->update(['is_deleted' => '0']);
            }
            return redirect('admin/subscription-plan')->with('success', 'Subscription plan activated successfully.');
        } else {
            $subscriptionPlan->is_deleted = "1";
            $subscriptionPlan->save();
            if(count($subscriptionSubPlans) != 0){
                $subscriptionSubPlan = $subscriptionSubPlans->toArray();
                $ids = array_column($subscriptionSubPlan, 'id');
                $updateData = SubscriptionSubPlans::whereIn('id',$ids)->update(['is_deleted' => '1']);
            }
            return redirect('admin/subscription-plan')->with('success', 'Subscription Plan deactivated successfully.');
        }
    }

    //view subscription plan types
    public function ViewSubscriptionTypes($id){
        $subscriptionSubPlans = SubscriptionSubPlans::with('Plan')->where('subscription_plan_id',$id)->get();
        return view('admin.subscriptionplan.subscriptionsubplan',compact('subscriptionSubPlans'));
    }

    //delete subscription sub plan
    public function DeleteSubscriptionSubPlan($id){
        $subscriptionSubPlan = SubscriptionSubPlans::where('id',$id)->first();
        $subscriptionPlan = SubscriptionPlans::where('id',$subscriptionSubPlan->subscription_plan_id)->first();
        // if($subscriptionPlan->is_deleted){

        // }
        if ($subscriptionSubPlan->is_deleted == "1") {
            if($subscriptionPlan->is_deleted){
                    return back()->with('error', 'Subscription Main Plan is dectivated.Please activate that first.');
        }else{
            $subscriptionSubPlan->is_deleted = "0";
            $subscriptionSubPlan->save();
            return back()->with('success', 'Subscription Sub plan activated successfully.');
        }
        } else {
            $subscriptionSubPlan->is_deleted = "1";
            $subscriptionSubPlan->save();
            return back()->with('success', 'Subscription Sub Plan deactivated successfully.');
        }
    }

    //edit subscription sub plan
    public function EditSubscriptionSubPlan($id, Request $request){
        $subscriptionSubPlan = SubscriptionSubPlans::with('Plan')->where('id',$id)->first();
        $typePlan = SubscriptionSubPlans::groupBy('type')->get();
        if($request->isMethod('post')){
            $this->validate($request, [
                'name' => 'required',
                'description' => 'required',
                'type' => 'required',
                'amount' => 'required',
                'subscription_price_id' => 'required'
            ]);
             $mainPlanId = $subscriptionSubPlan->subscription_plan_id;
             $allSubplans = SubscriptionSubPlans::where('subscription_plan_id',$mainPlanId)->get();
             $allSubplan = $allSubplans->toArray();
             $existedTypes = array_column($allSubplan, 'type');
             if($request->type == $subscriptionSubPlan->type){
                $subscriptionSubPlan->name = $request->name;
                $subscriptionSubPlan->description = $request->description;
                $subscriptionSubPlan->amount = $request->amount;
                $subscriptionSubPlan->type = $request->type;
                $subscriptionSubPlan->subscription_price_id = $request->subscription_price_id;
                if($subscriptionSubPlan->save()){
                    return redirect('admin/subscription-types/'.$subscriptionSubPlan->subscription_plan_id)->with('success', 'Subscription Sub Plan updated successfully.');               
                }else{
                    return redirect('admin/subscription-types/'.$subscriptionSubPlan->subscription_plan_id)->with('error', 'Something went wrong.');               
                }
             }else{
                if (in_array($request->type, $existedTypes)){
                    return redirect()->back()->with('error', 'Plan type is already existed .');  
                 }    
             }
        }else{
            return view('admin.subscriptionplan.editsubscriptionsubplan',compact('subscriptionSubPlan','typePlan'));
        }
    }

    /**
     * edit subscription plan
     */
    public function EditSubscriptionPlan(Request $request, $id){
        $subscriptionPlan = SubscriptionPlans::where('id',$id)->first();
        if($request->isMethod('post')){
            $this->validate($request, [
                'name'=>'required',        
            ]);
            $subscriptionPlan->name = $request->name;
          
            if($subscriptionPlan->save()){
                return redirect('admin/subscription-plan')->with('success', 'Subscription  Plan updated successfully.');               
            }else{
                return redirect('admin/subscription-plan')->with('error', 'Something went wrong.');               
            }
        }else{

        return view('admin.subscriptionplan.editsubscriptionplan',compact('subscriptionPlan'));
        }
    }
}
