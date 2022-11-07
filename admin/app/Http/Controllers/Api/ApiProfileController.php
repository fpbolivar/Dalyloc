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
        $user->user_profile_pic = ($user->user_profile_pic)?$user->user_profile_pic:null;
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
                'message' =>'Old password and New password should be different.'
            ]);
        }
        // check old passowrd
        if (!Hash::check($request->old_password,auth()->user()->password)) {
        	return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'old password doesn`t matched'
            ]);
        } 
       	// update new password
       	$user = User::find(auth()->user()->id);
       	$user->password = Hash::make($request->new_password);
       	if ($user->save()) {
            return response()->json([
                'status' => true,
                'status_code' => true,
                'message' =>'Password changed successfully.'
            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Something went wrong.'
            ]);
        }
    }

    public function EditProfile(Request $request)
    {
        // $message = [
        //             'name.required'=>'What everyone else will see you as?',
        //            ];
        // validate feilds
        $validator = Validator::make($request->all(),[
            'name' => 'required',
            // 'email' => 'unique:users,email,'.auth()->user()->id.',id',
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
        // get and update user
        $user = User::find(auth()->user()->id);
        $user->name = $request->name;
        $user->date_of_birth = $request->date_of_birth;
        $user->age = $request->age;
        $user->gender = $request->gender;
        $user->height_feet = $request->height_feet;
        $user->height_inch = $request->height_inch;
        $user->weight = $request->weight;

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
                'message' =>'Profile updated successfully.',
            ]);
        }else{
            return response()->json([
                'status' => true,
                'status_code' => false,
                'message' => 'Something went wrong.'
            ]);
        }
    }
}
