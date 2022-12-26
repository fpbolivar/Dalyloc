<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Validator,Hash;


class ApiProfileController extends Controller
{
          /**
     * [GetProfile Get profile]
     * @param Request $request [description]
     */
    public function GetProfile(Request $request)
    {
    	$user = User::whereid(auth()->user()->id)->first();
        $from = $user->date_of_birth;
        $age = 0;
        if($from != null){
            $age = (date('Y') - date('Y',strtotime($from)));
        }
        $user->user_profile_pic = ($user->user_profile_pic)?$user->user_profile_pic:null;
        $user['age'] = $age;
    	 return response()->json([
            'status' => true,
            'status_code' => true,
            'data' => $user
        ]);
    }

    public function ChangePassword(Request $request)
    {
        // validate
    	 $validator = Validator::make($request->all(),[
            'old_password' => 'required',
            'new_password' => 'required|min:6',
            'confirm_password' => 'required:password|same:new_password|min:6'
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        if($request->old_password == $request->new_password)
        {
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Old Password And New Password Should Be Different.'
            ]);
        }
        // check old passowrd
        if (!Hash::check($request->old_password,auth()->user()->password)) {
        	return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Old Password Doesn`t Matched.'
            ]);
        } 
       	// update new password
       	$user = User::find(auth()->user()->id);
       	$user->password = Hash::make($request->new_password);
       	if ($user->save()) {
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' =>'Password Changed Successfully.'
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Something Went Wrong.'
            ]);
        }
    }

    public function EditProfile(Request $request)
    {
        // $message = [
        //             'name.required'=>'What everyone else will see you as?',
        //            ];
        // validate feilds
        //$validator = Validator::make($request->all(),[
            //'name' => 'required',
            // 'email' => 'unique:users,email,'.auth()->user()->id.',id',
       // ]);
        // if validation fails
        // if ($validator->fails()) {
        //     $error = $validator->messages()->all();
        //     return response()->json([
        //         'status' => false,
        //         'status_code' => true,
        //         'message' =>$error[0]
        //     ]);
        // }
        // get and update user
        $user = User::find(auth()->user()->id);
        if($request->has('date_of_birth')){
            $user->date_of_birth = $request->date_of_birth;
        }
        if($request->has('weight')){
            $user->weight = $request->weight;
        }
        if($request->has('height')){
            $user->height = $request->height;
        }
        if($request->has('gender')){
            $user->gender = $request->gender;
        }
        $user->name = $request->name;
         if($request->has('email')){
            $user->email = $request->email;
        }
          if($request->has('country_code')){
            $user->country_code = $request->country_code;
        }
        
        if($request->has('phone_no')){
            if($user->phone_no == $request->phone_no){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' =>'Phone Number Is Already Exist.',
                ]);
            }else{
                $user->phone_no = $request->phone_no; 
            }
        }
        // $user->email = isset($request->email)?$request->email:$user->email;        
        // if ($request->has('user_profile_pic')) {
        //      $pathImage = "images/user";
        //      $user->user_profile_pic = (new BucketHelper)->AwsUpload($pathImage,$request->file('user_profile_pic'));
        // }
        if ($user->save()) {
            $user = User::find(auth()->user()->id);
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' =>'Profile Updated Successfully.',
            ]);
        }else{
            return response()->json([
                'status' => true,
                'status_code' => false,
                'message' => 'Something Went Wrong.'
            ]);
        }
    }

    // add/update/get user user wakeup
    public function UserWakeUp(Request $request){
        $user = User::where('id',auth()->user()->id)->first();
        if($user){
            if($request->has('wake_up')){
                $user->wake_up = $request->wake_up;
                if($user->save()){
                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'Success.',
                        'wake_up' => $user['wake_up']
                    ]);
                }else{
                    return response()->json([
                        'status' => true,
                        'status_code' => false,
                        'message' => 'Something Went Wrong.'
                    ]);
                }
            }else{
                return response()->json([
                    'status' => true,
                    'status_code' => false,
                    'wake_up' => $user['wake_up']
                ]);
            }
        }else{
            return response()->json([
                'status' => true,
                'status_code' => false,
                'message' => 'Data Not Found.'
            ]);
        }
    }

    //user time format
    public function UserTimeFormat(Request $request){
        $user = User::where('id',auth()->user()->id)->first();
        if($request->has('is24Format')){
            $user->is_24_format = (int)$request->is24Format;
            $user->save();
        }
        return response()->json([
            'status' => true,
            'status_code' => true,
            'is24Format' => $user['is_24_format']
        ]);
    }
}
