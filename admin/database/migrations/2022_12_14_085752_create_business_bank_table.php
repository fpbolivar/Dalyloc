<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBusinessBankTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('business_bank', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->string('bank_stripe_id');
            $table->string('holder_name')->nullable();
            $table->string('account_holder_type')->nullable();
            $table->string('bank_name');
            $table->string('account_number');
            $table->string('routing_number');
            $table->string('city')->nullable();
            $table->string('state')->nullable();
            $table->string('country')->nullable();
            $table->string('postal_code')->nullable();
            $table->string('address')->nullable();
            $table->double('lat',15,8)->nullable();
            $table->double('lng',15,8)->nullable();
            $table->string('phone_number')->nullable();
            $table->string('currency')->nullable();
            $table->json('bank_reason')->nullable();
            $table->string('bank_status')->nullable();
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
        Schema::dropIfExists('business_bank');
    }
}
