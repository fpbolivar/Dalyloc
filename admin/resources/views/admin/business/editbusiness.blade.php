@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Edit Business Category'}} @endsection

<div class="app-content  my-3 my-md-5">
    {{--@php echo $category->name; exit;@endphp --}}
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Edit Business Category</h6>
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
                <form class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <!-- <h5><a href="{{env('BACK_URL').'category'}}"> <i class="fa fa-arrow-left "></i> Go Back</a> -->
                        <h3 class="card-title">Edit Business Category</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" placeholder="Enter business category name"
                                        name="business_category_name" value="{{$editBusiness->business_category_name}}">
                                    @error("business_category_name")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="body">
                                    <label class="form-label">Image</label>
                                    <input type="hidden" id="justDeleted" name=isDeleted value="">
                                    <input name="image" type="file" class="dropify-event"
                                        data-default-file="{{ $editBusiness->image ? asset($editBusiness->image) : '' }}"
                                        data-allowed-file-extensions="jpeg jpg png">
                                    @error("image")
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

$('.dropify-clear').click(function(e) {
                e.preventDefault();
                $('#justDeleted').val('1')
            });
</script>
<script src="{{ asset('admin/plugins/ckeditor/ckeditor.js') }}"></script> <!-- Ckeditor -->
<script src="{{ asset('admin/js/pages/forms/editors.js') }}"></script>
@endsection