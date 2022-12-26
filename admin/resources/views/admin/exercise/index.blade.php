@extends('admin.layouts.main')
@section('contents')
@section('title') {{'View Exercise'}} @endsection


<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">View Exercise </h6>
        </div>
        @include('admin.layouts.message')
        <!--Page-Header-->
        <div class="row ">
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">View Exercise </div>
                        <div class="ml-auto"><a href="{{ url('/admin/add-exercise') }}" title="Add Exercise"
                                data-toggle="tooltip" class="btn bg-blue-custom">Add</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="wd-15p">#</th>
                                        <th class="wd-15p">Exercise Name</th>
                                        <th class="wd-15p">Exercise Time</th>
                                        <th class="wd-15p">Exercise Image</th>
                                        <th class="wd-15p">Exercise Video</th>
                                        <!-- <th class="wd-15p">Action</th> -->
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($getData as $key)
                                    <tr>
                                        <td>{{$loop->iteration}}</td>
                                        <td>{{($key->exercise_name)?$key->exercise_name:'N/A'}}</td>
                                        <td>{{($key->exercise_time)?$key->exercise_time:'N/A'}}</td>
                                        <td><a href="#myModal" data-toggle="modal" data-gallery="example-gallery"
                                                class="col-sm-3 image" data-img-url="{{asset($key->exercise_image)}}">
                                                <img src="{{($key->exercise_image)?asset($key->exercise_image):asset('/images/business/download.png')}}"
                                                    class="img-fluid image-control" width="100" height="100">
                                            </a></td>
                                        <td>
                                            @if($key->exercise_video)
                                            <a data-link="{{ asset($key->exercise_video) }}"
                                                data-name="{{ $key->exercise_video }}"
                                                class="view-video btn bg-blue-custom btn-sm"
                                                onclick="getId('{{ $key->id }}', '{{ asset($key->exercise_video) }}') ">
                                                Video
                                            </a>
                                            @else
                                            No Video
                                            @endif
                                        </td>
                                        <!-- <td>
                                            <a title="Edit Allergies" class="btn bg-blue-custom btn-sm"
                                                href="{{ url('/admin/edit-allergies',$key->id) }}"
                                            data-toggle="tooltip">Edit</a>

                                            @if($key->is_deleted == '0')
                                            <a title="Block Allergies" class="btn btn-danger-custom btn-sm"
                                                href="{{ url('/admin/destroy-allergies/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to block this Allergies ?');"
                                                data-toggle="tooltip">Block</a>
                                            @else
                                            <a title="Restore Allergies" class="btn btn-success-custom btn-sm"
                                                href="{{ url('/admin/destroy-business-category/'.$key->id) }}"
                                                onclick="return confirm('Are you sure you want to restore this Allergies ?');"
                                                data-toggle="tooltip">Restore</a>
                                            @endif
                                        </td> -->
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
<!-- Button trigger modal -->


<!-- Modal -->
<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body text-center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <img class="" src="#" />
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="webinarModal" tabindex="-1" role="dialog" aria-labelledby="webinarModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <!-- 16:9 aspect ratio -->
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" src="" id="playvideo" allowscriptaccess="always"
                        allow="autoplay"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>

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
    function getId(id, link) {
        $("#playvideo").attr('src', link);
        $('#webinarModal').modal();
        $("#webinarModal").on('hidden.bs.modal', function (e) {
            $("#webinarModal #playvideo").attr("src", $("#webinarModal #playvideo").attr('src', link));
        });
    }

    $('.image').click(function (e) {
        $('#myModal img').attr('src', $(this).attr('data-img-url'));
    });
</script>


@endsection