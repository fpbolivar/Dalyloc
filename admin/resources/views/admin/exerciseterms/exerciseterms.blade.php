@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Exercise Terms'}} @endsection

<div class="app-content  my-3 my-md-5">
    {{--@php echo $category->name; exit;@endphp --}}
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title"> Exercise Terms</h6>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <!-- <h5><a href="{{env('BACK_URL').'category'}}"> <i class="fa fa-arrow-left "></i> Go Back</a> -->
                        <h3 class="card-title">Exercise Terms</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-12">
                                {{-- <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">WYSIWYG Editor style1</div>
                                    </div> --}}
                                    <textarea class="content" name="option_value">{{
                                            $update->option_value
                                        }}</textarea>
                                    @error("option_value")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                    {{--
                                </div> --}}
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button type="submit" class="btn btn-primary">Update</button>
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