<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCreateSubtasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('create_subtasks', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('create_task_id');
            $table->bigInteger('user_id');
            $table->bigInteger('s_id');
            $table->text('description');
            $table->date('date_format')->nullable();
            $table->boolean('is_completed');
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
        Schema::dropIfExists('create_subtasks');
    }
}
