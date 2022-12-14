<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\WorkoutExercise;
use App\Models\Model\Workout;
use App\Models\Model\Exercise;

class WorkoutExerciesController extends Controller
{   
    /**
     *  index view file  
     */
    public function Index(){
        // get all workout exercise
        $getData = WorkoutExercise::with('workout')->where('is_deleted','0')->get();
        foreach($getData as $data) { 
                $test = [];  
                $exer_id = explode(',', $data->exercise_id);
                $getExercise = Exercise::whereIn('id',$exer_id)->get()->toArray();
                foreach($getExercise as $value) {
                    array_push($test,$value['exercise_name']);
                }
                $data['name']=implode(" ,",$test);
        }
        // index file view 
        return view('admin.workoutexercise.index',compact('getData'));
    }

    /**
     *  add workout exercies view file 
     */
    public function AddWorkoutExercise(Request $req)
    {   
        //get all exercise in drop down 
        $exercise = Exercise::where('is_deleted','0')->get();
        //get all workout in drop down 
        $workout = Workout::where('is_deleted','0')->get();
        if($req->isMethod('post')){
            // $messages = [
            //     'workout_id.required.not_in' => 'workout_id is required'
            // ];
            $this->validate($req, [
                'workout_id' => 'required',
                // 'exercise_id' => ['required']
            ]);
            $workout = WorkoutExercise::where('workout_id',$req->workout_id)->where('is_deleted','0')->first();
 
            if(empty($workout)){
                //add new workout exercise
                // dd('herer');
                $add_data = new WorkoutExercise;
                $add_data->workout_id = $req->workout_id;
                $add_data->exercise_id = $req->exercise_id ? implode(",",$req->exercise_id) :"";
                if($add_data->save()){
                    return redirect('admin/workout-exercise')->with('success', 'Workout Exercise  created successfully.');
                }else{
                    return redirect('admin/workout-exercise')->with('error', 'Something went wrong.');
                }
            }else{
                return redirect()->back()->withErrors(['workout_id' => 'This  workout already used']);
            }

        }else{
            // add workoutexercise view file     
            return view('admin.workoutexercise.addworkoutexercise',compact('exercise','workout'));
        }
    }

}
