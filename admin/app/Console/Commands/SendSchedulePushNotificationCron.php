<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Model\PushNotification;
use App\Helper\PushHelper;

class SendSchedulePushNotificationCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'SendSchedule:PushNotification';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send push notifications the are schedule every 10 min';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle(PushHelper $helper)
    {
        $getAllList = PushNotification::with('User')->where('is_sent', '1')->get();
        
        foreach ($getAllList as $notification) {
            $timeZoneCheck =  "UTC";
            // $time = "2022-12-24 08:16:35";
            $utcTime = $helper->timeZoneCheck($timeZoneCheck);
            $deviceToken = $notification->User?$notification->User->device_token:"";
            $userId = $notification->User?$notification->User->id:"";
            $title = $notification->title;
            $msg = $notification->message;
            $notification_type = 'Push Schedule Notification';
            $notification_source = "dashboard";
            if($utcTime  == $notification->schedule_date_time){
                if(!empty($deviceToken)){
                    $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                }else {
                    $status = $helper->addNotificationRecord($userId,$notification_type,$title,$msg,$notification_source);
                }
            }
            
        }
    }
}
