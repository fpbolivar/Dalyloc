@extends('admin.layouts.main')
@section('contents')

<style>
    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0;
    }
</style>
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Add Admin Commission</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'business-category'}}"> <i
                            class="fa fa-arrow-left "></i>
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
                        <h3 class="card-title">Add Admin Commission</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Admin Commission *</label>
                                    <input type="text" class="form-control" name="admin_commission"
                                        onkeypress="return /[0-9]/i.test(event.key)" maxlength="2">
                                    @error("admin_commission")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
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