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
            $table->string('stripe_customer_id')->nullable();
            $table->string('name');
            $table->string('email')->nullable();
            $table->string('date_of_birth')->nullable();
            $table->string('gender')->nullable();
            // $table->string('age')->nullable();
            // $table->string('height_feet')->nullable();
            $table->string('height')->nullable();
            $table->time('wake_up')->nullable();
            $table->string('weight')->nullable();
            $table->string('otp')->nullable();
            $table->string('country_code')->nullable();
            $table->string('phone_no')->unique();
            $table->datetime('phone_verified_at')->nullable();
            $table->string('profile_image')->nullable();
            $table->string('google_id')->nullable();
            $table->string('facebook_id')->nullable();
            $table->string('password');
            $table->string('device_id')->nullable();
            $table->string('device_token')->nullable();
            $table->text('old_token')->nullable();
            $table->enum('prayer_notify', ['1', '0'])->default("0");
            $table->integer('prayer_daily_count')->nullable();
            $table->time('prayer_start_time')->nullable();
            $table->time('prayer_end_time')->nullable();
            $table->enum('device_type',['ios','android'])->nullable();
            $table->enum('login_type',['google','facebook','manual','apple'])->nullable();
            $table->boolean('is_24_format')->default(1);
            $table->enum('is_deleted', ['1', '0'])->default("0");
            $table->enum('exercise_notify', ['1', '0'])->default("0");
            $table->time('exercise_start_time')->nullable();
            $table->time('exercise_end_time')->nullable();
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
