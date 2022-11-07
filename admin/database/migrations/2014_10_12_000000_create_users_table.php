<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->nullable();
            $table->string('date_of_birth')->nullable();
            $table->string('gender')->nullable();
            $table->string('age')->nullable();
            $table->string('height_feet')->nullable();
            $table->string('height_inch')->nullable();
            $table->string('weight')->nullable();
            $table->string('phone_no')->unique();
            $table->string('profile_image')->nullable();
            $table->string('google_id')->nullable();
            $table->string('facebook_id')->nullable();
            $table->string('password');
            $table->string('device_id')->nullable();
            $table->string('device_token')->nullable();
            $table->text('old_token')->nullable();
            $table->enum('device_type',['ios','android'])->nullable();
            $table->enum('login_type',['google','facebook','mannual','apple'])->nullable();
            $table->enum('is_deleted', ['1', '0'])->default("0");
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
        Schema::dropIfExists('users');
    }
}
