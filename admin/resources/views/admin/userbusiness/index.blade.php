@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View User Business' }} @endsection


<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View User Business</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View User Business</div>
                        {{-- <div class="ml-auto"><a href="{{ url('/admin/add-category') }}" title="Add Category"
                                data-toggle="tooltip" class="btn" style="background-color:#f5127b;color:white">Add</a>
                        </div>--}}
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Owner</th>
                                        <th class="wd-15p">Business Name</th>
                                        <th class="wd-15p">Category</th>
                                        <th class="wd-15p">Email</th>
                                        <th class="wd-15p">Address</th>
                                        <th class="wd-15p">Online Booking</th>
                                        <th class="wd-15p">Booking Response</th>
                                        <th class="wd-15p">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->User)?ucfirst($key->User->name):'N/A'}}</td>
                                        <td>{{($key->business_name)?$key->business_name:'N/A'}}</td>
                                        <td>{{($key->UserBusinessCategory->business_category_name)?$key->UserBusinessCategory->business_category_name:'N/A'}}
                                        </td>
                                        <td>{{($key->business_email)?$key->business_email:'N/A'}}</td>
                                        <td>{{($key->business_address)?$key->business_address:'N/A'}}</td>
                                        <td>@if($key->online_booking == 1) Yes @else NO @endif</td>
                                        <td>@if($key->online_booking == 1)
                                            @if($key->is_acceptance == 0) Automatic @else Manual @endif
                                            @else N/A @endif
                                        </td>

                                        <td style="display:flex">
                                            <a title="View Business Timing" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/business-timing/'.$key->id) }}"
                                                data-toggle="tooltip" style="margin-right:4px">View Time</a>
                                            <a title="View Business Services" class="btn btn-success btn-sm"
                                                href="{{ url('/admin/business-service/'.$key->id) }}"
                                                data-toggle="tooltip" style="margin-right:4px">View Services</a>
                                            <a title="View Business Bank" class="btn btn-orange btn-sm"
                                                href="{{ url('/admin/business-bank/'.$key->id) }}"
                                                data-toggle="tooltip">View Bank</a>
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