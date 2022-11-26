<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserMealPlansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_meal_plans', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->string('recipe_id');
            $table->string('name')->nullable();
            $table->date('cooking_date');
            $table->enum('reminder',['0','1'])->default(1);
            $table->enum('is_completed',['0','1'])->default(0);
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
        Schema::dropIfExists('user_meal_plans');
    }
}
