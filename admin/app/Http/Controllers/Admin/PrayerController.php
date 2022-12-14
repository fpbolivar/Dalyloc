<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Model\Prayer;

class PrayerController extends Controller
{
    /**
     * index view  file 
     */
    public function Index(){
        $getData = Prayer::where('is_deleted', '0')->get();
        return view('admin.prayer.index',compact('getData'));
   }
   
    public function EditPrayer(Request $req,$id){
        $getPrayer = Prayer::where('id', 1)->where('is_deleted', '0')->first();
        if($req->isMethod('post')){
            // update meal size
            $getPrayer->written_by = $req->written_by;
            $getPrayer->prayer_description =$req->prayer_description;
            if($getPrayer->save()){
                return redirect('admin/prayer')->with('success', 'Prayer update successfully.');
            }else{
                return redirect('admin/prayer')->with('error', 'Something went wrong.');
            }
        }else{
            return view('admin.prayer.editprayer',compact('getPrayer'));
        }
    }
}
