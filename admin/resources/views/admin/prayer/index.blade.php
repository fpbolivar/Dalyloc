@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Prayer </h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Prayer </div>
                        {{-- <div class="ml-auto"><a href="{{ url('/admin/add-allergies') }}" title="Add Allergies"
                                data-toggle="tooltip" class="btn bg-blue-custom">Add</a>
                        </div> --}}
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Writer Name</th>
                                        <th class="wd-15p">Prayer</th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>


                                    @foreach($getData as $key)

                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->written_by)?$key->written_by:'N/A'}}</td>
                                        <td>{{($key->prayer_description)?$key->prayer_description:'N/A'}}</td>

                                        <td>
                                            <a title="Edit Prayer" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-prayer',$key->id) }}"
                                                data-toggle="tooltip">Edit</a>


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