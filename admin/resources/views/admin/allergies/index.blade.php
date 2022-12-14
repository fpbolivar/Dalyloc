@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Allergy'}} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Allergies </h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Allergies </div>
                        <div class="ml-auto"><a href="{{ url('/admin/add-allergies') }}" title="Add Allergy"
                                data-toggle="tooltip" class="btn bg-blue-custom">Add</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Allergies Name</th>
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
                                            <a title="Edit Allergy" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-allergies',$key->id) }}"
                                                data-toggle="tooltip">Edit</a>

                                            @if($key->is_deleted == '0')
                                            <a title="Delete Allergy" class="btn btn-danger-custom btn-sm"
                                                href="{{ url('/admin/destroy-allergies/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to delete this Allergy ?');"
                                                data-toggle="tooltip">Delete</a>

                                            @endif
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