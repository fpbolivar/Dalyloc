@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Push Notifications Recorde</h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Push Notifications Recorde</div>
                        {{-- <div class="ml-auto"><a href="{{ url('/admin/create-notification') }}"
                                title="Create Push Notification" data-toggle="tooltip" class="btn bg-blue-custom">+Push
                                Notification</a>
                        </div> --}}
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">notification date</th>
                                        <th class="wd-15p">Title</th>
                                        <th class="wd-15p">description</th>
                                        <th class="wd-15p">notification source</th>
                                        <th class="wd-15p">fmc message</th>
                                        <th class="wd-15p">status</th>
                                        <th class="wd-15p">user id</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    @if(count($getRecorde)!=0)
                                    @foreach($getRecorde as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->notification_date)?$key->notification_date:'N/A'}}</td>
                                        <td>{{($key->notification_title)?ucfirst($key->notification_title):'N/A'}}</td>
                                        <td>{{
                                            $key->notification_description?ucfirst($key->notification_description):'N/A'}}
                                        </td>
                                        <td>{{ ($key->notification_source)?ucfirst($key->notification_source):'N/A'}}
                                        </td>
                                        <td>{{ ($key->message)?ucfirst($key->message):'N/A'}}</td>
                                        <td>{{ ($key->status)?ucfirst($key->status):'N/A'}}</td>
                                        <td>{{ ($key->User)?ucfirst($key->User->name):'N/A'}}</td>
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