<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Model\UserResetPassword;
use Illuminate\Http\Request;
use App\Contact;
use App\Models\User;
use Validator, Auth, Str, Hash;

class ResetPasswordController extends Controller
{
    /**
     * Create token password reset
     *
     * @param  [string] email
     * @return [string] message
     */
    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_no' => 'required'
        ]);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }
        $user = User::where(['phone_no' => $request->phone_no, 'is_deleted' => '0'])->first();
        if (!$user) {
            return response()->json([
                'status_code' => true,
                'status' => false,
                'message' => "We can't find a user with this phone number."
            ]);
        } else {
            $OTP = rand(111111, 999999);
            $passwordReset = UserResetPassword::updateOrCreate(['phone_no' => $user->phone_no], ['phone_no' => $user->phone_no, 'otp' => $OTP]);
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' => 'Reset Password OTP sent to your phone no.',
                'otp' => $OTP,
                'phone_no' => $request->phone_no
            ]);
        }
    }


    /**
     * [OtpVerify description]
     * @param Request $request [description]
     */
    public function OtpVerify(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_no' => 'required',
            'otp' => 'required'
        ]);
        if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }

        $phoneNo = $request->phone_no;
        $checkPhone = User::where(['phone_no' => $phoneNo, 'is_deleted' => '0'])->first();
        if (!empty($checkPhone)) {
            $passwordReset = UserResetPassword::where(['otp' => $request->otp, 'phone_no' => $checkPhone->phone_no])->first();
            if (!$passwordReset) {
                return response()->json([
                    'message' => 'Incorrect otp', 'status' => false,
                    'status_code' => true
                ]);
            }
            return response()->json(['data' => $passwordReset, 'message' => 'success', 'status' => true, 'status_code' => true]);
        } else {
            return response()->json([
                'message' => 'User Not Found!', 'status' => false,
                'status_code' => true
            ]);
        }
    }

    /**
     * Reset password
     *
     * @param  [string] email
     * @param  [string] password
     * @param  [string] password_confirmation
     * @param  [string] token
     * @return [string] message
     * @return [json] user object
     */
    public function reset(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_no' => 'required',
            'password' => 'required|min:6|confirmed',
            'password_confirmation' => 'required|min:6'
        ]);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }

        $passwordReset = UserResetPassword::where(['phone_no' => $request->phone_no])->first();

        $user = User::where(['phone_no' => $request->phone_no, 'is_deleted' => '0'])->first();
        if (!$user) {
            return response()->json(['message' => 'We can`t find a user with that phone number.', 'status_code' => true, 'status' => false]);
        } else {
            $user->password = bcrypt($request->password);
            if ($user->save()) {
                $passwordReset->delete();
                return response()->json(['message' => 'Password changed successfully.', 'status_code' => true, 'status' => true]);
            } else {
                return response()->json(['message' => 'Connection error. Please try again later.', 'status_code' => true, 'status' => false]);
            }
        }
    }
    public function ResendOTP(Request $request){
        $validator = Validator::make($request->all(), [
            'phone_no' => 'required|exists:user_reset_passwords,phone_no',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => $validator->messages()->first()
            ]);
        }
        $otp =  random_int(100000, 999999);
        $user = UserResetPassword::where('phone_no',$request->phone_no)->first();
        $user->otp = $otp;
        if ($user->save()) {
            return response()->json([
                'status' => true,
                'status_code' => true,
                'otp' => $otp,
                'phone_no' => $user->phone_no
            ]);
        } else {    
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Something went wrong.'
            ]);
        }
    }
}
