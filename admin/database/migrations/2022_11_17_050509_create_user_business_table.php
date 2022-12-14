<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserBusinessTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_business', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->bigInteger('business_category_id');
            $table->string('business_name');
            $table->string('business_img')->nullable();
            $table->string('business_email');
            $table->enum('online_booking',['0','1'])->default(1);
            $table->bigInteger('is_acceptance')->default(1);
            $table->enum('is_active_payment',['0','1'])->default(1);
            $table->string('business_address')->nullable();
            $table->double('lat',15,8)->nullable();
            $table->double('lng',15,8)->nullable();
            $table->string('slot_interval')->default(15);
            $table->string('deposit_percentage')->nullable();
            $table->string('slug');
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
        Schema::dropIfExists('user_business');
    }
}
