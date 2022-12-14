@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Admin Commission</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Admin Commission</div>
                        <div class="ml-auto"><a href="{{ url('/admin/add-commission') }}" title="Add Commission"
                                data-toggle="tooltip" class="btn bg-blue-custom">Add</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Commission % </th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->admin_commission)?$key->admin_commission:'N/A'}}</td>

                                        <td>
                                            <a title="Edit Admin Commission" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-commission/'.$key->id) }}"
                                                data-toggle="tooltip">Edit</a>
                                            @if($key->is_deleted == '0')
                                            <a title="Admin Commission" class="btn btn-danger-custom btn-sm"
                                                href="{{ url('/admin/destroy-commission/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to block this Admin Commission ?');"
                                                data-toggle="tooltip">Block</a>
                                            {{-- @else
                                            <a title="Restore Business Category" class="btn btn-success-custom btn-sm"
                                                href="{{ url('/admin/destroy-business-category/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to restore this Business Category ?');"
                                                data-toggle="tooltip">Restore</a> --}}
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