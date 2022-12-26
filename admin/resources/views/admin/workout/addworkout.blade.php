@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Add Workout' }} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Add Workout </h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'workout'}}"> <i class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <h3 class="card-title">Add Workout </h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Workout Name *</label>
                                    <input type="text" class="form-control" placeholder="Enter workout name"
                                        name="workout_name">
                                    @error("workout_name")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Workout Level</label>
                                    <select class="form-control select2" name="level_id"
                                        data-placeholder="Choose Workout Level">
                                        <option disabled="disabled" selected>Choose Workout Level</option>
                                        <?php  foreach($names as $name) { ?>
                                        <option value="<?= $name['id'] ?>">
                                            <?= $name['workout_level_name'] ?>
                                        </option>
                                        <?php   } ?>
                                    </select>
                                    @error("level_id")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="body">
                                        <label class="form-label">Workout Time (minutes)</label>
                                        <input type="type" class="form-control" name="workout_time"
                                            placeholder="Enter Workout Time">
                                        @error("workout_time")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="body">
                                        <label class="form-label">Image </label>
                                        <input type="file" name="workout_image" class="dropify-event"
                                            data-default-file="" data-allowed-file-extensions="jpeg jpg png">
                                        @error("workout_image")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
@endsection
@section('js')
<script type="text/javascript">
    $('.dropify-event').dropify();
var design = 0;
$("#is_list_on_menu").click(function() {
    if (this.checked) {
        $(this).prop('checked', true); //check 
        design = 1;
    } else {
        $(this).prop('checked', false); //uncheck
        design = 0;
    }
    $('#is_list_on_menu').val(design)

});
</script>

<script src="{{ asset('admin/plugins/ckeditor/ckeditor.js') }}"></script> <!-- Ckeditor -->
<script src="{{ asset('admin/js/pages/forms/editors.js') }}"></script>
@endsection