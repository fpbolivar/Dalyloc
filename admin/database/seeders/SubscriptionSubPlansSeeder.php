<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Model\SubscriptionSubPlans;

class SubscriptionSubPlansSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $plans=[
            ['id' => 1, 'subscription_plan_id' => 1, 'subscription_price_id' => '64646474964894','type'=>'annually','name'=>'Meal Plans', 'description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n', 'amount'=>50,'type_of_operation'=>'meal'],
            ['id' => 2, 'subscription_plan_id' => 1, 'subscription_price_id' => '5454644167494849844','type'=>'monthly','name'=>'Meal Plans','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>20,'type_of_operation'=>'meal'],
            ['id' => 3, 'subscription_plan_id' => 2, 'subscription_price_id' => '546464684684864846','type'=>'annually','name'=>'Exercise','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>50,'type_of_operation'=>'exercise'],
            ['id' => 4, 'subscription_plan_id' => 2, 'subscription_price_id' => '564684898498+41+9','type'=>'monthly','name'=>'Exercise','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>20,'type_of_operation'=>'exercise'],
            ['id' => 5, 'subscription_plan_id' => 3, 'subscription_price_id' => '43546443865344','type'=>'annually','name'=>'Devotional Plan','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>50,'type_of_operation'=>'devotional'],
            ['id' => 6, 'subscription_plan_id' => 3, 'subscription_price_id' => '3455436454363446','type'=>'monthly','name'=>'Devotional Plan','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>20,'type_of_operation'=>'devotional'],
            ['id' => 7, 'subscription_plan_id' => 4, 'subscription_price_id' => '3544553444346543464553','type'=>'annually','name'=>'Business Pro','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>50,'type_of_operation'=>'business'],
            ['id' => 8, 'subscription_plan_id' => 4, 'subscription_price_id' => '543456344564436544','type'=>'monthly','name'=>'Business Pro','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>20,'type_of_operation'=>'business'],
            ['id' => 9, 'subscription_plan_id' => 4, 'subscription_price_id' => '','type'=>'monthly','name'=>'Business Pro','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>20,'type_of_operation'=>'business'],
            ['id' => 10, 'subscription_plan_id' => 1, 'subscription_price_id' => '','type'=>'free','name'=>'Meal Plans','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>0,'type_of_operation'=>'meal'],
            ['id' => 11, 'subscription_plan_id' => 2, 'subscription_price_id' => '','type'=>'free','name'=>'Exercise','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>0,'type_of_operation'=>'exercise'],
            ['id' => 12, 'subscription_plan_id' => 3, 'subscription_price_id' => '','type'=>'free ','name'=>'Devotional Plan','description'=>'<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>\r\n\r\n','amount'=>0,'type_of_operation'=>'devotional'],
        ];
        foreach ($plans as $plan) {
            SubscriptionSubPlans::create($plan);
        }
        $this->command->info('Subscription sub plans table seeded!');
    }
}
