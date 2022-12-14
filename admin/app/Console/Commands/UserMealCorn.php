<?php

namespace App\Console\Commands;

use App\Models\Model\UserMealDetail;
use Illuminate\Console\Command;
use App\Helper\PushHelper;
use DateTime;

class UserMealCorn extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'user:meal';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Meal notification send successfully.';

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
        $getMealDetail = UserMealDetail::with('UserName')->orWhereNotNull(['meal_notify','meal_daily_count','meal_start_time','meal_end_time'])->get();
        if(!empty($getMealDetail)){
            foreach($getMealDetail as $meal){
                $deviceToken = $meal->UserName->device_token;
                $title = 'pray3e';
                $msg = 'sxkjscbkjcbeb';
                $notification_type = 'Meal User';
                $startTime = new \DateTime($helper->ConvertTimeToUTCzone($meal->meal_start_time));
                $endTime = new \DateTime($helper->ConvertTimeToUTCzone($meal->meal_end_time));
                $total = $startTime->diff($endTime);
                $min =  (string)  $total->i == 0 ? $total->h * 60 :$total->i; 
                $timeZoneCheck =  "UTC";
                $utcTime = explode(' ',$helper->timeZoneCheck($timeZoneCheck));
                $getMin =(string) $meal->meal_daily_count != 0 && $meal->meal_daily_count != null ? $min / $meal->meal_daily_count: "0";
                // if (!empty($deviceToken)  &&  $getDetail->prayer_notif == 1  && ($utcTime[1] >= $startTime || $utcTime[1]  <=  $endTime   )) {
                if ($meal->meal_notify == 1  && ($utcTime[1] >= $startTime || $utcTime[1]  <=  $endTime )) {
                    if($meal->meal_daily_count != 0){
                        $startTime->modify("+{$getMin} minutes");
                        for ($i=0; $i <= $meal->meal_daily_count; $i++) {
                                if($utcTime[1] == $startTime->format('H:i:s')) {
                                 
                                    $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                                }
                                $startTime->modify("+{$getMin} minutes");
                            }
                    }else{

                        $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                    }
                }

            }

        }
    
    }
   
}
