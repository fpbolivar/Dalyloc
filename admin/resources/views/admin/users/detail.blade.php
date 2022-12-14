{{-- @dd($getUser->toArray()) --}}
@extends('admin.layouts.main')
@section('contents')
<style type="text/css">
.custom-switch {
    padding-left: unset !important;
}

.text-muted {
    color: black !important;
    font-weight: 800;
}
</style>
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">User Detail</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'users'}}"> <i class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>

        <h6 class="page-title" style="font-weight:600">User Detail</h6>
        <div class="card">
            <div class="card-body">
                <div class="body">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <table style="width:100%">
                                <tr>
                                    <td class="text-muted" style="font-size:80%; width:20%">Name:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Email:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Phone no.:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">phone_verified_at:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">device type:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">login type:</td>

                                </tr>
                                <tr>
                                    <td>
                                        {{($user->name)?$user->name:'N/A'}}
                                    </td>
                                    <td>{{($user->email)?$user->email:'N/A'}}
                                    </td>
                                    <td>
                                        {{($user->phone_no)?$user->phone_no:'N/A'}}
                                    </td>
                                    <td>
                                        {{($user->phone_verified_at)?date('m-d-Y H:i:s',strtotime($user->phone_verified_at)):'N/A'}}
                                    </td>
                                    <td>
                                        {{($user->device_type)?$user->device_type:'N/A'}}
                                    </td>
                                    <td>
                                        {{($user->login_type)?ucfirst($user->login_type):'N/A'}}
                                    </td>
                                   
                                </tr>
                            </table>
                            <hr>
                            <table style="width:100%">
                                <tr>
                                    <td class="text-muted" style="font-size:80%; width:20%">DOB:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Age:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Gender:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Height:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">weight:</td>
                                    <td class="text-muted" style="font-size:80%; width:20%">Status:</td>

                                </tr>
                                <tr>
                                    <td>
                                        {{($user->date_of_birth)?$user->date_of_birth:'N/A'}}
                                    </td>
                                    <td>{{($user->age)?$user->age:'N/A'}}
                                    </td>
                                    <td>
                                        {{($user->gender)?$user->gender:'N/A'}}
                                    </td>
                                    <td>
                                        <?php
                                         $inches = $user->height/2.54;
                                         $feet = intval($inches/12);
                                         $inches = $inches%12; 
                                        ?>
                                        {{($user->height)?$feet.".".$inches:'N/A'}}
                                    </td>
                                    <td>{{($user->weight)?$user->weight:'N/A'}}
                                    </td>
                                    <td>@if($user->is_deleted == 1){{'Blocked'}} @else {{'Active'}} @endif
                                    </td>
                                </tr>
                            </table>
                            <hr>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        @if(count($user->UserSubscription) != 0)
        <h6 class="page-title" style="font-weight:600">User Subscriptions</h6>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table id="usersTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th class="wd-15p">#</th>
                                <th class="wd-15p">Plan</th>
                                <th class="wd-15p">Plan Type</th>
                                <th class="wd-15p">Payment Type</th>
                                <th class="wd-15p">Amount</th>
                                <th class="wd-15p">Transaction ID</th>
                                <th class="wd-15p">start date</th>
                                <th class="wd-15p">expiry date</th>
                                <th class="wd-15p">cancel date</th>
                                <th class="wd-15p">Current Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($user->UserSubscription as $key)
                            <tr>
                                <td>{{$loop->iteration}}</td>
                                <td>{{($key->plan_operation)?ucfirst($key->plan_operation):'N/A'}}</td>
                                <td>{{($key->plan_type)?ucfirst($key->plan_type):'N/A'}}</td>
                                <td>{{($key->subscription_type)?ucfirst($key->subscription_type):'N/A'}}</td>
                                <td>${{($key->amount)?$key->amount:'N/A'}}</td>
                                <td>@if($key->subscription_type == 'apple_pay'){{$key->apple_subscription_id}}@else{{$key->subscription_id}}@endif</td>
                                <td>{{($key->start_date)?date('m-d-Y', strtotime($key->start_date)):'N/A'}}</td>
                                <td>{{($key->end_date)?date('m-d-Y', strtotime($key->end_date)):'N/A'}}</td>
                                <td>{{($key->cancel_date)?date('m-d-Y',strtotime($key->cancel_date)):'N/A'}}</td>
                                <td>{{($key->subscription_status)?ucfirst($key->subscription_status):'N/A'}}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        @endif

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