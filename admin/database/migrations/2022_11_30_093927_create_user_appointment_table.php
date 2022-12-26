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
            $table->string('booked_user_message')->nullable();
            $table->enum('appt_status',['pending','rejected','accepted','completed','cancelled','paid']);
            $table->enum('appt_from',['app','web'])->default('web');
            $table->date('appt_date');
            $table->string('appt_start_time');
            $table->string('appt_end_time');
            $table->bigInteger('business_id');
            $table->bigInteger('business_user_id');
            $table->string('amount_paid')->nullable();
            $table->string('pending_payment')->nullable();
            $table->string('total_payment')->nullable();
            $table->json('service_detail')->nullable();
            $table->string('admin_commission_percentage')->nullable();
            $table->string('admin_commission_amt')->nullable();
            $table->enum('payout_status',['unpaid','paid'])->nullable();
            $table->enum('is_rating',['0','1'])->default(0);
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
