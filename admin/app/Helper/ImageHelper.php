<?php
namespace App\Helper;
/**
 *  Image Upload Helper
 */
class ImageHelper 
{
	
	/**
	 * [UploadImage Create Upload Image Path]
	 * @param [array] $image [description]
	 * @param [array] $path  [description]
	 */
	public function UploadImage($image,$path)
	{
	    $name = time().rand(1,1000).'.'.$image->getClientOriginalExtension();
	    $destinationPath = public_path($path);
	    $image->move($destinationPath, $name);
	    return $path."/".$name;
	}
	/**
	 * [CheckFile Check If Image is exist in folder or not]
	 * @param [array] $path   [Image Path]
	 * @param [array] $delete [1]
	 */
	public function CheckFile($path,$delete)
	{
		if ($delete == 1) {
			$returnData = file_exists(public_path($path));
			if($returnData){
				if (!empty($path)) {
					return $this->DeleteFile($path);
				}
			}
			return $returnData; 
		}else{
			return file_exists(public_path($path));
		}
	}
	/**
	 * [DeleteFile Delete Image]
	 * @param [array] $path [Image Path]
	 */
	public function DeleteFile($path)
	{
		return unlink(public_path($path));
	}

}