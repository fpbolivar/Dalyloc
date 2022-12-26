<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\PushNotification;
use App\Models\Model\NotificationLogRecord;
use App\Helper\PushHelper;
use App\Models\User;
use App\Models\Model\BusinessBank;
use Stripe\Exception\CardException;
use Stripe\StripeClient;
use Stripe\Stripe;
use Artisan;

class PushNotificationController extends Controller
{
    /**
     * push notification view file 
     */
    public function Index()
    {
       $getNotification = PushNotification::with('User')->where('is_sent', '1')->orderBy('created_at','desc')->get();
        return view('admin.pushnotification.index',compact('getNotification'));
    }

     /**
      * create notification 
      */
    public function CreateNotification(Request $req , PushHelper $helper){
        $getUser = User::where('is_deleted', '0')->get();
        if($req->isMethod('post')){
            $this->validate($req, [
                'users'=>'required',
                'is_sent'=>'required',
                'title'=>'required',
                'message'=>'required'
            ]);
            $message = 'The push notification scheduled successfully';
            $whereNotification = '';
            $userIds = $req->users;
            $workoutid = $req->workout;
            $notification_source = 'dashboard'; 
            if (in_array("all", $userIds,true)) {
                $userIds = ['all'];
            }
            if($req->is_sent == '0' ){
                // foreach($userIds as $userId){
                    if($userIds == 'all'){
                        // dd($userIds);
                        $getAllUser = User::where('is_deleted', '0')->get();
                        if(!empty($getAllUser)){
                            foreach($getAllUser as $user){
                                $deviceToken = $user->device_token;
                                $title = $req->title;
                                $msg = $req->message;
                                $notification_type = 'Prayer';
                                if (!empty($deviceToken)) {
                                    $helper->SendNotification($deviceToken,$title,$msg,$userIds,$notification_type,$notification_source);
                                }else{
                                    $status = $helper->addNotificationRecord($userIds,$notification_type,$title,$msg,$notification_source);
                                }
                            }
                        }
                      
                    }else{
                        $getAllUser = User::where(['is_deleted'=>'0'])->whereIn('id', $userIds)->get();
                        if(!empty($getAllUser)){
                            foreach($getAllUser as $user){
                                $deviceToken = $user->device_token;
                                $title = $req->title;
                                $msg = $req->message;
                                $notification_type = 'testing';
                                if (!empty($deviceToken)) {
                                    $helper->SendNotification($deviceToken,$title,$msg,$user->id,$notification_type,$notification_source);
                                }else{
                                    $status = $helper->addNotificationRecord($user->id,$notification_type,$title,$msg,$notification_source);
                                }
                            }
                        }
                            

                    }
                // }
                $message = 'The push notification send successfully';         
            }else{
                $schedule_date_time = date("Y-m-d H:i:s", strtotime($req->schedule_date_time));
                    if($userIds == 'all'){
                        $getAllUser = User::where('is_deleted', '0')->get();
                        if(!empty($getAllUser)){
                            foreach($getAllUser as $user){
                                $addPush = new PushNotification;
                                $addPush->user_id = $user->id;
                                $addPush->title = $req->title;
                                $addPush->message = $req->message;
                                $addPush->schedule_date_time = $schedule_date_time; 
                                $addPush->is_sent = $req->is_sent;
                                $addPush->save();
                            }
                        
                        }else{
                            $message = 'Something went wrong'; 
                        }
                    }else{
                        $getAllUser = User::where(['is_deleted'=>'0'])->whereIn('id', $userIds)->get()->toArray();
                        if(!empty($getAllUser)){
                            foreach($getAllUser as $user){
                                $addPush = new PushNotification;
                                $addPush->user_id = $user["id"];
                                $addPush->title = $req->title;
                                $addPush->message = $req->message;
                                $addPush->is_sent = $req->is_sent;
                                $addPush->schedule_date_time = $schedule_date_time; 
                                $addPush->save();
                            }
                        }else{
                            $message = 'Something went wrong'; 
                        }
                    }
                $message = 'The push notification send successfully';      

            }   
            return redirect('/admin/push-notification')->with('success',$message);
        }else{
            return view('admin.pushnotification.create',compact('getUser'));

        }
    }

    /**
      * get push notification recorde
      */
    public function GetPushRecorde()
    {
       $getRecorde = NotificationLogRecord::with('User')->orderBy('created_at','desc')->get();
        return view('admin.pushnotification.notificaitonrecorde',compact('getRecorde'));
    }


    public function PushCron(){
        Artisan::call('SendSchedule:PushNotification');
    }



}
