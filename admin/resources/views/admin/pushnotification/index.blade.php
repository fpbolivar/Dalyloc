@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Push Notification'}} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Push Notifications</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Push Notifications</div>
                        <div class="ml-auto"><a href="{{ url('/admin/create-notification') }}"
                                title="Create Push Notification" data-toggle="tooltip" class="btn bg-blue-custom">+Push
                                Notification</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Send To</th>
                                        <th class="wd-15p">Title</th>
                                        <th class="wd-15p">Message</th>
                                        <th class="wd-15p">Schedule</th>
                                        <th class="wd-15p">date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if(count($getNotification)!=0)
                                    @foreach($getNotification as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->user_id == 'all')?'All': ucfirst($key->User->name) ?? "N/A"}}</td>
                                        <td>{{($key->title)?ucfirst($key->title):'N/A'}}</td>
                                        <td>{{ $key->message?ucfirst($key->message):'N/A'}}</td>
                                        <td>{{ ($key->schedule_date_time)?ucfirst('Scheduled'):'Not Scheduled'}}</td>
                                        <td>{{date('Y-m-d',strtotime($key->created_at))}}</td>
                                    </tr>
                                    @endforeach
                                    @endif
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