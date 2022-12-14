<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserSubscriptionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_subscriptions', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->bigInteger('plan_id');
            $table->bigInteger('sub_plan_id');
            $table->enum('plan_type',['monthly','annually']);
            $table->enum('plan_operation',['meal','exercise','devotional','business']);
            $table->enum('subscription_type',['apple_pay','stripe','google']);
            $table->enum('subscription_status',['active','cancel','expired']);
            $table->string('amount');
            $table->text('purchase_token')->nullable();              //when type is google
            $table->string('subscription_id')->nullable();           //when type is google or stripe
            $table->string('apple_subscription_id')->nullable();     //when type is apple_pay 
            $table->string('apple_unique_id')->nullable(); 
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->date('cancel_date')->nullable();                //when subscription status is cancel
            $table->bigInteger('promo_code_id')->nullable();
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
        Schema::dropIfExists('user_subscriptions');
    }
}
