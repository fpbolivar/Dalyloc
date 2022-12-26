<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\UserPrayer;
use App\Models\Model\Prayer;
use App\Models\User;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Exports\UserExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Models\Model\PrayerCategory;
use App\Models\Model\UserPrayerResponse;
use Validator;
use App\Helper\PushHelper;

class UserPrayerController extends Controller
{
     /**
     * index view  file 
     */
    public function Index(){
        $getData = UserPrayer::with('UserName')->where('is_deleted', '0')->get();
        foreach($getData as $key){
            $checkResponse = UserPrayerResponse::where('user_id', $key->user_id)->where('user_prayer_id',$key->id)->first();
            if($checkResponse){
                $key['admin_response'] = 1;
            }else{
                $key['admin_response'] = 0;

            }
        }
       return view('admin.userprayer.index',compact('getData'));
   }
    /**
     * response prayer 
     */
   public function ResponsePrayer(Request $req , $id, PushHelper $helper){
        $getPrayer = UserPrayer::where('id', $id)->where('is_deleted', '0')->first();
        $allResponse = UserPrayerResponse::where('user_id', $getPrayer->user_id)->where('user_prayer_id',$id)->get();
        $user = User::where('id',$getPrayer->user_id)->first();
        if($req->isMethod('post')){
            $this->validate($req, [
                'user_prayer_response' => 'required'
            ]);
            $add = new UserPrayerResponse ;
            $add->user_id = $getPrayer->user_id;
            $add->user_prayer_id = $getPrayer->id;
            $add->user_prayer_response = $req->user_prayer_response;
            if($add->save()){
                if($user){
                    $deviceToken = $user->device_token;
                    $title = $getPrayer->prayer_title;
                    $msg = $req->user_prayer_response;
                    $notification_type = 'Admin Response for User`s Prayer';
                    $userId = $user->id;
                    $notification_source = 'dashboard'; 
                    if (!empty($deviceToken)) {
                        $helper->SendNotification($deviceToken,$title,$msg,$userId,$notification_type,$notification_source);
                    }else{
                        $status = $helper->addNotificationRecord($userId,$notification_type,$title,$msg,$notification_source);
                    }
                }
                return redirect('admin/edit-response/'.$id)->with('success', 'Prayer response sent successfully.');
            }else{
                return redirect('admin/edit-response/'.$id)->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.userprayer.edituserprayer',compact('getPrayer','allResponse'));

        }

   }
  
   public function PrayerCategory(){
    $getData = PrayerCategory::orderBy('prayer_category_name')->get();
    return view('admin.prayercategories.index',compact('getData'));
   }

   //add prayer category
   public function AddPrayerCategory(Request $request){
      //if post then add data
      if($request->isMethod('post')){
        $this->validate($request, [
            'prayer_category_name' => 'required|unique:prayer_categories,prayer_category_name'
        ]);
        $data = new PrayerCategory;
        $data->prayer_category_name = $request->prayer_category_name;
        if($data->save()){
            return redirect('admin/prayer-category')->with('success', 'Prayer Category created successfully.');
        }else{
            return redirect('admin/prayer-category')->with('error', 'Something went wrong.');
        }
    }else{
        return view('admin.prayercategories.addprayercategory');
    }
   }

   //edit prayer category
   public function EditPrayerCategory(Request $request,$id){
    $editData = PrayerCategory::where('id',$id)->first();
    if ($request->isMethod('post')) {
        $this->validate($request, [
            'prayer_category_name' => 'required|unique:prayer_categories,prayer_category_name,'.$id,
        ]);
            $editData->prayer_category_name = $request->prayer_category_name;
            if($editData->save()){
                return redirect('admin/prayer-category')->with('success', 'Business Category updated successfully.');
            }else{
                return redirect('admin/prayer-category')->with('error', 'Something went wrong.');
            }
    }else{
            return view('admin.prayercategories.editprayercategory',compact('editData')); 
    }
   }

   //delete prayer category
   public function DeletePrayerCategory($id){
     
    $data = PrayerCategory::find($id);
    if ($data->is_deleted == "1") {
        $data->is_deleted = "0";
        $data->save();
        return redirect('admin/prayer-category')->with('success', 'Prayer Category restored successfully.');
    } else {
        $data->is_deleted = "1";
        $data->save();
        return redirect('admin/prayer-category')->with('success', 'Prayer Category blocked successfully.');
    }
   }
}