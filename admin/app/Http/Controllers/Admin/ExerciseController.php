<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Exercise;
use App\Helper\ImageHelper;
use Illuminate\Support\Facades\File;

class ExerciseController extends Controller
{
     /**
     * index view file
     */
    public function Index(){
        //get all allergy list 
        $getData = Exercise::where('is_deleted','0')->get();
        // index view  file     
        return view('admin.exercise.index',compact('getData'));
    }

    /**
     *  add exercise  view file 
     */
    public function AddExercise(Request $req, ImageHelper $imageHelper)
    {

        if($req->isMethod('post')){
           
            $this->validate($req, [
                'exercise_name' => 'required',
                'exercise_time' => 'required',
                'exercise_video' => 'mimetypes:video/mp4',
                'exercise_image' => 'mimes:jpeg,png,jpg',
              
            ]);
            // add  new exercise
            $exercise = new Exercise;
            $exercise->exercise_name = $req->exercise_name;
            $exercise->exercise_time = $req->exercise_time;
            if($req->has('exercise_image')){
                $path = '/images/exercise/image';
                $exercise->exercise_image = $imageHelper->UploadImage($req->exercise_image,$path);
            }
            if($req->has('exercise_video')){
                $path = '/images/exercise/video';
                $exercise->exercise_video = $imageHelper->UploadImage($req->exercise_video,$path);
            }
            
            if($exercise->save()){
                return redirect('admin/exercise')->with('success', 'Exercise created successfully.');
            }else{
                return redirect('admin/exercise')->with('error', 'Something went wrong.');
            }

        }else{
        // add allergies view file     
        return view('admin.exercise.addexercise');
        }
    }
}
