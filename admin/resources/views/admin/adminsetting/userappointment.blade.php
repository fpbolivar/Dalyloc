@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Users Appointment'}} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Users Appointment</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'user-business'}}"> <i
                            class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Users Appointment</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p"> booked_user_name</th>
                                        <th class="wd-15p">booked_user_phone_no</th>
                                        <th class="wd-15p">booked_user_email</th>
                                        <th class="wd-15p">booked_user_message</th>
                                        <th class="wd-15p">appt_status</th>
                                        <th class="wd-15p">appt_from</th>
                                        <th class="wd-15p">appt_date</th>
                                        <th class="wd-15p">appt_start_time</th>
                                        <th class="wd-15p">appt_end_time</th>
                                        <th class="wd-15p">business_id</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($data as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->booked_user_name)?ucfirst($key->booked_user_name):'N/A'}}</td>
                                        <td>{{($key->booked_user_phone_no)?$key->booked_user_phone_no:'N/A'}}</td>
                                        <td>{{($key->booked_user_email)?$key->booked_user_email:'N/A'}}</td>
                                        <td>{{($key->booked_user_message)?$key->booked_user_message:'N/A'}}</td>
                                        <td>{{($key->appt_status)?ucfirst($key->appt_status):'N/A'}}</td>
                                        <td>{{($key->appt_from)?ucfirst($key->appt_from):'N/A'}}</td>
                                        <td>{{($key->appt_date)?$key->appt_date:'N/A'}}</td>
                                        <td>{{($key->appt_start_time)?$key->appt_start_time:'N/A'}}</td>
                                        <td>{{($key->appt_end_time)?$key->appt_end_time:'N/A'}}</td>
                                        <td>{{($key->business_id)?$key->business_id:'N/A'}}</td>

                                        @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- table-wrapper -->
                </div>
                <!-- section-wrapper -->
            </div>
        </div>
    </div>
</div>

@endsection

@section('js')
<script type="text/javascript">
    $('#usersTable').DataTable({
    // dom: 'Bfrtip',
    dom: 'frtip',
    // buttons: [{
    //         extend: 'excelHtml5',
    //         exportOptions: {
    //             columns: ':not(.notexport)'
    //         }
    //     },
    //     {
    //         extend: 'csvHtml5',
    //         exportOptions: {
    //             columns: ':not(.notexport)'
    //         }
    //     }
    // ]
});
</script>
@endsection