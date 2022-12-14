@extends('admin.layouts.main')
@section('contents')
<style>
.answered {
    color: green;
    font-size: 20px
}

.pending {
    color: red;
    font-size: 20px
}
</style>
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View User Prayer List </h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View User Prayer List </div>
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
                                    <th class="wd-15p">User Name</th>
                                    <th class="wd-15p">Prayer Title</th>
                                    <th class="wd-15p">Prayer Description</th>
                                    <th class="wd-15p">Prayer Status</th>
                                    <th class="wd-15p">Admin Response</th>
                                    <th class="wd-15p">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($getData as $key)
                                <tr>
                                    <td>{{$loop->iteration}}</td>
                                    <td>{{($key->UserName)?ucfirst($key->UserName->name):'N/A'}}</td>
                                    <td>{{($key->prayer_title)?ucfirst($key->prayer_title):'N/A'}}</td>
                                    <td>{{($key->prayer_note)?ucfirst($key->prayer_note):'N/A'}}</td>
                                    @if($key->prayer_status == 'answered')
                                    <td><span class="answered">●</span>
                                        {{($key->prayer_status)?ucfirst($key->prayer_status):'N/A'}}</td>
                                    @else
                                    <td><span class="pending">●</span>
                                        {{($key->prayer_status)?ucfirst($key->prayer_status):'N/A'}}</td>
                                    @endif
                                    <td>@if($key->admin_response == 1)Responded @else Not Responded @endif</td>
                                    <td>
                                        <a title="Edit Response" class="btn bg-blue-custom btn-sm"
                                            href="{{ url('/admin/edit-response',$key->id) }}"
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