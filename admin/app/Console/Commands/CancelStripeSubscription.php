<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Model\UserSubscription;

class CancelStripeSubscription extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'cancel:stripeSubscription';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'cancel stripe subscritpions daily at 00:01 AM';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        try{
            $today = date('Y-m-d');
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $UserSubscription = UserSubscription::select('id',"subscription_id")->where("end_date",$today)->where("end_date","<=",$today)->where("subscription_type","stripe")->whereIn('subscription_status',['active'])->get();
            if (count($UserSubscription) > 0) {
                foreach ($UserSubscription as $subscription) {
                    $stripe->subscriptions->cancel(
                        $subscription->subscription_id,
                        []
                    );
                    UserSubscription::whereid($subscription->id)->update(['subscription_status'=>'cancel']);
                }
            }
            $this->info('success');
        }catch(\Exception $e){
            $this->info('Error');
        }
    }
}
