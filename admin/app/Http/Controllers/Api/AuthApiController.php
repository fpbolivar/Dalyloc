<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator,Hash;
use App\Models\User;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Helper\CustomHelper;

class AuthApiController extends Controller
{
      public function __construct()
    {
        $this->middleware('user.api', ['except' => ['UserRegister','UserLogin','VerifyPhoneWithOtp','ResendAuthenticateOtp']]);
    }

    public function UserRegister(Request $req,  CustomHelper $helper)
    {   
        $message = [
                    'phone_no.unique' => 'There Is Already An Account Registered With That Phone Number. Please Login With That Phone Number Or Create An Account With a New Phone Number.',
                    'password.min'=>'Password Must Be Atleast 6 Digits Long.',
                    ];
    	// validate feilds
        $validator = Validator::make($req->all(),[
            'name' => 'required',
            // 'email' => 'required|email:filter|unique:users,email',

            'phone_no' => 'required|unique:users,phone_no',
            'password' => 'required|min:6|same:confirm_password',
            'confirm_password' => 'required|min:6'
        ],$message);
        // if validation failed
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => $validator->messages()->first()
            ]);
        }

        $otp =  random_int(100000, 999999);
    	$user = new User;
        $user->name = $req->name;
        // $user->email = $req->email;
        $user->phone_no = $req->phone_no;
        $user->country_code =$req->country_code;
        $user->otp = $otp;
        $user->device_id = $req->device_id;
        $user->device_token = $req->device_token;
        $user->password = Hash::make($req->password);
        // save user
        if ($user->save()) {
            return response()->json([
                'status' => true,
                'status_code' => true,
                'otp' => $otp,
                'user_id' => $user->id
                // 'message' =>'User register successfully.'
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => 'Something Went Wrong.'
            ]);
        }
    }

    public function VerifyPhoneWithOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
            'otp' => 'required|exists:users,otp',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }
        $user = User::where(['id' => $request->user_id, 'otp' => $request->otp])->first();
        if (!empty($user)) {
            $user->otp = null;
            $user->phone_verified_at = date('Y-m-d h:m:s');
            if ($user->save()) {
                $token = JWTAuth::fromUser($user);

                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Mobile Number Authenticated Successfully.',
                    'access_token' => 'Bearer '.$token,

                ]);
            } else {
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.'
                ]);
            }
        } else {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Invalid OTP.'
            ]);
        }
    }
    
    public function ResendAuthenticateOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }
        $otp =  random_int(100000, 999999);
        $user = User::find($request->user_id);
        $user->otp = $otp;
        if ($user->save()) {
            return response()->json([
                'status' => true,
                'status_code' => true,
                'otp' => $otp,
                'user_id' => $user->id
            ]);
        } else {    
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Something Went Wrong.'
            ]);
        }
    }
    public function UserLogin(Request $req)
    {

        $message = [
                    'phone_no.exists'=>'This Phone Number Does Not Exist In Our System.',
                    'password.min'=>'Password Must Be Atleast 6 Digits Long.',
                    ];
    	// validate feilds
        $validator = Validator::make($req->all(),[
            'phone_no' => 'required|exists:users,phone_no',
            'password' => 'required|min:6'
        ],$message);
        // if validation failed
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => $validator->messages()->first()
            ]);
        }

          $user = User::where('phone_no',$req->phone_no)->where('country_code',$req->country_code)->whereNotNull('phone_verified_at')->first();
        // if (!is_null($user->facebook_id) || !is_null($user->google_id)){
        //     return response()->json([
        //             'status' => false,
        //             'status_code' => false,
        //             'message' => 'This phone number is associated with a social media login. Please log in with social login icons on the screen.'
        //          ]);
        // }
        // check password
        if($user == null){
                return response()->json([
                    'status' => false,
                    'status_code' => false,
                    'message' => 'Your Phone Number and Country Code Is Not Verified.'
                ]);
        }
        $passwordCheck = \Hash::check($req->password,$user->password);
        if ($passwordCheck) {
            if ($user->is_deleted == '1') {
                 return response()->json([
                    'status' => false,
                    'status_code' => false,
                    'message' => 'Your Account Has Been Disabled, Please Contact Adminstrator.'
                 ]);
            }
            $user->device_id = $req->device_id;
            $user->device_type = $req->device_type;
            $user->country_code = $req->country_code;
            $user->device_token = $req->device_token;
            $user->login_type = 'manual';
            if ($user->save()) {
                // genrate auth token
                $token = JWTAuth::fromUser($user);
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Login successfully',
                    'access_token' => 'Bearer '.$token,
                    'details' => $user
                ]);
            }
            return response()->json(['message' => 'Something Went Wrong.','status' => false]);
        }else{
            // if (!is_null($user->social_id) && $user->login_type == 'google') {
            //     return response()->json(['message' => 'you are already login with the google account','status' => false]);
            // }elseif (!is_null($user->social_id) && $user->login_type == 'google') {
            //     return response()->json(['message' => 'you are already login with the facebook account','status' => false]);
            // }
            return response()->json(['message' => 'Wrong Password.','status' => false]);
        }
    }

    public function logout(Request $request)
    {
        User::whereid(auth()->user()->id)->update(['device_id'=>NULL,'device_token'=>NULL]);
        // invalidate auth token
        JWTAuth::invalidate();
        return response()->json(['message' => 'Successfully Logged Out.','status' => true]);
    }

}
