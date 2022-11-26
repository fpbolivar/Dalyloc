<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRecipesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('recipes', function (Blueprint $table) {
            $table->id();
            $table->string('meal_category_id');
            $table->string('menu_type_id');
            $table->string('meal_cookware_id');
            $table->string('meal_name');
            $table->text('description')->nullable();
            $table->string('meal_cooking_timing');
            $table->string('meal_image')->nullable();
            $table->string('meal_calories')->nullable();
            $table->enum('is_deleted',['0','1'])->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('recipes');
    }
}
