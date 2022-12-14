<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserMealDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_meal_details', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->string('menu_type_id');                //one
            $table->string('allergies_id')->nullable();    //multiple
            $table->string('dislikes_id')->nullable();        //multiple
            $table->string('meal_size_id')->nullable();    //one 
            $table->enum('meal_notify', ['1', '0'])->default("0");
            $table->integer('meal_daily_count')->nullable();
            $table->time('meal_start_time')->nullable();
            $table->time('meal_end_time')->nullable();
            $table->enum('is_deleted',['0','1'])->default(0);
            $table->enum('is_notification',['0','1'])->default(1);
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
        Schema::dropIfExists('user_meal_details');
    }
}
