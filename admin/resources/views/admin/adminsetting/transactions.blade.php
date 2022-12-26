@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Appointment Transactions'}} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Appointment Transactions</h6>
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
                        <div class="card-title">View Appointment Transactions</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p"> payment_status</th>
                                        <th class="wd-15p">advance_payment</th>
                                        <th class="wd-15p">advance_Payment_transaction_id</th>
                                        <th class="wd-15p">pending_payment</th>
                                        <th class="wd-15p">total_payment</th>
                                        <th class="wd-15p">total_transaction_id</th>
                                        <th class="wd-15p">service_price</th>
                                        <th class="wd-15p">admin_commission_percentage</th>
                                        <th class="wd-15p">admin_commission_amt</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($data as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->payment_status)?ucfirst($key->payment_status):'N/A'}}</td>
                                        <td>{{($key->advance_payment)?'$'.$key->advance_payment:'N/A'}}</td>
                                        <td>{{($key->advance_transaction_id)?$key->advance_transaction_id:'N/A'}}</td>
                                        <td>{{($key->pending_payment)?'$'.$key->pending_payment:'N/A'}}</td>
                                        <td>{{($key->total_payment)?'$'.$key->total_payment:'N/A'}}</td>
                                        <td>{{($key->full_transaction_id)?$key->full_transaction_id:'N/A'}}</td>
                                        <td>{{($key->service_price)?'$'.$key->service_price:'N/A'}}</td>
                                        <td>{{($key->admin_commission_percentage)?$key->admin_commission_percentage:'N/A'}}
                                        </td>
                                        <td>{{($key->admin_commission_amt)?'$'.$key->admin_commission_amt:'N/A'}}</td>
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