<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNotificationLogRecordsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('notification_log_records', function (Blueprint $table) {
            $table->id();
            $table->string('notification_date')->nullable();
            $table->string('notification_title')->nullable();
            $table->string('data_payload')->nullable();
            $table->string('notification_type')->nullable();
            $table->string('notification_description')->nullable();
            $table->string('notification_source')->nullable();
            $table->enum('is_read',['0','1'])->default(0);
            $table->string('send_by')->nullable();
            $table->bigInteger('send_by_id')->nullable();
            $table->string('send_to')->nullable();
            $table->bigInteger('send_to_id')->nullable();
            $table->bigInteger('event_id')->nullable();
            $table->bigInteger('business_id')->nullable();
            $table->bigInteger('business_owner_id')->nullable();
            $table->string('message')->nullable();
            $table->string('status')->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('notification_log_records');
    }
}
