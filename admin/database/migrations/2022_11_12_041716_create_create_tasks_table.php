<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCreateTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('create_tasks', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('t_id');
            $table->string('email')->nullable();
            $table->string('task_name')->nullable();
            $table->string('utc_date_time')->nullable();
            $table->bigInteger('user_id');
            $table->bigInteger('task_time_stamp')->nullable();
            $table->bigInteger('create_time_stamp')->nullable();
            $table->enum('how_long',['1m','15m','30m','45m','1h','1.5h'])->nullable();
            $table->enum('how_often',['once','daily','weekly','monthly'])->nullable();
            $table->text('note')->nullable();
            $table->boolean('is_completed')->nullable();
            $table->string('task_type')->nullable();
            $table->string('location')->nullable();
            $table->double('lat',15,8)->nullable();
            $table->double('lng',15,8)->nullable();
            // $table->json('subNotes')->nullable();
            $table->date('date_format')->nullable();
            $table->string('start_task_time')->nullable();
            $table->string('end_task_time')->nullable();
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
        Schema::dropIfExists('create_tasks');
    }
}
