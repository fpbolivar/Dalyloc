@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View User Business Bank' }} @endsection
<style>
    .verified {
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
            <h6 class="page-title">View User Business Bank</h6>
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
                        <div class="card-title">View User Business Bank</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">holder name</th>
                                        <th class="wd-15p">bank stripe id</th>
                                        <th class="wd-15p">bank name</th>
                                        <th class="wd-15p">account number</th>
                                        <th class="wd-15p">routing number</th>
                                        <th class="wd-15p">bank status</th>
                                        <th class="wd-15p">bank reason</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->holder_name)?ucfirst($key->holder_name):'N/A'}}</td>
                                        <td>{{($key->bank_stripe_id)?$key->bank_stripe_id:'N/A'}}</td>
                                        <td>{{($key->bank_name)?ucfirst($key->bank_name):'N/A'}}</td>
                                        <td>{{($key->account_number)?$key->account_number:'N/A'}}</td>
                                        <td>{{($key->routing_number)?$key->routing_number:'N/A'}}</td>
                                        @if($key->bank_status == 0)
                                        <td><span class="pending">●</span>
                                            Pending</td>
                                        @else
                                        <td><span class="verified">●</span>
                                            Verified</td>
                                        @endif
                                        <td>@if($key->bank_reason) {{$key->bank_reason}} @else N/A @endif</td>
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