<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Model\UserPrayer;
use App\Helper\PushHelper;
use App\Models\User;
use DateTime;
use Illuminate\Support\Carbon;

class PrayerCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'devotional:prayer';

    /**s
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Prayer notification send successfully. ';

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
    public function handle( PushHelper $helper)
    {
      
        $getData = UserPrayer::with('UserName')->groupBy('user_id')->where('is_deleted','0')->where('is_deleted','0')->where('prayer_status','pending')->get();
        // $getData = UserPrayer::with('UserName')->groupBy('user_id')->where('is_deleted','0')->where('user_id','22')->where('prayer_status','pending')->get();

        if(!empty($getData)){
            foreach($getData as $user){
                $deviceToken = $user->UserName->device_token;
                $title = $user->prayer_title;
                $msg = $user->prayer_note;
                $notification_type = 'prayer';
                $notification_source = "app";
                $userId = $user->UserName->id;
                $startTime = $user->UserName->prayer_start_time;
                $endTime = $user->UserName->prayer_end_time;
                $new_time = strtotime($endTime) - strtotime($startTime);
                $min = ($new_time/60); //It will return Mintues
                $timeZoneCheck =  "UTC";
                $utcTime = explode(' ',$helper->timeZoneCheck($timeZoneCheck));
                $getMin = $user->UserName->prayer_daily_count != 0 && $user->UserName->prayer_daily_count != null ? $min / $user->UserName->prayer_daily_count: "0"; 
                if ($user->UserName->prayer_daily_count != 0  &&  $user->UserName->prayer_notify == 1  && ($utcTime[1] >= $startTime ||  $utcTime[1]  <= $endTime )) {
                        if(!empty($deviceToken)){
                            $startTime = $this->AddMintues($startTime,$getMin);
                            for ($i=0; $i <= $user->UserName->prayer_daily_count; $i++) {
                                    if($utcTime[1] == $startTime) {
                                        $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                                    }
                                    $startTime = $this->AddMintues($startTime,$getMin);
                                }
                        }else{
                            $status = $helper->addNotificationRecord($userId,$notification_type,$title,$msg,$notification_source);
                        }
                    }else{
                       return "Something went wrong";
                    }
            }
        }
         
    }

    function ConvertTimeToUTCzone($str){
        $format = 'Y-m-d H:i:s';
        $new_str = new DateTime($str, new \DateTimeZone('IST') );
        $new_str->setTimeZone(new \DateTimeZone('UTC'));
        return $new_str->format( $format);  
    }

    function AddMintues($start,$min){
        $time = Carbon::parse($start);
        $startTime = $time->addMinutes($min);
        $startTime = Carbon::parse($startTime)->format('H:i:s'); 
        return $startTime;  
    }
}
