<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Model\UserPrayer;
use App\Helper\PushHelper;
use App\Models\User;
use DateTime;

class PrayerCorn extends Command
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
      
        $getData = UserPrayer::with('UserName')->groupBy('user_id')->where('is_deleted','0')->where('prayer_status','pending')->get();
        // dd($getData);
        if(!empty($getData)){
            foreach($getData as $user){
                // dd($user->UserName->prayer_daily_count);
                // $getDetail = User::where('is_deleted','0')->where('id',5)->first();
                $deviceToken = $user->UserName->device_token;
                $title = 'pray3e';
                $msg = 'sxkjscbkjcbeb';
                $notification_type = 'Prayer';
                // $startTime = new DateTime($helper->ConvertTimeToUTCzone($user->UserName->prayer_start_time));
                // $endTime = new DateTime($helper->ConvertTimeToUTCzone($user->UserName->prayer_end_time));
                $startTime = new DateTime($user->UserName->prayer_start_time);
                $endTime = new DateTime($user->UserName->prayer_end_time);
                $total = $startTime->diff($endTime);
                $min =  (string)  $total->i == 0 ? $total->h * 60 :$total->i; 
                $timeZoneCheck =  "UTC";
                $utcTime = explode(' ',$helper->timeZoneCheck($timeZoneCheck));
                $getMin =(string) $user->UserName->prayer_daily_count != 0 &&$user->UserName->prayer_daily_count != null ? $min / $user->UserName->prayer_daily_count: "0"; 
                
                // if (!empty($deviceToken)  &&  $getDetail->prayer_notif == 1  && ($utcTime[1] >= $startTime || $utcTime[1]  <=  $endTime   )) {
                if ($user->UserName->prayer_notify == 1  && ($utcTime[1] >= $startTime || $utcTime[1]  <=  $endTime )) {
                        if($user->UserName->prayer_daily_count != 0){
                            $startTime->modify("+{$getMin} minutes");
                            for ($i=0; $i <= $user->UserName->prayer_daily_count; $i++) {
                                    if($utcTime[1] == $startTime->format('H:i:s')) {
                                        $helper->SendNotification($deviceToken,$title,$msg,'',$userId,'',$notification_type,$notification_source);
                                    }
                                    $startTime->modify("+{$getMin} minutes");
                                }
                        }else{

                            $helper->SendNotification($deviceToken,$title,$msg,'',$userId,'',$notification_type,$notification_source);
                        }
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
}
