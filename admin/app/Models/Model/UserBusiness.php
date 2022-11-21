<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\BusinessCategory;
use App\Models\Model\UserBusinessTiming;


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
}
