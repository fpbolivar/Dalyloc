<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class BusinessBank extends Model
{
    protected $table = 'business_bank';
    use HasFactory;
    public function User()
    {
        return $this->hasone(User::class,'id','user_id');
    }
}
