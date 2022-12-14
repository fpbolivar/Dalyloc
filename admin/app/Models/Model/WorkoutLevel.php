<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\Workout;

class WorkoutLevel extends Model
{
    use HasFactory;
    public function AllWorkout()
	{
	    return $this->hasMany(Workout::class ,'level_id','id')->select('*');
	}
	public function ActiveWorkout()
	{
	    return $this->hasMany(Workout::class ,'level_id','id')->select('*')->where('is_deleted','0');
	}
}
