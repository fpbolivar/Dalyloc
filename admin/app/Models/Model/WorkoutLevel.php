<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\Workout;

class WorkoutLevel extends Model
{
    use HasFactory;
    public function Workout()
	{
	    return $this->hasMany(Workout::class ,'level_id','id');
	}
}
