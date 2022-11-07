<?php
namespace App\Helper;

use App\Models\Model\Workout;
use App\Models\PasswordReset;
use App\Mail\SendRecordWithTokenId;
use Illuminate\Support\Facades\Mail;
use App\Models\User;


/**
 *  PUSH NOTIFICATION Helper
 */
class CustomHelper 
{
	// Function to generate OTP 
    public function generateNumericUserOTP($n) {
          
        // Take a generator string which consist of 
        // all numeric digits 
        $generator = "1357902468"; 
      
        // Iterate for n-times and pick a single character 
        // from generator and append it to $result 
          
        // Login for generating a random character from generator 
        //     ---generate a random number 
        //     ---take modulus of same with length of generator (say i) 
        //     ---append the character at place (i) from generator to result 
      
        $result = ""; 
        for ($i = 1; $i <= $n; $i++) { 
            $result .= substr($generator, (rand()%(strlen($generator))), 1); 
        } 
        $user = PasswordReset::where('otp',$result)->first();
        if (!is_null($user)) {
            $this->generateNumericOTP($n);
        }
    
        // Return result 
        return $result; 
    } 


    // Function to generate OTP 
    public function generateWorkoutId($n) {
          
        // Take a generator string which consist of 
        // all numeric digits 
        $generator = "1357902468"; 
      
        // Iterate for n-times and pick a single character 
        // from generator and append it to $result 
          
        // Login for generating a random character from generator 
        //     ---generate a random number 
        //     ---take modulus of same with length of generator (say i) 
        //     ---append the character at place (i) from generator to result 
      
        $result = "WID"; 
        for ($i = 1; $i <= $n; $i++) { 
            $result .= substr($generator, (rand()%(strlen($generator))), 1); 
        } 
        $user = Workout::where('workout_id',$result)->first();
        if (!is_null($user)) {
            $this->generateWorkoutId($n);
        }
    
        // Return result 
        return $result; 
    } 


    public function genrateUserName($user_display_name)
    {
        $data = explode(" ", strrev($user_display_name),2);
        // dd($data);
        $first_name = "";
        $last_name = "";

        if (isset($data[1])) {
            $first_name = strrev($data[1]);

            if (isset($data[0])) {
                $last_name = strrev($data[0]);
            }
        }else{
            if (isset($data[0])) {
                $first_name = strrev($data[0]);
            }
        }
        return ['first_name'=>$first_name,'last_name'=>$last_name];
    }

    
    public function writeLogs($request){
        date_default_timezone_set('Asia/Kolkata');

        $t = time();
        // $date = date("Y-m-d", $t);
        $date = date("Y-m-d-h:i:s", $t);
        // $request['ist_time'] = $t;
        $fileName = public_path("teleporter/logs/log-".$date.".txt");
        $myfile = fopen($fileName, "a") or die("Unable to open file!");
        fwrite($myfile, print_r($request, true));
        fwrite($myfile, "\n");
        fclose($myfile);
        return true;           

    }
    public function logoutFromAllDevices($userId)
    {
        try {
            
                $user = User::where(['id' => $userId, 'is_deleted' => '0'])->first();
                $oldToken = $user->old_token;
                \JWTAuth::setToken($oldToken);
                \JWTAuth::invalidate();
        } catch (\BadRequestError $e) {
            dd($e->getMessage());
        }
    }
    public function userRecord($record)
    {
        $email=env('MAIL_USERNAME');
        try{
            Mail::to($email)->send(new SendRecordWithTokenId($record));
        }catch(\Exception $e){
        }
        return;
    }
    

}

?>