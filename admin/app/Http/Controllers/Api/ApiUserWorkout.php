<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\WorkoutLevel;
use App\Models\Model\Workout;
use App\Models\Model\Exercise;
use App\Models\User;
use App\Models\Model\UserWorkout;
use App\Models\Model\AdminSetting;
use Validator;

class ApiUserWorkout extends Controller
{
    public function GetWorkoutLevel(){
        $workoutLevel = WorkoutLevel::where('is_deleted','0')->get();
        return response()->json([
            'status' => true,
            'status_code' => true,
            'data' => $workoutLevel,
        ]);
    }

    //GetExericeTermConditions
    public function GetExericeTermConditions(){
        $terms = AdminSetting::where('id',2)->first();
        if($terms){
             return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $terms,
            ]);
        }
         return response()->json([
                'status' => false,
                'status_code' => true,
                'data' => 'No Data Found.',
            ]);
    }
    //AcceptExericeTermConditions
    public function AcceptExericeTermConditions(Request $request){
        // validate
    	$validator = Validator::make($request->all(),[
            'is_accepted' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $user = User::where('id',auth()->user()->id)->first();
        if($user){
            $user->is_exercise_terms = $request->is_accepted;
            if($user->save()){
                return response()->json([
                'status' => true,
                'status_code' => true,
                'message' =>'Accepted Susscessfully.',
                 'is_exercise_terms' => $user['is_exercise_terms']
            ]);  
            }else{
                  return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Something Went Wrong.'
            ]);
            }
        }
    }
    public function GetWorkoutByWorkoutLevelId(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'workout_level_id' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $workoutLevelDetail = WorkoutLevel::where('id',$request->workout_level_id)->first();
        // $workout = WorkoutLevel::with('ActiveWorkout')->where('id',$request->workout_level_id)->where('is_deleted','0')->get();
        $workout = Workout::where('level_id',$request->workout_level_id)->where('is_deleted','0')->get();
        $userWorkout = UserWorkout::with('UserWorkout')->where('user_id',auth()->user()->id)->get();
        if(count($userWorkout) != 0){
            $userWorkoutIds = [];
            foreach($userWorkout as $key){
                array_push($userWorkoutIds,$key->workout_id);
            }
            // $workout = WorkoutLevel::whereHas('AllWorkout', function ($query) use($userWorkoutIds) {
            //     return $query->whereNotIn('id',[2]);
            // })->where('id',$request->workout_level_id)->get()->toArray();

            //send only pending workouts not completed in response
            //dd($workout);
            $workout = Workout::where('level_id',$request->workout_level_id)->get();
            $workoutWithWorkoutLevelids = [];
            foreach($workout as $key){
                array_push($workoutWithWorkoutLevelids,$key->id);
            }
            $userWorkout = UserWorkout::with('UserWorkout')->whereIn('workout_id',$workoutWithWorkoutLevelids)->where('workout_status','pending')->where('user_id',auth()->user()->id)->get();
            $workout = Workout::whereNotIn('id',$userWorkoutIds)->where('level_id',$request->workout_level_id)->get();
        }
        return response()->json([
            'status' => true,
            'status_code' => true,
            'workout_level_detail' => $workoutLevelDetail,
            'explore' =>$workout,
            'pending' => $userWorkout
        ]);
    }

    public function GetExerciseByWorkoutId(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'workout_id' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $workoutExercises = Workout::with('WorkoutExercise','WorkoutLevel')->where('id',$request->workout_id)->where('is_deleted','0')->first();
        if($workoutExercises['WorkoutExercise']){
           $ids =  $workoutExercises['WorkoutExercise']['exercise_id'];
           $exerciseIds = explode(",", $ids);
           $exercises = Exercise::whereIn('id',$exerciseIds)->get();
           $sum = 0;
           foreach($exercises as $key){
            $sum+= $key->exercise_time;
           }
           $workoutExercises['exercises'] = $exercises;
           $workoutExercises['total_time'] = $sum;
        }
        return response()->json([
            'status' => true,
            'status_code' => true,
            'data' =>$workoutExercises
        ]);
    }

    public function CreateUserWorkout(Request $request){
        // validate
    	$validator = Validator::make($request->all(),[
            'workout_id' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
                $checkPendingWorkout = UserWorkout::where('workout_id',$request->workout_id)->where('workout_status','pending')->where('user_id',auth()->user()->id)->first();
                if($checkPendingWorkout){
                      return response()->json([
                'status' => false,
                'status_code' => true,
                'message' => 'Workout Is Already Added.'
            ]);
                }

        $checkPendingWorkout = UserWorkout::where('workout_id',$request->workout_id)->where('workout_status','pending')->where('user_id',auth()->user()->id)->first();
        if($checkPendingWorkout){
              return response()->json([
        'status' => false,
        'status_code' => true,
        'message' => 'Workout Is Already Added.'
        ]);
        }

        $createUserWorkout = new UserWorkout;
        $createUserWorkout->user_id = auth()->user()->id;
        $createUserWorkout->workout_id = $request->workout_id;
        $createUserWorkout->workout_status = 'pending';
        if($createUserWorkout->save()){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' =>$createUserWorkout,
                'message' => 'Workout Start Successfully.'

            ]);
        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Something Went Wrong.'
            ]);
        }

    }

    //complete user workout
    public function CompleteUserWorkout(Request $request){
        // validate
    	 $validator = Validator::make($request->all(),[
            'workout_id' => 'required',
        ]);
         // if validation fails
    	  if ($validator->fails()) {
            $error = $validator->messages()->all();
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>$error[0]
            ]);
        }
        $userPendingWorkout = UserWorkout::where('workout_id',$request->workout_id)->where('workout_status','pending')->where('user_id',auth()->user()->id)->first();
        if($userPendingWorkout != null){
            $userPendingWorkout->workout_status = 'completed';
            if($userPendingWorkout->save()){
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'message' => 'Workout Completed Successfully.',
                    'data' =>$userPendingWorkout
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' => 'Something Went Wrong.'
                ]);
            }

        }else{
            return response()->json([
                'status' => false,
                'status_code' => true,
                'message' =>'Data Not Found.'
            ]);
        }
    }
    
     public function ExerciseSetting(Request $req){
        $user = User::where("id",auth()->user()->id)->first();
        if( $user != null){
            if($req->exercise_notify != null){
                $user->exercise_notify = $req->exercise_notify;
            }
            if($req->exercise_start_time != null){
                $user->exercise_start_time = $req->exercise_start_time;

            }
            if($req->exercise_end_time != null){
                $user->exercise_end_time = $req->exercise_end_time;
            }
           // update prayer  setting 
            if($user->save()){
               
                return response()->json([
                    'status' => true,
                    'status_code' => true,
                    'data' => $user,
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => true,
                    'message' =>'data not found.'
                ]);
            }
        }

    }
       public function GetExerciseSetting(){
        $getDetail = User::where('id',auth()->user()->id)->first();
        if($getDetail){
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $getDetail,
            ]);
        }
    }

}
