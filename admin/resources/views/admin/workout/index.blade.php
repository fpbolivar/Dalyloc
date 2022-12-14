@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Workout </h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Workout </div>
                        <div class="ml-auto"><a href="{{ url('/admin/add-workout') }}" title="Add Workout"
                                data-toggle="tooltip" class="btn bg-blue-custom">Add</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Workout Name</th>
                                        <th class="wd-15p">Workout Time</th>
                                        <th class="wd-15p">Workout Level</th>
                                        <th class="wd-15p">Workout Image</th>
                                        <!-- <th class="wd-15p">Action</th> -->
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->workout_name)?$key->workout_name:'N/A'}}</td>
                                        <td>{{($key->workout_time)?$key->workout_time:'N/A'}}</td>

                                        <td>{{$key->WorkoutLevel ? $key->WorkoutLevel->workout_level_name:'N/A'}}</td>
                                        <td><img src="{{($key->workout_image)?asset($key->workout_image):asset('/images/business/download.png')}}"
                                                width="100" height="100"></td>

                                    </tr>
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