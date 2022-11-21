<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\SubscriptionSubPlans;

class SubscriptionPlans extends Model
{
    protected $table="subscription_plans";

    use HasFactory;

    public function SubscriptionSubPlans()
	{
	    return $this->hasMany(SubscriptionSubPlans::class,'subscription_plan_id' ,'id');
	}

    public function SubscriptionSubPlan()
	{
	    return $this->hasOne(SubscriptionSubPlans::class,'subscription_plan_id' ,'id')->where('type_of_operation','type_of_operation');
	}
}
