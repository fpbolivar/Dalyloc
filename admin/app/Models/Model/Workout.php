<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\WorkoutLevel;
use App\Models\Model\WorkoutExercise;


class Workout extends Model
{
    use HasFactory;
    public function workoutlevel()
    {
	    return $this->hasOne(WorkoutLevel::class ,'id','level_id');
	}

    public function WorkoutExercise()
	{
	    return $this->hasOne(WorkoutExercise::class ,'workout_id','id');
	}

}
