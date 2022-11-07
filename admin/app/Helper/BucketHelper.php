<?php
namespace App\Helper;
// require 'vendor/autoload.php';
// use Aws\S3\S3Client;
// use Aws\S3\Exception\S3Exception;
use AWS;

class BucketHelper 
{

	function AwsUpload($folderName,$fileData)
	{
		$folderName = env('BUCKET_FOLDER').$folderName;
		$uniqueFileName = time().rand(1,1000).'.'.$fileData->getClientOriginalExtension();
		$s3 = AWS::createClient('s3');
		$s3->putObject(array(
		    'Bucket'     => env('AWS_BUCKET'),
		    'Key'        => $folderName.$uniqueFileName,
		    'Body' => file_get_contents($fileData->getPathName()),
	        // 'ACL' => 'public-read',
	        'ContactType' => $fileData->getMimeType()
		));
		return env('BUCKET_BASE_URL').$folderName.$uniqueFileName;
	}

	public function AwsImageUpload($folderName,$fileData)
	{
		$folderName = env('BUCKET_FOLDER').$folderName;
		// dump($folderName);
		// dump(env('BUCKET_BASE_URL'));
		// dd();
		$uniqueFileName = time().rand(1,1000).'.jpg';
		$s3 = AWS::createClient('s3');
		$s3->putObject(array(
		    'Bucket' => env('AWS_BUCKET'),
		    'Key' => $folderName.$uniqueFileName,
		    'Body' => $fileData,
	        // 'ACL' => 'public-read',
	        'ContactType' => '.jpg',
		));
		return env('BUCKET_BASE_URL').$folderName.$uniqueFileName;
	}

	


	// audio upload
	function AwsUploadAudio($folderName,$fileData)
	{
		ini_set('memory_limit', '-1'); 

		$folderName = env('BUCKET_FOLDER').$folderName;
		$uniqueFileName = time().rand(1,1000).'.'.$fileData->getClientOriginalExtension();
		$s3 = AWS::createClient('s3');
		$s3->putObject(array(
		    'Bucket'     => env('AWS_BUCKET_AUDIO'),
		    'Key'        => $folderName.$uniqueFileName,
		    'Body' => file_get_contents($fileData->getPathName()),
	        // 'ACL' => 'public-read',
	        'ContactType' => $fileData->getMimeType()
		));
		return env('BUCKET_BASE_URL_AUDIO').$folderName.$uniqueFileName;
	}

	// audio files genrate url
	public function GenrateUrl($url)
	{
		if (empty($url)) {
			return "";
		}
		// $updatedUrl = str_replace(env('BUCKET_BASE_URL_AUDIO'), '', $url);
		// $s3Client = AWS::createClient('s3');
		// $cmd = $s3Client->getCommand('GetObject', [
		//         'Bucket' => env('AWS_BUCKET_AUDIO'),
		//         'Key'    => $updatedUrl
		//     ]);
        //                 return "";
        // }
        $bucket = env('AWS_BUCKET_AUDIO');
        if (strpos($url, env('BUCKET_BASE_URL_AUDIO')) !== false) {
                $url = str_replace(env('BUCKET_BASE_URL_AUDIO'), '', $url);
        }elseif (strpos($url, 'https://zygobucketliveaudio.s3.amazonaws.com/') !== false) {
                $url = str_replace('https://zygobucketliveaudio.s3.amazonaws.com/', '', $url);
                $bucket = 'zygobucketliveaudio';
        }

        $s3Client = AWS::createClient('s3');
        $cmd = $s3Client->getCommand('GetObject', [
                'Bucket' => $bucket,
                'Key'    => $url
            ]);
                // create url


		// create url
	    $request = $s3Client->createPresignedRequest($cmd, '+30 minutes');
		$presignedUrl = (string) $request->getUri();
	    // dd($presignedUrl);
		return $presignedUrl;
	}

	// upload audio from bucket
	public function UploadAudioFiles($bucket,$folderName,$file_name,$fileData)
	{
		// $folderName = env('BUCKET_FOLDER').$folderName;
			// dd($file_name);
		// $uniqueFileName = time().rand(1,1000).'.mp3';
		$s3 = AWS::createClient('s3');
		

		$s3->putObject(array(
		    'Bucket' => $bucket,
		    'Key' => $folderName.$file_name,
		    'Body' => @file_get_contents($fileData),
	        // 'ACL' => 'public-read',
	        // 'ContactType' => '.mp3',
		));

	}

	public function CreatePresignedUrl($Bucket="",$name="")
	{
		if (empty($Bucket)) {
			return "";
		}
		$s3Client = AWS::createClient('s3');
		$cmd = $s3Client->getCommand('GetObject', [
		        'Bucket' =>$Bucket,
		        'Key'    => $name
		    ]);
		// create url
	    	$request = $s3Client->createPresignedRequest($cmd, '+30 minutes');
		$presignedUrl = (string) $request->getUri();
		return $presignedUrl;
	}
}

