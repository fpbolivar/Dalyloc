<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Workout;
use App\Models\Model\WorkoutLevel;

class WorkoutController extends Controller
{
    /**
     * index view  file 
     */
    public function index(){
        //get all workout list
        $getData = Workout::with('workoutlevel')->where('is_deleted','0')->get();
        // index view file 
        return view('admin.workout.index',compact('getData'));
    }


    /**
     *  add workout view file 
     */
    public function addWorkout(Request $req)
    {  
        $names = WorkoutLevel::where('is_deleted','0')->get();
        if($req->isMethod('post')){
            $this->validate($req, [
                'workout_name' => 'required',
                'workout_time' => 'required',
                'level_id' => 'required',
            ]);
            // add new workout 
            $workout = new Workout;
            $workout->workout_name = $req->workout_name;
            $workout->workout_time = $req->workout_time;
            $workout->level_id = $req->level_id;
            if($workout->save()){
                return redirect('admin/workout')->with('success', 'Workout   created successfully.');
            }else{
                return redirect('admin/workout')->with('error', 'Something went wrong.');
            }

        }else{
        // add allergies view file     
        return view('admin.workout.addworkout',compact('names'));
        }
    }
}
