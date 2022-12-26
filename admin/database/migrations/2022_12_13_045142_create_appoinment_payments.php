<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppoinmentPayments extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('appoinment_payments', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_booked_id')->nullable();
            $table->bigInteger('business_id');
            $table->bigInteger('business_user_id');
            $table->bigInteger('appt_id');
            $table->string('stripe_transaction_id');
            $table->enum('payment_status',['paid','partial'])->nullable();
            $table->string('payment_method')->nullable();
            $table->string('amount_paid')->nullable();
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
        Schema::dropIfExists('appoinment_payments');
    }
}