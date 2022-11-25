<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\Workout;
use App\Models\Model\Exercise;

class WorkoutExercise extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [
        'workout_id'=>'integer',
        'exercise_id'=>'string',
    ];
    
    public function workout()
    {
	    return $this->hasOne(Workout::class ,'id','workout_id');
	}
    
}
