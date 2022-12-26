@extends('admin.layouts.main')
@section('contents')
@section('title') {{'User Prayer Response' }} @endsection

<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">User Prayer Response</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{env('BACK_URL').'user-prayer'}}"> <i
                            class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="">
                    @csrf
                    <div class="card-header">
                        <h3 class="card-title">User Prayer Response</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-12">
                                <div class="body">
                                    <label class="form-label" style="font-weight:bold">Title</label>
                                    <p style="font-size:16px">{{ucfirst($getPrayer->prayer_title)}}</p>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="body">
                                    <label class="form-label" style="font-weight:bold">Description</label>
                                    <p style="font-size:16px">{{ucfirst($getPrayer->prayer_note)}}</p>
                                </div>
                            </div>
                            <div class="col-md-12 mt-5">
                                <div class="body">
                                    <label class="form-label">Admin Response *</label>
                                    <textarea name="user_prayer_response" class="form-control" cols="30"
                                        rows="5"></textarea>

                                    @error("user_prayer_response")
                                    <span class="help-block  text text-danger">{{$message}}</span>
                                    @enderror
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>


        @if(count($allResponse) != 0)
        <h6 class="page-title" style="font-weight:600">User Prayer Response</h6>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table id="usersTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th class="wd-15p">#</th>
                                <th class="wd-15p">Response</th>

                            </tr>
                        </thead>
                        <tbody>
                            @foreach($allResponse as $key)
                            <tr>
                                <td>{{$loop->iteration}}</td>
                                <td>{{($key->user_prayer_response)?ucfirst($key->user_prayer_response):'N/A'}}</td>
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