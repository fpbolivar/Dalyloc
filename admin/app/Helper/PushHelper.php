<?php
namespace App\Helper;

use App\Models\NotificationLogRecord;


/**
 *  Image Upload Helper
 */
class PushHelper 
{


	/**
	 * [SendNotification Send Notification Helper]
	 * @param [array] $token   [Device Token]
	 * @param [array] $title   [Notification title]
	 * @param [array] $message [Message]
	 * @param [array] $type    [Notification Type]
	 * @param [array] $userId  [User ID]
	 */
   public function SendNotification($token,$title,$message,$type,$userId,$workoutid,$notification_type,$notification_source)
   {

   	    $url = "https://fcm.googleapis.com/fcm/send";
		//$serverKey = 'AAAAeOlsOxE:APA91bGY2Te1RN0urbcf75LF9sXvh7teO-2ynRBpBvUHKpBgyTg-kiMSQNJknzmD7jSiWsWprh4E2XP5R7pcs4_sc9J6pDL8F--I0867GilvHTqBD1pyiDNv_9KJLhyPD1bNAoWbtD8t';
		$serverKey="AAAAeOlsOxE:APA91bGY2Te1RN0urbcf75LF9sXvh7teO-2ynRBpBvUHKpBgyTg-kiMSQNJknzmD7jSiWsWprh4E2XP5R7pcs4_sc9J6pDL8F--I0867GilvHTqBD1pyiDNv_9KJLhyPD1bNAoWbtD8t";		
		$notification = array('title' =>$title , 'body' => $message, 'sound' => 'default', 'badge' => '1','type'=>$type,'userid'=>$userId);
		$data = array('workout_id' => $workoutid, 'notification_type' => $notification_type );
		$arrayToSend = array('to' => $token, 'notification' => $notification,'priority'=>'high', 'data' => $data);
		$json = json_encode($arrayToSend);
		$headers = array();
		$headers[] = 'Content-Type: application/json';
		$headers[] = 'Authorization: key='. $serverKey;

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST,"POST");
		curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
		curl_setopt($ch, CURLOPT_HTTPHEADER,$headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		//Send the request

    


		$response = curl_exec($ch);
		//Close request
		if ($response === FALSE) {
			    //for notifiction log records
		$notificationLogSave = new NotificationLogRecord;
		$notificationLogSave->user_id = $userId;
		$notificationLogSave->data_payload = json_encode($data);
        $notificationLogSave->notification_type = $notification_type;
        $notificationLogSave->notification_title = $title;
        $notificationLogSave->notification_description = $message;
        $notificationLogSave->notification_date = date("Y-m-d H:i:s");
        $notificationLogSave->notification_source = $notification_source;
		$notificationLogSave->message = curl_error($ch);
		$notificationLogSave->status = 'FALSE';
        $notificationLogSave->save();
		//die('FCM Send Error: ' . curl_error($ch));
		}else{
			    //for notifiction log records
		$notificationLogSave = new NotificationLogRecord;
		$notificationLogSave->user_id = $userId;
		$notificationLogSave->data_payload = json_encode($data);
        $notificationLogSave->notification_type = $notification_type;
        $notificationLogSave->notification_title = $title;
        $notificationLogSave->notification_description = $message;
        $notificationLogSave->notification_date = date("Y-m-d H:i:s");
        $notificationLogSave->notification_source = $notification_source;
		$notificationLogSave->message = 'SUCCESS';
		$notificationLogSave->status = 'TRUE';
        $notificationLogSave->save();
		}
		curl_close($ch);
	}



	public function timeZoneCheck($userTimeZone)
	{
		$mark = "+";
		if(strpos($userTimeZone, $mark) === false){
			$mark = "-";
		}
		$timeZone = explode(":", $userTimeZone);
		$new_time = date("Y-m-d H:i:s", strtotime($timeZone[0].' hours'));
		
		if (!empty($timeZone[1])) {
			$new_time = date("Y-m-d H:i:s", strtotime($mark.$timeZone[1].' minutes',strtotime($new_time)));
		}

		return $new_time;
	}




}
	
