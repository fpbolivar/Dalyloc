<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\MealIngredient;
use App\Models\Model\MealInstruction;


class Recipe extends Model
{
    use HasFactory;
    public function Ingredients()
	{
	    return $this->hasMany(MealIngredient::class ,'recipe_id','id');
	}
    public function Instructions()
	{
	    return $this->hasMany(MealInstruction::class ,'recipe_id','id')->orderBy('step_no', 'ASC');
	}
}
