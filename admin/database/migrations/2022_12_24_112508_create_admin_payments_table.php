<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdminPaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('admin_payments', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('business_owner_id');
            $table->bigInteger('bank_id');
            $table->bigInteger('business_id');
            $table->string('bank_stripe_id');
            $table->string('admin_commission');
            $table->string('admin_amount');
            $table->string('total_amount');
            $table->string('business_owner_payment');
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
        Schema::dropIfExists('admin_payments');
    }
}
