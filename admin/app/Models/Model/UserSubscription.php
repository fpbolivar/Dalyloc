<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\SubscriptionSubPlans;

class UserSubscription extends Model
{
    use HasFactory;
    public function Detail()
	{
	    return $this->hasMany(SubscriptionSubPlans::class ,'id','sub_plan_id');
	}
}
