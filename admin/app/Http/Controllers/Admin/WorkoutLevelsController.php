<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;
use App\Models\Model\WorkoutLevel;

class WorkoutLevelsController extends Controller
{   
    /**
     *  index view file 
     */
    public function index(){
        $getData = WorkoutLevel::where('is_deleted','0')->get();
        return view('admin.workoutlevels.index',compact('getData'));
    }

    /**
     *  add workout level view file 
     */
    public function addWorkoutLevel(Request $req, ImageHelper $imageHelper)
    {
        if($req->isMethod('post')){
            $this->validate($req, [
                'workout_name' => 'required',
                'workout_image' => 'mimes:jpeg,png,jpg',
                'workout_description' => 'required',
            ]);
            $workout = new WorkoutLevel;
            $workout->workout_name = $req->workout_name;
            $workout->workout_description = $req->workout_description;
            if($req->has('workout_image')){
                $path = '/images/workoutlevel';
                $workout->workout_image = $imageHelper->UploadImage($req->workout_image,$path);
            }
            // dd($workout);
            if($workout->save()){
                return redirect('admin/workout-level')->with('success', 'Workout level  created successfully.');
            }else{
                return redirect('admin/workout-level')->with('error', 'Something went wrong.');
            }

        }else{
        // add allergies view file     
        return view('admin.workoutlevels.addworkoutlevel');
        }
    }

}
