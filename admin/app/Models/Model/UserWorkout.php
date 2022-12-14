<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\Workout;

class UserWorkout extends Model
{
    use HasFactory;
    public function UserWorkout()
	{
	    return $this->hasMany(Workout::class ,'id','workout_id');
	}
}
