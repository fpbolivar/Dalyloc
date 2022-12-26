<!doctype html>
<html lang="en">

    <head>
        <!-- Meta data -->
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="Daly Doc - Dashboard" name="description">
        <meta content="Daly Doc" name="author">
        <title>Daly Doc - Web Appointment</title>
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

        <!-- Bootstrap css -->
        <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            @media only screen and (min-width: 300px) and (max-width: 775px) {
                .column-right {
                    width: 100%;
                    position: unset !important;
                    padding-top: 50px;
                    right: 0px;
                    top: 0px;
                    background-color: #f8f8f8;
                }
            }

            .card {
                position: relative;
                display: -ms-flexbox;
                display: flex;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: transparent !important;
                background-clip: border-box;
                border: none !important;
            }

            .left-column {
                padding: 5%;

            }

            .right-column {
                background-color: #f8f8f8;
            }

            .top-space {
                padding: 30px 0 0 0;
                margin-bottom: 15px;
                margin-top: 15px;
            }

            td {
                padding: 0 15px 10px 0 !important;
            }

            .card:hover {
                box-shadow: none;
            }

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

            .column-right {
                width: 100%;
                position: fixed;
                height: 100%;
                padding-top: 50px;
                right: 0px;
                top: 0px;
                background-color: #f8f8f8;
            }

            .column-left {
                padding: 5%;
                background-color: #e6fbff75;

            }

            tr .space {
                padding-right: 75px !important;
            }

            .closeat {
                color: red;
            }
        </style>

    </head>

    <body>

        <div class="container-fluid ">
            <div class="d-flex" style="background-color: #e6fbff75">
                <a class="header-brand">
                    @if ($online_booking == 1 || $online_booking == true)
                    @elseif ($online_booking == 0 || $online_booking == false)
                    <div class="alert alert-danger" role="alert"><i class="fa fa-frown-o mr-2" aria-hidden="true"></i>
                        {{$msg}}
                    </div>
                    @endif
                </a>
            </div>
            <div class="row  ">
                <div class="col-md-6 col-sm-12 col-xs-12 form-group  column-left" class="col-4">
                    <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo" width="300">
                    <div class="d-flex top-space">
                        @include('admin.layouts.message')
                        <a class="header-brand">
                            <h1>Daly Doc</h1>
                        </a>
                    </div>
                    <div>
                        <table cellpadding="pixels" cellspacing="pixels">
                            @foreach ($getTime as $item)
                            <tr>
                                <td>{{$item->day}}</td>
                                <td class="{{$item->isClosed == 1? 'closeat':""}}">{{$item->isClosed == 0? date('h:i A',
                                    strtotime($item->open_time)) :"Close"}} </td>
                                <td> {{$item->isClosed == 0? date('h:i A', strtotime($item->close_time)):""}}</td>
                            </tr>
                            @endforeach
                        </table>

                    </div>
                    <div class="second-part">
                        <div class="top-space border-top">
                            <div class="d-flex">
                                <a class="header-brand">
                                    <h2>Our services</h2>
                                </a>
                            </div>
                        </div>
                        <table cellpadding="pixels" cellspacing="pixels">
                            @foreach ($getServices as $service)
                            <tr>
                                <td class="space"><b>{{$service->service_name ?$service->service_name:"N/A"}}</b>
                                    <br>
                                    <p> Duration: {{$service->service_time ?$service->service_time:"N/A"}}m</p>
                                </td>
                                <td> ${{$service->service_price?$service->service_price:"N/A"}} </td>
                            </tr>

                            @endforeach

                        </table>

                    </div>
                    <div class="third-part">
                        <div class="top-space border-top">
                            <div class="d-flex">
                                <a class="header-brand">
                                    <h2>Our Staff</h2>
                                </a>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="activity">
                                    <img src="{{asset('admin/assets/images/24.jpg')}}" alt="" class="img-activity">
                                    <div class="time-activity">
                                        <div class="item-activity">
                                            <p class="mb-0"><b>{{$getData->User->name}}</b></p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="d-flex align-items-center">
                                                    <p class="mb-0">{{$getData->User->email}}</p>
                                                </div>
                                                {{-- <small class="mb-0 ml-auto"><b>Daily: 2Hours</b></small> --}}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="book-btn">
                        @if ($online_booking == 1 || $online_booking == true)
                        <a href="{{url(env('WEB_URL').'/select/service',$getData->id)}}" target="_blank"
                            class=" btn bg-blue-custom">Book
                            an appointment</a>
                        @elseif ($online_booking == 0 || $online_booking == false)
                        <button class=" btn bg-blue-custom" disabled>Book
                            an appointment</button>

                        @endif
                    </div>
                </div>
                <div class="col-md-6 col-sm-12 col-xs-12 form-group column-right ">
                    <img src="{{asset('admin/assets/images/booking-image.png')}}" alt="logo">
                </div>
            </div>
        </div>


    </body>

</html>