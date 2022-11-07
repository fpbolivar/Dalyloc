<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Model;

class UserResetPassword extends Model
{
    protected $table="user_reset_passwords";

    protected $fillable = [
        'phone_no', 'otp'
    ];
}
