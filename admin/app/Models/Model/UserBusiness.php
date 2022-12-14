<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\BusinessCategory;
use App\Models\Model\UserBusinessService;
use App\Models\Model\UserBusinessTiming;
use App\Models\User;


class UserBusiness extends Model
{
    protected $table = "user_business";
    use HasFactory;

    public function UserBusinessCategory()
    {
	    return $this->hasOne(BusinessCategory::class ,'id','business_category_id');
	}

    public function UserBusinessTiming()
    {
	    return $this->hasMany(UserBusinessTiming::class ,'business_id','id');
	}
	 public function UserBusinessService()
    {
	    return $this->hasOne(UserBusinessService::class ,'business_id','id');
	}

    public function User()
    {
	    return $this->hasOne(User::class ,'id','user_id');
	}
}
