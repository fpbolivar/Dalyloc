<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\CreateSubtask;

class CreateTask extends Model
{
    use HasFactory;
    public function SubTaks()
	{
	    return $this->hasMany(CreateSubtask::class,'create_task_id' ,'id');
	}
}
