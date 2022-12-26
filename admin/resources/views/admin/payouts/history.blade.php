@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Active Users' }} @endsection


<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Payout History</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Payout History</div>
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
                                        <th class="wd-15p">Phone</th>
                                        <th class="wd-15p">Email</th>
                                        <th class="wd-15p">Appointment From</th>
                                        <th class="wd-15p">Payout Status</th>
                                        {{-- <th class="wd-15p noExport">Action</th> --}}
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->UserBusiness)?$key->UserBusiness->business_name:'N/A'}}</td>
                                        <td>{{($key->UserBusiness->User->name)?$key->UserBusiness->User->name:'N/A'}}
                                        </td>
                                        <td>{{($key->UserBusiness->User->phone_no)?$key->UserBusiness->User->phone_no:'N/A'}}
                                        </td>
                                        <td>{{($key->UserBusiness->User->email)?$key->UserBusiness->User->email:'N/A'}}
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
    buttons: [{
            extend: 'excelHtml5',
            exportOptions: {
                // columns: ':not(.notexport)'
                columns: "thead th:not(.noExport)"
            }
        }
        // {
        //     extend: 'csvHtml5',
        //     exportOptions: {
        //         columns: ':not(.notexport)'
        //     }
        // }
    ]
});
</script>
@endsection