<?php
namespace App\Models\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\SubscriptionPlans;

class SubscriptionSubPlans extends Model
{
    protected $table="subscription_sub_plans";

    use HasFactory;

    public function Plan()
	{
	    return $this->belongsTo(SubscriptionPlans::class,'subscription_plan_id' ,'id');
	}
}
