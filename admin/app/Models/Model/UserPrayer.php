<?php

namespace App\Models\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Model\UserPrayerResponse;

class UserPrayer extends Model
{
    use HasFactory;
    public function UserName()
	{
	    return $this->hasOne(User::class,'id' ,'user_id');
	}
	public function PrayerResponse()
	{
	    return $this->hasMany(UserPrayerResponse::class,'user_prayer_id','id');
	}
}
