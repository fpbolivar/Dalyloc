<?php

namespace App\Models\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Model\Recipe;


class UserMealPlan extends Model
{
    use HasFactory;
    public function UserMealPlanRecipes()
	{
	    return $this->hasMany(Recipe::class ,'id','recipe_id');
	}
}
