<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Model\CreateTask;
use App\Models\Model\CreateSubtask;
use Validator;
use App\Models\Model\UserWorkout;
use App\Models\Model\UserAppointment;

class CreateTaskController extends Controller
{
    public function CreateTask(Request $request){
            // validate
    	 $validator = Validator::make($request->all(),[
            'tId' => 'required',
            // 'email' => 'required|min:6',
             'taskName' => 'required',
            // 'howLong'=> 'required',
            // 'howOften'=> 'required',
            'isCompleted'=> 'required',
            'startTime'=> 'required',
            'endTime'=> 'required',
            'dateString' => 'required',
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
        $createTask = new CreateTask;
        $createTask->user_id = auth()->user()->id;
        $createTask->t_Id = $request->tId;
        $createTask->email = $request->email;
        $createTask->task_name = $request->taskName;
        $createTask->location = $request->location;
        $createTask->lat = $request->lat;
        $createTask->lng = $request->lng;
        $createTask->task_type = $request->task_type;
        $createTask->utc_date_time = $request->utcDateTime;
        $createTask->task_time_stamp = $request->taskTimeStamp;
        $createTask->create_time_stamp = $request->createTimeStamp;
        $createTask->how_long = $request->howLong;
        $createTask->how_often = $request->howOften;
        $createTask->note = $request->note;
        $createTask->is_completed = $request->isCompleted;
        // $createTask->subNotes = $request->subNotes;
        $createTask->date_format = $request->dateString;
        $createTask->start_task_time = $request->startTime;
        $createTask->end_task_time = $request->endTime; 
        $createTask->save();
        if (count($request->subNotes) != 0) { 
            foreach ($request->subNotes as $subNote) { 
               $createSubTask = new CreateSubtask;
                $createSubTask->create_task_id = $createTask->id;
                $createSubTask->user_id = auth()->user()->id;
                $createSubTask->s_id = $subNote['sId'];
                $createSubTask->description = $subNote['description'];
                $createSubTask->is_completed = $subNote['isCompleted'];
                $createSubTask->save();     
               
            }
        }
        return response()->json([
            'status' => true,
            'status_code' => true,
            'message' =>'Created Task Successfully.',
            'task_id' => $createTask->id
        ]);


    }
    
    public function UpdateTask(Request $request){
     $validator = Validator::make($request->all(),[
        'tId' => 'required',
        // 'email' => 'required|min:6',
        'howLong'=> 'required',
        'howOften'=> 'required',
        'isCompleted'=> 'required',
        'startTime'=> 'required',
        'endTime'=> 'required',
        'dateString' => 'required',
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
    $userId = auth()->user()->id;
    $updateTask = CreateTask::where('user_id',$userId)->find($request->id);
    if($updateTask){
        $updateTask->user_id = $userId;
        $updateTask->t_Id = $request->tId;
        $updateTask->email = $request->email;
        $updateTask->task_name = $request->taskName;
        $updateTask->utc_date_time = $request->utcDateTime;
        $updateTask->task_time_stamp = $request->taskTimeStamp;
        $updateTask->create_time_stamp = $request->createTimeStamp;
        $updateTask->how_long = $request->howLong;
        $updateTask->how_often = $request->howOften;
        $updateTask->note = $request->note;
        $updateTask->is_completed = $request->isCompleted;
        $updateTask->date_format = $request->dateString;
        $updateTask->start_task_time = $request->startTime;
        $updateTask->end_task_time = $request->endTime; 
        $updateTask->save();

        //delete sub type first
        $deleteSubTask = CreateSubtask::where('user_id',$userId)->where('create_task_id',$request->id)->get();
        if(count($deleteSubTask) != 0){
            $deleteSubTasks = $deleteSubTask->toArray();
            $ids = array_column($deleteSubTasks, 'id');
            $updateData = CreateSubtask::whereIn('id',$ids)->delete();
        } 

        //again add etries for subtask
        if (count($request->subNotes) != 0) { 
            foreach ($request->subNotes as $subNote) { 
               $createSubTask = new CreateSubtask;
                $createSubTask->create_task_id = $updateTask->id;
                $createSubTask->user_id = $userId;
                $createSubTask->s_id = $subNote['sId'];
                $createSubTask->description = $subNote['description'];
                $createSubTask->is_completed = $subNote['isCompleted'];
                $createSubTask->save();               
            }
        }

        return response()->json([
            'status' => true,
            'status_code' => true,
            'message' =>'Updated Successfully.'
        ]); 
        

    }else{
               return response()->json([
            'status' => false,
            'status_code' => true,
            'message' =>'Data Not Found.'
        ]);
    }
}
    public function DeleteTask($id){
        $userId = auth()->user()->id;
        $deleteTask = CreateTask::where('user_id',$userId)->find($id);
        if($deleteTask){
            $deleteSubTask = CreateSubtask::where('user_id',$userId)->where('create_task_id',$id)->get();
            if(count($deleteSubTask) != 0){
                $deleteSubTasks = $deleteSubTask->toArray();
                $ids = array_column($deleteSubTasks, 'id');
                $updateData = CreateSubtask::whereIn('id',$ids)->delete();
            }    
            if($deleteTask->delete()){
                return response()->json([
                    'status' => false,
                    'status_code' => false,
                    'message' => 'Deleted Successfully.'
                ]);
            }else{
                return response()->json([
                    'status' => false,
                    'status_code' => false,
                    'message' => 'Something Went Wrong.'
                ]);
            }


        }else{
            return response()->json([
                'status' => false,
                'status_code' => false,
                'message' => 'Data Not Found.'
            ]);
        }

    }

    public function AllTaskByDate(Request $request){
            // validate
    	 $validator = Validator::make($request->all(),[
            'dateString' => 'required',
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
        $userId = auth()->user()->id;
        $date = $request->dateString;
        $allTask = CreateTask::with('SubTaks')->where('user_id',$userId)->where('date_format',$date)->get();
        $allPendingWorkouts = UserWorkout::with('UserWorkout')->where('user_id',$userId)->where('workout_status','pending')->get();
        foreach($allPendingWorkouts as $key){
            foreach($key->UserWorkout as $name){
                $key['task_name'] = $name->workout_name;
            }
        }
        // $allSubTask = CreateSubtask::where('user_id',$userId)->where('date_format',$date)->get();
            return response()->json([
                'status' => true,
                'status_code' => true,
                'allTask' => $allTask,
                'allPendingWorkouts' => $allPendingWorkouts
            ]);

    }

    public function GetApptDeatilCreateTask(Request $request){
        //validate
    	 $validator = Validator::make($request->all(),[
            'task_type' => 'required',
            'appt_id' => 'required'
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

        $businessApptDetail = UserAppointment::where('id',$request->appt_id)->first();
        if($businessApptDetail){
            if($request->task_type = "user_appointment"){
                $businessApptDetail['detail_about'] = 'user_appointment';
            }else if($request->task_type = "business_appointment"){
                $businessApptDetail['detail_about'] = 'business_appointment';
            }
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => $businessApptDetail,
            ]);
        }else{
            return response()->json([
                'status' => true,
                'status_code' => true,
                'data' => 'No Data Found.',
            ]);
        }
    }

}