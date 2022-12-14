<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\PushNotification;
use App\Models\Model\NotificationLogRecord;
use App\Helper\PushHelper;
use App\Models\User;

class PushNotificationController extends Controller
{

    /**
     * push notification view file 
     */
    public function Index()
    {
       $getNotification = PushNotification::with('User')->orderBy('created_at','desc')->get();
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
                foreach($userIds as $userId){
                    if($userId == 'all'){
                        $getAllUser = User::where('is_deleted', '0')->get();
                        if(!empty($getAllUser)){
                            foreach($getAllUser as $user){
                                $deviceToken = $user->device_token;
                                $title = $req->title;
                                $msg = $req->message;
                                $notification_type = 'Prayer';
                                if (!empty($deviceToken)) {
                                    $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
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
                                    $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                                }
                            }
                        }
                            

                    }
                }
                $message = 'The push notification send successfully';         
            }else{

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

}
