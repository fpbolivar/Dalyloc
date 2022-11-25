<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWorkoutsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('workouts', function (Blueprint $table) {
            $table->id();
            $table->string('workout_name')->nullable();
            $table->string('workout_time')->nullable();
            $table->unsignedBigInteger('level_id')->nullable();
            $table->enum('is_deleted',['0','1'])->default(0);
            $table->timestamps();

            $table->foreign('level_id')->references('id')->on('workout_levels')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('workouts');
    }
}
