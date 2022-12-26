<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Workout;
use App\Models\Model\WorkoutLevel;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class WorkoutController extends Controller
{
    /**
     * index view  file 
     */
    public function Index(){
        //get all workout list
        $getData = Workout::with('WorkoutLevel')->where('is_deleted','0')->get();
        // index view file 
        return view('admin.workout.index',compact('getData'));
    }


    /**
     *  add workout view file 
     */
    public function AddWorkout(Request $req, ImageHelper $imageHelper)
    {  
        $names = WorkoutLevel::where('is_deleted','0')->get();
        if($req->isMethod('post')){

            $this->validate($req, [
                'workout_name' => 'required',
                'workout_time' => 'required',
                'level_id' => 'required',
                'workout_image' => 'required|mimes:jpeg,png,jpg'
            ]);

            // add new workout 
            $workout = new Workout;
            $workout->workout_name = $req->workout_name;
            $workout->workout_time = $req->workout_time;
            $workout->level_id = $req->level_id;
            if($req->has('workout_image')){
                $path = '/images/workout-image';
                $workout->workout_image = $imageHelper->UploadImage($req->workout_image,$path);
            }   
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
