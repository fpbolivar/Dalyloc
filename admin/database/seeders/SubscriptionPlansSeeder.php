<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Model\SubscriptionPlans;

class SubscriptionPlansSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $plans=[
            ['id' => 1, 'name' => 'Meal Plans', 'type_of_operation' => 'meal'],
            ['id' => 2, 'name' => 'Exercise', 'type_of_operation' => 'exercise'],
            ['id' => 3, 'name' => 'Devotional Plan', 'type_of_operation' => 'devotional'],
            ['id' => 4, 'name' => 'Business Pro', 'type_of_operation' => 'business'],
        ];
        foreach ($plans as $plan) {
            SubscriptionPlans::create($plan);
        }
        $this->command->info('Subscription plans table seeded!');
        //
    }
}
