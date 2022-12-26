<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserBusinessTiming extends Model
{
    protected $table = "user_business_timing";
    protected $fillable = [
        'day',
        'isClosed',
        'open_time',
        'close_time'
    ];
    use HasFactory;

    // public function getOpenTimeAttribute($value) {
    //     if($value){
    //     return date('H:i A',strtotime($value));
    //     }
    // }

    // public function getCloseTimeAttribute($value) {
    //     if($value){
    //     return date('H:i A',strtotime($value));
    //     }
    // }
}
