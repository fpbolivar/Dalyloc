<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserAppointmentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_appointment', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('booked_user_id');
            $table->string('booked_user_name');
            $table->string('booked_user_phone_no');
            $table->string('booked_user_email');
            $table->string('booked_user_message');
            $table->enum('appt_status',['pending','rejected','accepted']);
            $table->date('appt_date');
            $table->string('appt_start_time');
            $table->string('appt_end_time');
            $table->bigInteger('business_id');
            $table->bigInteger('business_user_id');
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
        Schema::dropIfExists('user_appointment');
    }
}
