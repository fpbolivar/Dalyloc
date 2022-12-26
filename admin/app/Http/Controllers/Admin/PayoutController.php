<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Model\UserAppointment;
use Illuminate\Http\Request;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Session;
use Stripe;

class PayoutController extends Controller
{
    private $stripe;
    public function __construct()
    {
        $this->stripe =new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
    }

     /**
     * pending payout view file
     */
    public function PendingPayout(){
        //get all pending payout list 
        $getData = UserAppointment::with('UserBusiness','UserBusiness.User','UserBusiness.User.BusinessBank')->where('payout_status','paid')->get();
        // dd($getData);
        // index view  file     
        // foreach($getData as $service){ 
        //     $getData['total']
            
            // dd($service->service_detail);
        // }

           
        return view('admin.payouts.pending',compact('getData'));
    }

    /**
     * history payout view file
     */
    public function HistoryPayout(){
        //get payout history list 
        $getData = UserAppointment::with('UserBusiness','UserBusiness.User')->where('payout_status','paid')->get();
        // index view  file     
        return view('admin.payouts.history',compact('getData'));
    }

    public function AdminPayout($id){
        $getData = UserAppointment::with('UserBusiness','UserBusiness.User','UserBusiness.User.BusinessBank')->where('id',$id)->where('appt_status','completed')->where('payout_status','paid')->first();
        if($getData){
            
            $service_detail = $getData->service_detail;
            $bank_stripe_id =$getData->UserBusiness->User->BusinessBank ? $getData->UserBusiness->User->BusinessBank->bank_stripe_id :"";
            $service_price = 0;
            foreach($service_detail as $service){
                if($service['service_price'] != 0){
                    $price = $service['service_price'];
                    $service_price += $price;
                }
            }

            if($service_price != 0 &&  !empty($bank_stripe_id)){
                // $transfers = $this->PaymentTransfers($service_price,$bank_stripe_id);
                // dd($transfers);

            }
           
        }


    }


    public function PaymentTransfers($amount,$bank){
        $stripe =new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
    

        // dump($amount);
        // dd($bank);
       $transfers =  $stripe->transfers->create([
            'amount' => $amount *100,
            'currency' => 'usd',
            'destination' => $bank,
            // 'transfer_group' => 'ORDER_95',
          ]);
         return $transfers;

    }
}
