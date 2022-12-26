<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Models\Model\BusinessBank;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Stripe\Stripe;
use App\Helper\PushHelper;
class BusinessBankStatusCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'bank:status';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Check and Update business bank status if every detail is fullfilled in stripe the are schedule every 10 min';

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
    public function handle(PushHelper $helper)
    {
        try{
            $business = BusinessBank::with('User')->where('bank_status','0')->get();
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            if(!$business->isEmpty()){
                foreach($business as $key){
                    $userId = $key->User->id;
                    $deviceToken = $key->User->device_token;
                    $title = 'Bank Status';
                    $msg = '';
                    $notification_type = 'testing';
                    $notification_source = 'Stripe';
                    $account = $stripe->accounts->retrieve(
                            $key->bank_stripe_id,
                            []
                            );
                            if($account->payouts_enabled == true){
                            $key->bank_status = '1';
                            $key->bank_reason = null;
                            $key->save();
                            $msg = 'Your Bank is verified successfully.';
                            if (!empty($deviceToken)) {
                                $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                            }
                            }else{
                                    if(count($account->requirements->errors) != 0){
                                        $key->bank_reason = $account->requirements->errors[0]->reason ;
                                        $key->save();
                                    }else{
                                        $key->bank_reason = 'Something not cleared.';
                                    }
                                    if($key->bank_reason == null){
                                        $msg = 'Your Bank is not verified as '.$account->requirements->errors[0]->reason;
                                        $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                                    }
                            }
                }
            }
         $this->info('Success');
        }catch(\Exception $e){
            $this->info('Error');
        }
    }
}
