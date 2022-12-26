<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\UserBusiness;

class UserAppointment extends Model
{
    protected $casts = [
        'service_detail' => 'array',
    ];
    protected $table = 'user_appointment';
    use HasFactory;


    public function BusinessPlan()
    {
        return $this->hasOne(UserSubscription::class,'business_id','id')->orderBy('id','DESC');
    }

    public function UserBusiness()
    {
	    return $this->hasOne(UserBusiness::class ,'id','business_id');
	}
}
