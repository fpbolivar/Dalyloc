@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Add Meal Size</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'mealsize'}}"> <i class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="">
                    @csrf
                    <div class="card-header">
                        <h3 class="card-title">Add Meal Size</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label"> Name *</label>
                                    <input type="text" class="form-control" placeholder="Enter meal name"
                                        name="meal_name" maxlength="50">
                                    @error("meal_name")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="body">
                                        <label class="form-label">Description</label>
                                        <textarea rows="5" cols="5" class="form-control" name="meal_description"
                                            maxlength="50"></textarea>
                                        @error("description")
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
<!-- <script type="text/javascript">
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

}); -->
</script>

<script src="{{ asset('admin/plugins/ckeditor/ckeditor.js') }}"></script> <!-- Ckeditor -->
<script src="{{ asset('admin/js/pages/forms/editors.js') }}"></script>
@endsection