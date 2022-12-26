@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Meal Category'}} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Meal Category</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Meal Category</div>
                        <div class="ml-auto">
                            <a href="{{ url('/admin/add-meal-category') }}" title="Add Meal Category"
                                data-toggle="tooltip" class="btn bg-blue-custom"
                                style="background-color:#f5127b;color:white">Add</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Name</th>
                                        <th class="wd-15p">Image</th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->name)?$key->name:'N/A'}}</td>
                                        <td><img src="{{($key->image)?asset($key->image):asset('/images/business/download.png')}}"
                                                width="100" height="100"></td>
                                        <td>
                                            <a title="Edit Meal Category" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-meal-category/'.$key->id) }}"
                                                data-toggle="tooltip">Edit</a>
                                            <a title="Delete Meal Category" class="btn btn-danger-custom btn-sm"
                                                href="{{ url('/admin/destroy-meal-category/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to delete this meal category?');"
                                                data-toggle="tooltip">Delete</a>
                                        </td>
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