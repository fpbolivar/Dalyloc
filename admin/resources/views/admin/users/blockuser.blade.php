@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View User Block' }} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Users Block</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Users Block</div>
                        {{-- <div class="ml-auto"><a href="{{ url('/admin/excel-export') }}" title="Execel File "
                                data-toggle="tooltip" class="btn" style="background-color:#f5127b;color:white">Excel</a>
                        </div> --}}
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Name</th>
                                        <th class="wd-15p">Email</th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($allUsers as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->name)?$key->name:'N/A'}}</td>
                                        <td>{{($key->email)?$key->email:'N/A'}}</td>
                                        <td>
                                            <a title="View User" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/user-view/'.$key->id) }}"
                                                data-toggle="tooltip">View</a>
                                            @if($key->is_deleted == '0')
                                            <a title="Block User" class="btn btn-danger-custom btn-sm"
                                                href="{{ url('/admin/destroy-user/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to block this User ?');"
                                                data-toggle="tooltip">Block</a>
                                            @else
                                            <a title="Restore User" class="btn btn-success-custom btn-sm"
                                                href="{{ url('/admin/destroy-user/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to restore this User ?');"
                                                data-toggle="tooltip">Restore</a>
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