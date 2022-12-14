<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class NotificationLogRecord extends Model
{
    use HasFactory;
    public function User()
	{
	    return $this->hasOne(User::class,'id' ,'user_id');
	}
}
