<?php

namespace App\Console\Commands;

use App\Models\Model\UserMealDetail;
use Illuminate\Console\Command;
use App\Helper\PushHelper;
use DateTime;
use Illuminate\Support\Carbon;

class UserMealCron extends Command
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
        $getMealDetail = UserMealDetail::with('UserName')->WhereNotNull(['meal_notify','meal_daily_count','meal_start_time','meal_end_time'])->get();
    //    ($getMealDetail);
        if(!empty($getMealDetail)){
            foreach($getMealDetail as $meal){
                // dd($meal);
                $deviceToken = $meal->UserName?$meal->UserName->device_token:"";
                $userId = $meal->UserName?$meal->UserName->id:"";
                $title = 'meal';
                $msg = 'sxkjscbkjcbeb';
                $notification_type = 'meal user';
                $notification_source = "app";
                $startTime = $meal->meal_start_time;
                $endTime = $meal->meal_end_time;
                $new_time = strtotime($endTime) - strtotime($startTime);
                $min = ($new_time/60); //It will return Mintues
                $timeZoneCheck =  "UTC";
                $utcTime = explode(' ',$helper->timeZoneCheck($timeZoneCheck));
                $getMin =(string) $meal->meal_daily_count != 0 && $meal->meal_daily_count != null ? $min / $meal->meal_daily_count: "0";
                if ( $meal->meal_daily_count != 0 &&  $meal->meal_notify == 1  && ($utcTime[1] >= $startTime || $utcTime[1]  <=  $endTime  )) {
                    if(!empty($deviceToken)){
                        $startTime = $this->AddMintues($startTime,$getMin);
                        for ($i=0; $i <= $meal->meal_daily_count; $i++) {
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

    function AddMintues($start,$min){
        $time = Carbon::parse($start);
        $startTime = $time->addMinutes($min);
        $startTime = Carbon::parse($startTime)->format('H:i:s'); 
        return $startTime;  
    }
   
}
