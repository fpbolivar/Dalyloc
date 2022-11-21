<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSubscriptionSubPlansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subscription_sub_plans', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('subscription_plan_id');
            $table->string('name')->nullable();
            $table->text('description')->nullable();
            $table->string('amount');
            $table->enum('type_of_operation',['meal','exercise','devotional','smart','business']);
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
        Schema::dropIfExists('subscription_sub_plans');
    }
}
