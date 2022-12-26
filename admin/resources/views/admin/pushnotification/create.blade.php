@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Add Notification'}} @endsection

<style type="text/css">
    .select2-selection--multiple .select2-selection__rendered {
        height: 100px !important;
        overflow-y: auto !important;
    }
</style>

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Add Notification</h6>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form id="validateNotification" class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <h3 class="card-title">Push Notification</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Select User</label>
                                    <select class="form-control userList select2" name="users[]"
                                        data-placeholder="Select User" required="" multiple>
                                        <option value="all">all</option>
                                        @forelse($getUser as $key)
                                        <option value="{{$key->id}}">
                                            {{($key->name)?$key->name:"N/A"}}
                                        </option>
                                        @empty
                                        @endforelse
                                    </select>
                                    @error("users")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="form-label">Want To Schedule Notification</label>
                                    <select id="is_sent" class="form-control select" required="" name="is_sent"
                                        required="" data-placeholder="Select Tag">
                                        <option value="1">Schedule Notification</option>
                                        <option selected="" value="0">Send Notification Now</option>
                                    </select>
                                    @error("is_sent")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
                            <script
                                src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/js/standalone/selectize.min.js"
                                integrity="sha256-+C0A5Ilqmu4QcSPxrlGpaZxJ04VjsRjKu+G82kl5UJk=" crossorigin="anonymous">
                            </script>
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/css/selectize.bootstrap3.min.css"
                                integrity="sha256-ze/OEYGcFbPRmvCnrSeKbRTtjG4vGLHXgOqsyLFTRjg="
                                crossorigin="anonymous" />

                            <div class="col-lg-6" id="ScheduleDateTime" style="display: none;">
                                <div class="form-group">
                                    <label class="form-label">Schedule Date</label>
                                    <input id="scheduledatetimepicker" class="form-control" name="schedule_date_time">
                                    @error("schedule_date_time")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Title</label>
                                    <input type="text" class="form-control" placeholder="Enter title" name="title"
                                        required>
                                    @error("title")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">Message</div>
                                    </div>
                                    <div class="card-body">
                                        <textarea required="" class="form-control" cols="5" rows="7"
                                            name="message"></textarea>
                                        @error("message")
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
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<script>
    $('#scheduledatetimepicker').datetimepicker({
    uiLibrary: 'bootstrap4',
    modal: true,
    footer: true,
    format: 'dd mmmm yyyy HH:MM'
});
</script>

<script type="text/javascript">
    $('#is_sent').change(function() {
    var is_sent = this.value;
    if (is_sent == 1) {
        $('#ScheduleDateTime').show();
        $('#scheduledatetimepicker').attr('required', true);

    } else if (is_sent) {
        $('#ScheduleDateTime').hide();
        $('#scheduledatetimepicker').removeAttr('required');

    }
});
</script>
<script type="text/javascript">
    $("#validateNotification").validate({
    errorClass: "text-danger",
    //validClass: "text-success",
    rules: {
        users: {
            required: true,
        },
        tags: {
            required: true,
        },
        schedule_date: {
            required: true,
        },
        message: {
            required: true,
        },
    },
    messages: {
        users: {
            required: "This field is required.",
        },
        tags: {
            required: "This field is required.",
        },
        schedule_date: {
            required: "This field is required.",
        },
        message: {
            required: "This field is required.",
        },
    },
});
</script>
<!-- <script type="text/javascript">
$(document).ready(function() {
    $('.userList').select2({
    placeholder: 'Select Users',
    width: '100%',
    border: '1px solid #e4e5e7',
    });
});

$('.userList').on("select2:unselect", function (e) {
    var $select = $('.userList');
    var idToRemove = 'all';

    var values = $select.val();
    if (values) {
        var i = values.indexOf(idToRemove);
        if (i >= 0) {
            values.splice(i, 1);
            $select.val(values).change();
        }
    }
});
$('.userList').on("select2:select", function (e) { 
   var data = e.params.data.text;
   //alert(data);
   if(data=='all'){
      $(".userList > option").prop("selected","selected");
      $(".userList").trigger("change");
   }else{
      
   }
});


</script> -->


@endsection