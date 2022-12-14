<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class UserMealDetail extends Model
{
    use HasFactory;

    public function UserName()
	{
	    return $this->hasOne(User::class,'id' ,'user_id');
	}
}
