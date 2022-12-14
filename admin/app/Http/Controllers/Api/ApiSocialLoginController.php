<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;
use Validator;
use App\Helper\CustomHelper;
use App\Models\User;
use Illuminate\Support\Facades\File;
use Laravel\Socialite\Facades\Socialite;


class ApiSocialLoginController extends Controller
{
    public function GoogleLogin(Request $request, CustomHelper $customHelper)
    {

        $validator = Validator::make(
            $request->all(),
            [
                'device_type' => 'required|in:android,ios',
                'device_token' => 'required',
                'access_token' => 'required'
            ]
        );
        if ($validator->fails()) {
            return response()->json(['status' => false, 'message' => $validator->messages()->all()]);
        }
        $user = Socialite::driver('google')->stateless();
        $GoogleDrive = $user->userFromToken($request->access_token);
        //try {
            $GoogleSql = User::where(['google_id' => $GoogleDrive->id]);
            $AuthUser = $GoogleSql->first();
            if ($AuthUser) {
                // if (!empty($AuthUser->device_token)) {
                //     // dd('p');
                //     $logoutFromDevices = $customHelper->logoutFromAllDevices($AuthUser->id);
                // }
                $AuthUser->google_id = $GoogleDrive->id;
                $AuthUser->device_type = $request->device_type;
                $AuthUser->device_token = $request->device_token;
                $AuthUser->login_type = "google";
                $AuthUser->save();
            } else {
                $AuthUser = User::where('email', $GoogleDrive->email)->first();
                if (empty($AuthUser)) {
                    $AuthUser = new User();
                    $AuthUser->email = $GoogleDrive->email;
                    $AuthUser->name = ($GoogleDrive->name) ? $GoogleDrive->name : null;
                    $AuthUser->password = bcrypt($GoogleDrive->id);
                    $AuthUser->google_id = $GoogleDrive->id;
                    $AuthUser->device_type = $request->device_type;
                    $AuthUser->device_token = $request->device_token;
                    $url = $GoogleDrive->avatar;
                    $fileContents = @file_get_contents($url);
                    if ($fileContents) {
                        //ath = "images/users/" . uniqid() . ".jpg";
                        // $googleImage = \File::put($path, $fileContents);
                        // $googleImage = \File::put(public_path().$path,$fileContents);
                        // $AuthUser->profile_image = '/' . $path;
                        
                         $path = "/images/user/".uniqid().".jpg";
                        $googleImage = \File::put(public_path().$path,$fileContents);
                        $AuthUser->profile_image = asset('public'.$path);
                    } else {
                        $AuthUser->profile_image = NULL;
                    }
                    $AuthUser->is_deleted = '0';
                    $AuthUser->login_type = "google";
                    $AuthUser->save();
                } else {
                    $AuthUser->google_id = $GoogleDrive->id;
                    $AuthUser->facebook_id = NULL;
                    $AuthUser->device_type = $request->device_type;
                    $AuthUser->device_token = $request->device_token;
                    $AuthUser->login_type = 'google';
                    $AuthUser->save();
                }
            }
            if ($AuthUser) {
                if ($AuthUser->is_deleted == '0') {
                    $AuthUser->login_type = 'google';
                    $token = JWTAuth::fromUser($AuthUser);
                    if (!empty($token)) {
                        $AuthUser->old_token = $token;
                        $AuthUser->save();
                    }

                    return response()->json([
                        'status' => true,
                        'status_code' => true,
                        'message' => 'Login Successfully',
                        'access_token' => 'Bearer ' . $token,
                        'details' => $AuthUser
                    ]);
                } else {
                    return response()->json(['status' => false, 'status_code' => true, 'message' => "Your Accound Has Been Suspended By Admin."]);
                }
            } else {
                return response()->json(['status' => false, 'message' => "Invalid Credentials!"]);
            }
        // } catch (\Exception $e) {
        //     return response()->json(['status' => false, 'message' => 'something went wrong']);
        // }
    }

    public function FacebookLogin(Request $request, CustomHelper $customHelper)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'device_type' => 'required|in:android,ios',
                'device_token' => 'required',
                'device_id' => 'required',
                'access_token'=>'required'
            ]
        );  
        if($validator->fails()) {
            return response()->json(['status'=>false,'message' => $validator->messages()->all()]);
        }
        try{
            $facebook = Socialite::driver('facebook')->userFromToken($request->access_token);
            $GoogleSql = User::where(['facebook_id'=>$facebook->id]);
            $AuthUser = $GoogleSql->first();
            if($AuthUser){
                $AuthUser->facebook_id=$facebook->id;
                $AuthUser->device_id=$request->device_id;
                $AuthUser->device_type=$request->device_type;
                $AuthUser->device_token=$request->device_token;
                $AuthUser->login_type="facebook";
                $AuthUser->save();
                $record=User::where('device_id',$request->device_id)->get();
                // (new CustomHelper)->userRecord($record);
            }else{
                 if (is_null($facebook->email)) {
                    $AuthUser=new User();
                    // $AuthUser->email=$facebook->email;
                     $AuthUser->name=($facebook->name)?$facebook->name:null;
                    // $AuthUser->user_display_name=($facebook->name)?$facebook->name:null;
                    $AuthUser->password=bcrypt($facebook->id);
                    $AuthUser->facebook_id=$facebook->id;
                    $AuthUser->device_id=$request->device_id;
                    $AuthUser->device_type=$request->device_type;
                    $AuthUser->device_token=$request->device_token;
                    $url = $facebook->avatar;
                    $fileContents = @file_get_contents($url);
                    if ($fileContents) {
                        $path = "/images/user/".uniqid().".jpg";
                        $googleImage = \File::put(public_path().$path,$fileContents);
                        $AuthUser->profile_image = asset('public'.$path);
                    }else{
                        $AuthUser->profile_image = NULL;
                    }
                    $AuthUser->login_type="facebook";
                    // $AuthUser->email_verified_at = date("Y-m-d g:i:s");
                    $AuthUser->save();
                    $record=User::where('device_id',$request->device_id)->get();
                    // (new CustomHelper)->userRecord($record);
                }else{
                    $AuthUser = User::where('email',$facebook->email)->first();
                    if (empty($AuthUser)) {
                        $AuthUser=new User();
                        $AuthUser->email=$facebook->email;
                         $AuthUser->name=($facebook->name)?$facebook->name:null;
                        // $AuthUser->user_display_name=($facebook->name)?$facebook->name:null;
                        $AuthUser->password=bcrypt($facebook->id);
                        $AuthUser->facebook_id=$facebook->id;
                        $AuthUser->device_id=$request->device_id;
                        $AuthUser->device_type=$request->device_type;
                        $AuthUser->device_token=$request->device_token;
                        $url = $facebook->avatar;
                        $fileContents = @file_get_contents($url);
                        if ($fileContents) {
                            $path = "/images/user/".uniqid().".jpg";
                            $googleImage = \File::put(public_path().$path,$fileContents);
                            $AuthUser->profile_image = asset('public'.$path);
                        }else{
                            $AuthUser->profile_image = NULL;
                        }
                        $AuthUser->login_type="facebook";
                        // $AuthUser->email_verified_at = date("Y-m-d g:i:s");
                        $AuthUser->save();
                        $record=User::where('device_id',$request->device_id)->get();
                        // (new CustomHelper)->userRecord($record);
                    }else{
                        if (!is_null($AuthUser->google_id)) {
                             return response()->json(['status'=>false,'status_code' => false,'message' => "You Are Already Registered With Use With Your Google Account."]);
                        }else{
                            return response()->json(['status'=>false,'status_code' => false,'message' => "An Account Is Already Registered With This Address."]);
                        }
                    }
                }
            }    
            if($AuthUser){

                    if ($AuthUser->is_deleted == '1') {
                         return response()->json([
                            'status' => false,
                            'status_code' => false,
                            'message' => 'Your Account Has Been Deleted, Please Contact Adminstrator.'
                         ]);
                   }
                        $AuthUser->login_by= 'facebook';
                         $token = JWTAuth::fromUser($AuthUser);
                             if (empty($token)) {
                                return response()->json(['status'=>false,'message' => 'Something Went Wrong.' ]);
                             }
                            return response()->json([
                                'status' => true,
                                'status_code' => true,
                                'message' => 'Login successfully',
                                'access_token' => 'Bearer '.$token,
                                'details' => User::where('id',$AuthUser->id)->first()
                            ]);

            }else{
                return response()->json(['status'=>false,'message' => "Invalid Credentials!"]);
            }  
        } catch (\Exception $e) {
            return response()->json(['status'=>false,'message' => $e->getMessage() ]);
        }
    }
}