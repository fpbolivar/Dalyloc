<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Recipe;
use App\Models\Model\MealCategory;
use App\Models\Model\MenuType;
use App\Models\Model\MealCookware;
use App\Models\Model\Ingredient;
use App\Models\Model\MealIngredient;
use App\Models\Model\MealInstruction;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class RecipeController extends Controller
{
    public function Index(){
        $getData=Recipe::where('is_deleted', '0')->get();
        return view('admin.recipes.index',compact('getData'));
    }

	public function ViewRecipe($id) {
		$recipe = Recipe::with('ingredients','instructions')->find($id)->toArray();
		$meal_category_id = explode(',', $recipe['meal_category_id']);
		$meal_categories = MealCategory::whereIn('id', $meal_category_id)->pluck('name')->toArray();
		$recipe['meal_category_id'] = implode(', ', $meal_categories);
		$menu_type_id = explode(',', $recipe['menu_type_id']);
		$menu_types = MenuType::whereIn('id', $menu_type_id)->pluck('name')->toArray();
		$recipe['menu_type_id'] = join(', ', $menu_types);
		$meal_cookware_id = explode(',', $recipe['meal_cookware_id']);
		$meal_cookware = MealCookware::whereIn('id', $meal_cookware_id)->pluck('name')->toArray();
		$recipe['meal_cookware_id'] = join(', ', $meal_cookware);
		foreach($recipe['ingredients'] as $index => $key) {
			$recipe['ingredients'][$index]['ingredient'] = Ingredient::where('id', $key['ingredient'])->pluck('name')[0];
		}
		// dd($recipe);
		return view('admin.recipes.viewrecipe', compact('recipe'));
	}

    public function AddRecipe(Request $request, ImageHelper $imageHelper){
        if($request->isMethod('post')){
           
            $this->validate($request, [
                'meal_name' => 'required',
                'meal_category' => 'required',
                'menu_type' => 'required',
                'meal_cookware' => 'required',
                'cooking_time' => 'required',
                'meal_image' => 'mimes:jpeg,png,jpg',
                'calorie_count' => 'required'
            ]);

            $recipe =  new Recipe;
            $recipe->meal_name = $request->meal_name;
            $recipe->meal_category_id = $request->meal_category;
            $recipe->menu_type_id = $request->menu_type;
            $recipe->meal_cookware_id = $request->meal_cookware;
            $recipe->meal_cooking_timing = $request->cooking_time;
            $recipe->meal_calories = $request->calorie_count;
            if($request->has('meal_image')){
                $path = '/images/recipes';
                $recipe->meal_image = $imageHelper->UploadImage($request->meal_image,$path);
            }    
            if($recipe->save()){
                for ($i=0; $i < count($request->ingredients); $i++) { 
                    $ingredient = new MealIngredient;
                    $ingredient->recipe_id = $recipe->id;
                    $ingredient->ingredient = $request->ingredients[$i];
                    $ingredient->quantity = $request->quantity[$i]; 
                    $saveIngredient = $ingredient->save();
                }
                for ($i=0; $i < count($request->step); $i++) { 
                    $instruction = new MealInstruction;
                    $instruction->recipe_id = $recipe->id;
                    $instruction->step_no = $request->step[$i];
                    $instruction->description = $request->instruction[$i]; 
                    $saveInstruction = $instruction->save();
                }
                if($saveIngredient && $saveInstruction){
                    return redirect('admin/recipes')->with('success', 'Recipe created successfully.');
                }
            }else{
                return redirect('admin/recipes')->with('error', 'Something went wrong.');
            }
        }
        else {
            $meal_categories = MealCategory::where('is_deleted', '0')->get()->toArray();
            $menu_types = MenuType::where('is_deleted', '0')->get()->toArray();
            $meal_cookware = MealCookware::where('is_deleted', '0')->get()->toArray();
            $ingredients = Ingredient::where('is_deleted', '0')->get()->toArray();
            return view('admin.recipes.addrecipe', compact('meal_categories', 'menu_types', 'meal_cookware', 'ingredients'));
        }
        
    }

    public function DeleteRecipe($id)
    {

        $recipe = Recipe::find($id);
        $recipe->is_deleted = "1";
        $recipe->save();
        $ingredients = MealIngredient::where('recipe_id', $id)->get();
        foreach($ingredients as $ingredient) {
            $ingredient->is_deleted = '1';
            $ingredient->save();
        }
        $instructions = MealInstruction::where('recipe_id', $id)->get();
        foreach($instructions as $instruction) {
            $instruction->is_deleted = '1';
            $instruction->save();
        }
        return redirect('admin/recipes')->with('success', 'Recipe deleted successfully.');
    }

    public function EditRecipe(Request $request, $id, ImageHelper $imageHelper){
        $editRecipe = Recipe::where('id',$id)->first();
        $editMealIngredients = MealIngredient::where('recipe_id', $id)->where('is_deleted', '0')->get();
        $editMealInstructions = MealInstruction::where('recipe_id', $id)->where('is_deleted', '0')->get();
        $meal_categories = MealCategory::where('is_deleted', '0')->get()->toArray();
        $menu_types = MenuType::where('is_deleted', '0')->get()->toArray();
        $meal_cookware = MealCookware::where('is_deleted', '0')->get()->toArray();
        $ingredients = Ingredient::where('is_deleted', '0')->get()->toArray();
        if ($request->isMethod('post')) {
            $this->validate($request, [
                'meal_name' => 'required',
                'meal_category' => 'required',
                'menu_type' => 'required',
                'meal_cookware' => 'required',
                'cooking_time' => 'required',
                'meal_image' => 'mimes:jpeg,png,jpg',
                'calorie_count' => 'required'
            ]);
            // dd($request->all());
            
            $updateIngredients = [];
			foreach($editMealIngredients as $editMealIngredient) {
				$editMealIngredient->is_deleted = '1';
				$editMealIngredient->save();
			}
            for ($i=0; $i < count($request->ingredients); $i++) {                
                $checkId =[];
                if(!empty($request->mealingredientsids[$i])){
                    $checkId = $request->mealingredientsids[$i];
                }else{
                    $checkId = '0';
                }

                $updateIngredients[] = array('ingredientid' =>$checkId,
                                            'recipe_id' => $id,
                                            'ingredient' => $request->ingredients[$i],
                                            'quantity' => $request->quantity[$i],
                                        );
            }
            foreach ($updateIngredients as $key) {
                if ($key['ingredientid'] == '0') {
                    $ingredient = new MealIngredient;
                    $ingredient->recipe_id = $key['recipe_id'];
                    $ingredient->ingredient = $key['ingredient'];
                    $ingredient->quantity = $key['quantity']; 
                    $ingredient->save();                    
                }else{
					$ingredient =  MealIngredient::find($key['ingredientid']);
					$ingredient->recipe_id = $key['recipe_id'];
                    $ingredient->ingredient = $key['ingredient'];
                    $ingredient->quantity = $key['quantity']; 
					$ingredient->is_deleted = '0';
                    $ingredient->save();
               	}
            }

			$updateInstructions = [];
			foreach($editMealInstructions as $editMealInstruction) {
				$editMealInstruction->is_deleted = '1';
				$editMealInstruction->save();
			}
            for ($i=0; $i < count($request->step); $i++) {
                
                $checkId =[];
                if(!empty($request->mealinstructionsids[$i])){
                    $checkId = $request->mealinstructionsids[$i];
                }else{
                    $checkId = '0';
                }

                $updateInstructions[] = array('instructionid' =>$checkId,
                                            'recipe_id' => $id,
                                            'step_no' => $request->step[$i],
                                            'description' => $request->instruction[$i],
                                        );
            }
            foreach ($updateInstructions as $key) {
                if ($key['instructionid'] == '0') {
                    $instruction = new MealInstruction;
                    $instruction->recipe_id = $key['recipe_id'];
                    $instruction->step_no = $key['step_no'];
                    $instruction->description = $key['description']; 
                    $instruction->save();                    
                }else{
					$instruction =  MealInstruction::find($key['instructionid']);
					$instruction->recipe_id = $key['recipe_id'];
                    $instruction->step_no = $key['step_no'];
                    $instruction->description = $key['description']; 
                    $instruction->is_deleted = '0'; 
                    $instruction->save();
               	}
            }

            //if has image
            if($request->has('meal_image') && $request->meal_image != ''){
                $path = '/images/recipes';
                $editRecipe->meal_name = $request->meal_name;
                $editRecipe->meal_category_id = $request->meal_category;
                $editRecipe->menu_type_id = $request->menu_type;
                $editRecipe->meal_cookware_id = $request->meal_cookware;
                $editRecipe->meal_cooking_timing = $request->cooking_time;
                $editRecipe->meal_calories = $request->calorie_count;
                if($editRecipe->meal_image != null){
                    $imagePath = public_path($editRecipe->meal_image);
                    if(File::exists($imagePath)){
                        unlink($imagePath);
                    }
                }
                $editRecipe->meal_image = $imageHelper->UploadImage($request->meal_image,$path);
                if($editRecipe->save()){
                    return redirect('admin/recipes')->with('success', 'Recipe updated successfully.');
                }else{
                    return redirect('admin/recipes')->with('error', 'Something went wrong.');
                }

            }
            else{
                $editRecipe->meal_name = $request->meal_name;
                $editRecipe->meal_category_id = $request->meal_category;
                $editRecipe->menu_type_id = $request->menu_type;
                $editRecipe->meal_cookware_id = $request->meal_cookware;
                $editRecipe->meal_cooking_timing = $request->cooking_time;
                $editRecipe->meal_calories = $request->calorie_count;
                if($request->isDeleted == 1){
                    $check = $imageHelper->CheckFile($editRecipe->image, 1);
                    $editRecipe->image = null;
                }
                if($editRecipe->save()){
                    return redirect('admin/recipes')->with('success', 'Recipe updated successfully.');
                }else{
                    return redirect('admin/recipes')->with('error', 'Something went wrong.');
                }
            }
        }else{
            return view('admin.recipes.editrecipe',compact('editRecipe', 'editMealIngredients', 'editMealInstructions', 'meal_categories', 'menu_types', 'meal_cookware', 'ingredients')); 
        }
    }
}
