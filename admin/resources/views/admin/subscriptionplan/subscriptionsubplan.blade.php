@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Subscription Sub Plan' }} @endsection


<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Subscription Sub Plans </h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'subscription-plan'}}"> <i
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
                        <div class="card-title">View Subscription Sub Plans </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Plan Name</th>
                                        <th class="wd-15p">Sub Plan Name</th>
                                        <th class="wd-15p">Subscription price </th>
                                        <th class="wd-15p">amount</th>
                                        <th class="wd-15p">Subscription Type</th>
                                        <th class="wd-15p">Status</th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($subscriptionSubPlans as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->Plan->name)?$key->Plan->name:'N/A'}}</td>
                                        <td>{{($key->name)?$key->name:'N/A'}}</td>
                                        <td>{{($key->subscription_price_id)?$key->subscription_price_id:'N/A'}}</td>
                                        <td>{{($key->amount)? '$'.$key->amount:'N/A'}}</td>
                                        <td>{{($key->type)?ucfirst($key->type):'N/A'}}</td>

                                        <td>
                                            @if($key->is_deleted == '0')
                                            <a href="{{ url('/admin/destroy-subscription-sub-plan/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to Inactive this Subscription Sub Plan ?');"><input
                                                    type="checkbox" name="is_Designed" value="0" <?php
                                                    if($key->is_deleted == '0'){echo "checked";}?>
                                                class="custom-switch-input payment_status">
                                                <span class="custom-switch-indicator"></span>

                                                <div class="control__indicator"></div>
                                            </a>
                                            @else
                                            <a href="{{ url('/admin/destroy-subscription-sub-plan/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to Active this Subscription Sub Plan ?');"><input
                                                    type="checkbox" name="is_Designed" value="0"
                                                    class="custom-switch-input payment_status">
                                                <span class="custom-switch-indicator"></span>

                                                <div class="control__indicator"></div>
                                            </a>
                                            @endif
                                        </td>
                                        <td>
                                            <a title="Edit Subscription Sub Plan" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-subscription-sub-plan/'.$key->id) }}"
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