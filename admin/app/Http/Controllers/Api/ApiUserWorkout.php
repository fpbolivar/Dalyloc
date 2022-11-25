<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\WorkoutLevel;
use App\Models\Model\Workout;
use App\Models\Model\Exercise;
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
        $workout = WorkoutLevel::with('Workout')->where('id',$request->workout_level_id)->where('is_deleted','0')->get();
        return response()->json([
            'status' => false,
            'status_code' => true,
            'data' =>$workout
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
        $workoutExercises = Workout::with('WorkoutExercise')->where('id',$request->workout_id)->where('is_deleted','0')->first();
        if($workoutExercises['WorkoutExercise']){
           $ids =  $workoutExercises['WorkoutExercise']['exercise_id'];
           $exerciseIds = explode(",", $ids);
           $exercises = Exercise::whereIn('id',$exerciseIds)->get();
           $workoutExercises['exercises'] = $exercises;
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
            'workout_status' => 'required'
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

        $createUserWorkout = new UserWorkout;
        $createUserWorkout->user_id = auth()->user()->id;
        $createUserWorkout->workout_id = $request->workout_id;
        $createUserWorkout->workout_status = $request->workout_status;
        if($createUserWorkout->save()){
            return response()->json([
                'status' => false,
                'status_code' => true,
                'data' =>$workoutExercises
            ]);
        }

    }
}
