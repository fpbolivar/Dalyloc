<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Stripe\Stripe;
use Validator;
use App\Models\Model\BusinessBank;
use App\Models\User;

class BusinessBankController extends Controller
{
    public function AddBusinessBank(Request $request){
            // validate
            $validator = Validator::make($request->all(),[
                'bank_name' => 'required',
                'account_number' => 'required',
                'routing_number' => 'required',
                'country' => 'required',
                'account_holder_type' => 'required',
                'account_holder_name' => 'required'
            ]);
             // if validation fails
            if ($validator->fails()) {
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => $validator->messages()->first()
                ]);
            } 
            try{
                $userId = auth()->user()->id;
                $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
                $user = User::whereid(auth()->user()->id)->first();
                $dob = $user->date_of_birth;
                $year = date('Y', strtotime($dob));
                $month = date('m', strtotime($dob));
                $day = date('d', strtotime($dob));
                  $bank = $stripe->accounts->create([
                    'type'=> "custom",
                    'country'=> $request->country,
                    'email'=> $user->email,
                    'capabilities' => [
                        'card_payments' => ['requested' => true],
                        'transfers' => ['requested' => true],
                      ],
                      'external_account' => [
                        'object' => 'bank_account',
                        'account_number' => $request->account_number,
                        'country' => $request->country,
                        'currency' => 'usd',
                        'routing_number' => $request->routing_number,
                        'account_holder_name' => $request->account_holder_name,
                        'account_holder_type' => $request->account_holder_type
                      ],
                    'business_type'=> "individual",
                    'individual'=> [
                        'address'=> [
                            'city'=> $request->city,
                            'country'=> $request->country,
                            'line1'=> 'test1',
                            'line2'=> 'test2',
                            'postal_code'=> $request->postal_code,
                            'state'=> $request->state,
                        ],
                        'dob'=> [
                            'day'=> $day,
                            'month'=> $month,
                            'year'=> $year,
                        ],
                        'email'=> $user->email,
                        'first_name'=> $user->name,
                        'last_name'=> $user->name,
                        'phone'=> $user->phone_no,
                        'political_exposure'=> "none",
                        'ssn_last_4'=> "0000",
                        'id_number'=> "000000000",
                    ],
                    'business_profile'=> [
                        'name'=> $user->name,
                        'support_email'=> $user->email,
                        'support_phone'=> $user->phone_no,
                        'url'=> "https://scriptube.com/",
                        'mcc'=> "5399",
                        'support_address'=> [
                                'city'=> $request->city,
                                'country'=> $request->country,
                                'line1'=> 'test1',
                                'line2'=> 'test2',
                                'postal_code'=> $request->postal_code,
                                'state'=> $request->state,
                        ],
                    ],
                    'tos_acceptance'=> [
                        'date'=> time(),
                        'ip'=> '13.112.224.240',
                    ],
                ]);
                 $findBank = BusinessBank::where('user_id',$userId)->first();
                 if($findBank){
                    return response()->json([
                        'status' => false,
                        'status_code' => true,
                        'message' => "Bank is already connected.",
                    ]);
                 }
                    // $account = $stripe->accounts->retrieve(
                    //     $bank->id,
                    //     []
                    //   );
                    //   dd($account);
                    // $stripe->customers->verifySource(
                    //     $user->stripe_customer_id,
                    //     $costomer->id,
                    //   );
                    $createBank = new BusinessBank;
                    $createBank->bank_stripe_id = $bank->id;
                    $createBank->user_id= $userId;
                    $createBank->holder_name = $request->account_holder_name;
                    $createBank->account_holder_type = $request->account_holder_type;
                    $createBank->bank_name = $request->bank_name;
                    $createBank->account_number = $request->account_number;
                    $createBank->routing_number = $request->routing_number;
                    $createBank->phone_number = $user->phone_no;
                    $createBank->country = $request->country;
                    $createBank->city = $request->city;
                    $createBank->state = $request->state;
                    $createBank->postal_code = $request->postal_code;
                    $createBank->address = $request->address;
                    $createBank->currency = 'usd';
                    $createBank->bank_status = '0';
                    $createBank->save();
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => "Your bank account's details has been submitted for review",
                        'bank' => $bank,
                    ]);
                
            }catch(\Exception $e){
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => $e->getMessage()
                ]);
            }
        }

        //update bank
        public function UpdateBusinessBank(Request $request){
              // validate
              $validator = Validator::make($request->all(),[
                'bank_stripe_id' => 'required',
                'bank_name' => 'required',
                'account_number' => 'required',
                'routing_number' => 'required',
                'country' => 'required',
                'account_holder_type' => 'required',
                'account_holder_name' => 'required'
            ]);
             // if validation fails
            if ($validator->fails()) {
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => $validator->messages()->first()
                ]);
            } 
            $bank = BusinessBank::with('User')->where('bank_stripe_id',$request->bank_stripe_id)->first();
            $userId = auth()->user()->id;
            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));
            $dob = $bank->User->date_of_birth;
            $year = date('Y', strtotime($dob));
            $month = date('m', strtotime($dob));
            $day = date('d', strtotime($dob));
            if($bank){
                try{
                $updateBank = $stripe->accounts->update(
                    $request->bank_stripe_id,
                    [
                    'email'=> $bank->User->email,
                    'capabilities' => [
                        'card_payments' => ['requested' => true],
                        'transfers' => ['requested' => true],
                      ],
                      'external_account' => [
                        'object' => 'bank_account',
                        'account_number' => $request->account_number,
                        'country' => $request->country,
                        'currency' => 'usd',
                        'routing_number' => $request->routing_number,
                        'account_holder_name' => $request->account_holder_name,
                        'account_holder_type' => $request->account_holder_type
                      ],
                    'business_type'=> "individual",
                    'individual'=> [
                        'address'=> [
                            'city'=> $request->city,
                            'country'=> $request->country,
                            'line1'=> 'test1',
                            'line2'=> 'test2',
                            'postal_code'=> $request->postal_code,
                            'state'=> $request->state,
                        ],
                        'dob'=> [
                            'day'=> $day,
                            'month'=> $month,
                            'year'=> $year,
                        ],
                        'email'=> $bank->User->email,
                        'first_name'=> $bank->User->name,
                        'last_name'=> $bank->User->name,
                        'phone'=> $bank->User->phone_no,
                        'political_exposure'=> "none",
                        'ssn_last_4'=> "0000",
                        'id_number'=> "000000000",
                    ],
                    'business_profile'=> [
                        'name'=> $bank->User->name,
                        'support_email'=> $bank->User->email,
                        'support_phone'=> $bank->User->phone_no,
                        'url'=> "https://scriptube.com/",
                        'mcc'=> "5399",
                        'support_address'=> [
                                'city'=> $request->city,
                                'country'=> $request->country,
                                'line1'=> 'test1',
                                'line2'=> 'test2',
                                'postal_code'=> $request->postal_code,
                                'state'=> $request->state,
                        ],
                    ],
                    'tos_acceptance'=> [
                        'date'=> time(),
                        'ip'=> '13.112.224.240',
                    ],
                    ]
                  );
                }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $e->getMessage()
            ]);
        }
                  $bank->bank_stripe_id = $updateBank->id;
                  $bank->user_id= $userId;
                  $bank->holder_name = $request->account_holder_name;
                  $bank->account_holder_type = $request->account_holder_type;
                  $bank->bank_name = $request->bank_name;
                  $bank->account_number = $request->account_number;
                  $bank->routing_number = $request->routing_number;
                  $bank->phone_number = $bank->User->phone_no;
                  $bank->country = $request->country;
                  $bank->city = $request->city;
                  $bank->state = $request->state;
                  $bank->postal_code = $request->postal_code;
                  $bank->address = $request->address;
                  $bank->currency = 'usd';
                  $bank->bank_status = '0';
                  $bank->bank_reason = null;
                  $bank->save();
                  return response()->json([
                      'status' => true,
                      'status_code' => true,
                      'message' => "Your bank account's details has been updated and submitted for review",
                      'bank' => $updateBank,
                  ]);
              
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Data Not Found.'
                ]);
            }
        }

        //get business bank
        public function GetBusinessBank(){
            $bank = BusinessBank::with('User')->where('user_id',auth()->user()->id)->first();
            if($bank){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' => $bank
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Data Not Found.'
                ]);
            }
        }
}