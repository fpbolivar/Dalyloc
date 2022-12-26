<!doctype html>
<html lang="en">

    <head>
        <!-- Meta data -->
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="Daly Doc - Dashboard" name="description">
        <meta content="Daly Doc" name="author">
        <title>Daly Doc - Select Services </title>
        {{--
        <meta name="keywords"
            content="html rtl, html dir rtl, rtl website template, bootstrap 4 rtl template, rtl bootstrap template, admin panel template rtl, admin panel rtl, html5 rtl, academy training course css template, classes online training website templates, courses training html5 template design, education training rwd simple template, educational learning management jquery html, elearning bootstrap education template, professional training center bootstrap html, institute coaching mobile responsive template, marketplace html template premium, learning management system jquery html, clean online course teaching directory template, online learning course management system, online course website template css html, premium lms training web template, training course responsive website" />
        --}}

        <!-- Favicon -->
        <link rel="icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" />
        <!-- Dashboard Css -->
        <link href="{{asset('admin/assets/css/style.css')}}" rel="stylesheet" />

        {{--
        <link href="{{asset('admin/assets/css/admin-custom.css')}}" rel="stylesheet" /> --}}
        <!-- Title -->
        <title>Daly Doc - Dashboard</title>
        <!-- Latest compiled and minified CSS -->

        <!-- Calendar Plugin -->
        <link href="{{asset('admin/assets/plugins/calendar/jquery.datetimepicker.css')}}" rel="stylesheet" />
        <!-- Bootstrap css -->
        <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />
        {{--
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> --}}

        <style>
            @media only screen and (min-width: 300px) and (max-width: 775px) {
                .column-left {
                    /* display: none; */
                }
            }

            .bg {
                background-color: #e6fbff75;
            }

            .left-column {
                padding: 5%;

            }

            .textcolor {
                color: #1f2e58;
            }

            .column-right {
                /* background-color: #f8f8f8; */
                padding-left: 50px;
            }

            .center {
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            .top-space {
                padding: 30px 0 0 0;
                margin-bottom: 15px;
                margin-top: 15px;
            }

            td {
                padding: 10px 15px 5px 15px !important;
                border-radius: 10px;
            }

            /* 
            .card:hover {
                box-shadow: none;
            } */

            .mt-20 {
                margin-top: 8% !important;
            }

            .book-btn {
                width: 100%;
                position: fixed;
                padding: 20px;
                left: 0px;
                bottom: 0px;
                box-shadow: rgba(136, 165, 191, 0.48) 6px 2px 16px 0px, rgba(255, 255, 255, 0.8) -6px -2px 16px 0px;
                background-color: #f4fdff;
            }

            table {
                border-collapse: separate;
                /* border-collapse: collapse; */
                border-spacing: 0 20px;
            }

            .closeat {
                color: red;
            }

            .container {
                padding: 50px;
            }

            tr:hover {
                background-color: #fff;
                border: 1px solid #000000;
                /* border-radius: 10px; */
            }

            .trselected {
                background-color: #fff;
                border: 1px solid #000000;
            }
        </style>

    </head>

    <body>

        <div class="container top-space  bg ">
            <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo" width="300" class="center">
            <div class="row ">
                <div class="container ">
                    <div class="row ">
                        <div class="col-md-4 col-sm-12 col-xs-12 form-group column-left">
                            <div class="d-flex">
                                <a class="header-brand">
                                    <h1>Daly Doc</h1>
                                </a>
                            </div>
                            <div class="second-part">
                                <div class="top-space border-top">
                                    <div class="d-flex">
                                        <a class="header-brand">
                                            <h5>Services</h5>

                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="third-part">
                                <div class="d-flex">
                                    <a class="header-brand">
                                        <h5>Date & Time</h5>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-sm-12 col-xs-12 form-group column-right border-left ">
                            {{-- <div class="top-space"> --}}
                                <div class="d-flex">
                                    <a class="header-brand">
                                        <h3 class="textcolor">Select Services</h3>
                                    </a>
                                </div>
                                <form method="post">
                                    @csrf
                                    <div class="selectservice">
                                        <table id="table" cellpadding="pixels" cellspacing="pixels">
                                            @foreach ($getServices as $service)
                                            <tr class="service-row" id="row_{{$service->id}}">
                                                <td class="space" id="service"><i class="fa fa-plus-square-o"></i>
                                                    <span id="service_name"><b>{{$service->service_name
                                                            ?$service->service_name:"N/A"}}</b></span>
                                                    <span id="service_price"><b> ${{$service->service_price
                                                            ?$service->service_price:"N/A"}}</b></span>
                                                    <br>
                                                    <span id="duration">
                                                        <p> Duration: {{$service->service_time
                                                            ?$service->service_time:"N/A"}}m
                                                        </p>
                                                    </span>

                                                </td>

                                            </tr>

                                            @endforeach
                                            <tr>
                                                <input type="hidden" name="service_id[]" value="" id="hidden-id">
                                            </tr>

                                        </table>
                                    </div>
                                    <input type="submit" name="submit" class="btn bg-blue-custom"
                                        value="Book an appointment  ">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <!-- JQuery js-->
    <script src="{{asset('admin/assets/js/jquery-3.2.1.min.js')}}"></script>
    <!-- calendar Js-->
    <script src="{{asset('admin/assets/js/calendar.js')}}"></script>
    <!-- Default calendar -->
    <script src="{{asset('admin/assets/plugins/calendar/jquery.datetimepicker.min.js')}}"></script>
    <script src="{{asset('admin/assets/plugins/rating/jquery.rating-stars.js')}}">
    </script>


</html>
<script>
    $(document).ready(function(){
        var arr =[];
        $(':input[type="submit"]').prop('disabled', true);
        $('#table tr').click(function() {
            var trId = $(this).attr('id').split('_')[1];
            var tdName = $(this).children('#service').children('#service_name').text();
            var duration = $(this).children('#service').children('#duration').text().trim();
            $(this).toggleClass("trselected");
        
            if($.inArray(trId, arr) != -1) {
                arr = jQuery.grep(arr, function(value) {
                return value != trId;
                });
                console.log('arr',arr);
                $("#hidden-id").val(arr);
            }else {
                console.log('arr5',arr);
                arr.push(trId);
                $("#hidden-id").val(arr);
            }

            if(arr.length == 0){
                $(':input[type="submit"]').prop('disabled', true);
            }else{
                $(':input[type="submit"]').prop('disabled', false);
            }
          
        })
       
    });

</script>