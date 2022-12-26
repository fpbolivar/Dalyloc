<!doctype html>
<html lang="en">

    <head>
        <!-- Meta data -->
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="Daly Doc - Dashboard" name="description">
        <meta content="Daly Doc" name="author">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title>Daly Doc - Time Slote</title>
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



        <!-- Calendar Plugin -->
        {{--
        <link href="../assets/plugins/calendar/jquery.datetimepicker.css" rel="stylesheet" /> --}}
        <link href="{{asset('admin/assets/plugins/calendar/jquery.datetimepicker.css')}}" rel="stylesheet" />
        <!-- Title -->
        <title>Daly Doc - Dashboard</title>
        <!-- Latest compiled and minified CSS -->

        <!-- Bootstrap css -->
        <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            @media only screen and (min-width: 300px) and (max-width: 775px) {
                .column-left {
                    display: none;
                    padding-left: 10px;
                }

                .top-space {
                    /* padding: 0 0 0 0; */
                    margin-bottom: 15px;
                    margin-top: 15px;
                }

                .column-right {
                    /* background-color: #f8f8f8; */
                    padding-left: 10px !important;
                    /* margin-top: 10px */
                }

                /* .container {
                    padding: 50px;
                } */
            }

            .perfect-datetimepicker tbody td.selected {
                border: 1px solid #73a3ad;
                background-color: #73a3ad;
            }

            .perfect-datetimepicker table td.weekend {
                color: #ff382b;
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

            .textwhite {
                color: #fff;
            }

            .column-right {
                /* background-color: #f8f8f8; */
                padding-left: 50px;
                /* margin-top: 10px */
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
                /* border-radius: 10px; */
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

            table {
                border-collapse: separate;
                /* border-collapse: collapse; */
                border-spacing: 0 20px;
            }

            .closeat {
                color: red;
            }

            .trtimeselected {
                background-color: #fff;
                /* border: 1px solid #000000; */
                background-color: #73a3ad;
                color: white !important;
            }

            .trselected {
                background-color: #fff;
                border: 1px solid #000000;
            }

            .card-header {

                background-color: rgb(115 163 173);
            }
        </style>

    </head>

    <body>

        <div class="container   bg ">
            <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo" width="300" class="center">
            <div class="row top-space ">
                <div class="container ">
                    <div class="row  top-space">
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
                                            <h5>Services </h5>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="third-part">
                                <div class="d-flex">
                                    <a class="header-brand">
                                        <h5>Date & Time </h5>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-sm-12 col-xs-12 form-group column-right border-left ">
                            <div class="d-flex">
                                <a class="header-brand">
                                    <h3 class="textcolor">Select Date & Time </h3>
                                </a>
                            </div>
                            <div class="selectdate top-space">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h3 class="card-title textwhite"> Calendar</h3>
                                            </div>
                                            <div class="card-body">
                                                <div id="demo2">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <table id="first-tbl" cellpadding="pixels" cellspacing="pixels">
                                            <tr class="gettime">
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="d-flex">
                                            <a class="header-brand">
                                                <h3 class="textcolor">Available Slots </h3>
                                            </a>
                                        </div>
                                        <table id="second-tbl" cellpadding="pixels" cellspacing="pixels">
                                            <tr></tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <form action="" method="POST">
                                @csrf

                                <input type="hidden" name="app_date" value="" id="app-date">
                                <input type="hidden" name="app_time" value="" id="app-time">
                                <input type="submit" name="submit" class="btn bg-blue-custom"
                                    value="Book an appointment {{'($'.$amount.'.00 )'}}">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <!-- JQuery js-->
    <script src="{{asset('admin/assets/js/jquery-3.2.1.min.js')}}"></script>
    <!-- calendar Js-->
    {{-- <script src="{{asset('admin/assets/js/calendar.js')}}"></script> --}}
    <!-- Default calendar -->
    <script src="{{asset('admin/assets/plugins/calendar/jquery.datetimepicker.min.js')}}">
    </script>
    <script src="{{asset('admin/assets/plugins/rating/jquery.rating-stars.js')}}">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>


</html>
<script>
    $(document).ready(function(){
        function timeTo12HrFormat(time){
               // Take a time in 24 hour format and format it in 12 hour format
                    var time_part_array = time.split(":");
                    var ampm = 'AM';

                    if (time_part_array[0] >= 12) {
                        ampm = 'PM';
                    }

                    if (time_part_array[0] > 12) {
                        time_part_array[0] = time_part_array[0] - 12;
                    }

                    formatted_time = time_part_array[0] + ':' + time_part_array[1] + ':' + time_part_array[2] + ' ' + ampm;

                    return formatted_time;
            }
        $('#demo2').datetimepicker({
            date: new Date(),
            dateFormat: 'yy-mm-dd',
            viewMode: 'YMD',
            onDateChange: function(e){
                $('#date-text2').text(this.getText());
                $('#date-text-ymd2').text(this.getText('yyyy-MM-dd'));
                $('#date-value2').text(this.getValue());
                const format2 = "YYYY-MM-DD";
                var date = moment(this.getValue()).format(format2);
                $("#app-date").val(date);
                var id = {{$business_id}};
                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                });
                $.ajax({
                        type: "post",
                        url: "{{env('BOOKING_URL')}}gettime/slot",
                        data:{
                            date:date, 
                            business_id:id,
                        },
                        success: function(response) {
                            var value = response.businessTime;
                            if(value &&  value.isClosed == "0"  ){
                                let open_time =  timeTo12HrFormat(value.open_time);
                                let close_time =  timeTo12HrFormat(value.close_time);
                                
                                $('#first-tbl .gettime td:first-child').text(value.day);
                                $('#first-tbl .gettime td:nth-child(2)').removeClass("closeat").text(open_time);
                                $('#first-tbl .gettime td:nth-child(3)').text(close_time).css("display", "block");
                            }else{
                                $('#first-tbl .gettime td:first-child').text(value.day);
                                $('#first-tbl .gettime td:nth-child(2)').addClass('closeat').text("Close");
                                $('#first-tbl .gettime td:nth-child(3)').css("display", "none");
                            }
                            $.each(response.slots, function(key, value) {
                                console.log('value',value);
                                let start =  timeTo12HrFormat(value.start);
                                let hiddenTr = value.is_booked == 1 ?"booked":"";
                                $('#second-tbl').append('<tr class="gettime '+hiddenTr+' " id="'+key+'"><td >'+start+'</td></tr>');
                                $('#second-tbl  .booked').css("display", "none");
                                // $('#second-tbl tr:first').append('<td >'+start+'</td>');
                                
                                // $('#second-tbl tr:first').attr("id",key);
                              
                                // $('#second-tbl .gettime td:first-child').text(value.start);
                                // $('#second-tbl .gettime td:first-child(2)').text(value.start);
                                // $('#second-tbl .gettime td:nth-child(2)').removeClass("closeat").text(open_time);
                                    
                            });
                            getSlotTime();
                        }
                    }); 
            }
	    });
        function getSlotTime(){
            $(':input[type="submit"]').prop('disabled', true);
            $('#second-tbl tr').click(function() {
                var trId = $(this).attr('id');
                $(this).parent().children().index($(this));
                var time = $("#"+trId).children('td').text();
                $("#app-time").val(time);
                $(this).siblings().removeClass('trtimeselected');
                $(this).toggleClass("trtimeselected");
                $(':input[type="submit"]').prop('disabled', false);
                
            })
        }
    });

</script>