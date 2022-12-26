<!doctype html>
<html lang="en">

    <head>
        <!-- Meta data -->
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="Daly Doc - Dashboard" name="description">
        <meta content="Daly Doc" name="author">
        <title>Daly Doc - Contact Detail </title>
        {{--
        <meta name="keywords"
            content="html rtl, html dir rtl, rtl website template, bootstrap 4 rtl template, rtl bootstrap template, admin panel template rtl, admin panel rtl, html5 rtl, academy training course css template, classes online training website templates, courses training html5 template design, education training rwd simple template, educational learning management jquery html, elearning bootstrap education template, professional training center bootstrap html, institute coaching mobile responsive template, marketplace html template premium, learning management system jquery html, clean online course teaching directory template, online learning course management system, online course website template css html, premium lms training web template, training course responsive website" />
        --}}

        <!-- Favicon -->
        <link rel="icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" />
        <!-- Dashboard Css -->
        <link href="{{asset('admin/assets/css/style.css')}}" rel="stylesheet" />

        <link href="{{asset('admin/assets/css/admin-custom.css')}}" rel="stylesheet" />



        <!-- Title -->
        <title>Daly Doc - Dashboard</title>
        <!-- Latest compiled and minified CSS -->

        <!-- Bootstrap css -->
        <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />

        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .bg {
                background-color: #e6fbff75;
            }

            @media only screen and (min-width: 300px) and (max-width: 775px) {
                .column-left {
                    display: none;
                }

                .container {
                    padding: 50px;
                }

                .column-right {
                    /* background-color: #f8f8f8; */
                    /* padding-left: 50px; */
                    border-left: 0px solid #dee2e6 !important;

                }
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
                border-left: 1px solid #dee2e6;

            }

            .center {
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            .top-space {
                padding: 30px 0 0 0;
                margin-bottom: 0px;
                margin-top: 15px;
            }

            td {
                padding: 10px 15px 5px 15px !important;
                border-radius: 10px;
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



            tr:hover {
                background-color: #fff;
                border: 1px solid #000000;
                /* border-radius: 10px; */
            }

            .trselected {
                background-color: #fff;
                border: 1px solid #000000;
            }

            input[type=number]::-webkit-inner-spin-button,
            input[type=number]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                margin: 0;
            }

            .modal-lg {
                max-width: 800px;
            }
        </style>

    </head>

    <body>

        <div class="container top-space  bg ">
            <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo" width="300" class="center">
            <div class="row top-space ">

                <div class="container ">
                    @include('admin.layouts.message')
                    <div class="row ">
                        <div class="col-md-4 col-sm-12 col-xs-12 form-group column-left">

                            {{-- <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo" width="300"> --}}

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
                            <div class="third-part">
                                <div class="d-flex">
                                    <a class="header-brand">
                                        <h5>Contact Detail</h5>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-sm-12 col-xs-12 form-group column-right  ">
                            {{-- <div class="top-space"> --}}
                                <div class="d-flex">
                                    <a class="header-brand">
                                        <h3 class="textcolor">Contact Detail</h3>
                                    </a>
                                </div>

                                <form method="post" id="contect-detail">
                                    @csrf
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label">Name *</label>
                                                <input type="text" class="form-control" placeholder="Enter Name"
                                                    name="booking_name">
                                                @error("booking_name")
                                                <span class="help-block text text-danger">{{$message}}</span>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label">Phone Number *</label>
                                                <input type="number" class="form-control" placeholder="Enter Phone"
                                                    name="booking_phone_no">
                                                @error("booking_phone_no")
                                                <span class="help-block text text-danger">{{$message}}</span>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label">Email *</label>
                                                <input type="text" class="form-control" placeholder="Enter Email"
                                                    name="booking_email">
                                                @error("booking_email")
                                                <span class="help-block text text-danger">{{$message}}</span>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label">Message *</label>
                                                <input type="text" class="form-control" placeholder="Enter Message"
                                                    name="booked_user_message">
                                                @error("booked_user_message")
                                                <span class="help-block text text-danger">{{$message}}</span>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>

                                    @if($amount!= 0)
                                    <p class="text-danger">
                                        To book an appointment, you must have to pay the deposit fee as
                                        per business guidelines.
                                    </p>
                                    <button type="button" class="btn bg-blue-custom" data-toggle="modal"
                                        data-target="#largeModal">
                                        "Book an appointment {{'($'.$amount.'.00 )'}}"
                                    </button>
                                    @else
                                    <input type="hidden" name="app_amount" value="{{$amount}}">
                                    <input type="submit" class="btn  bg-blue-custom"
                                        value="Book an appointment {{'($'.$amount.'.00 )'}}">
                                    @endif


                                    <!-- Large Modal -->
                                    <div id="largeModal" class="modal fade">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content ">
                                                <div class="modal-header pd-x-20">
                                                    <h6 class="modal-title">Payment</h6>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body pd-20">

                                                    <div class='form-row row'>
                                                        <div class='col form-group required'>
                                                            <label class='control-label'>Name on Card</label> <input
                                                                class='form-control' size='4' type='text'
                                                                name="card_name">
                                                            @error("card_name")
                                                            <span
                                                                class="help-block text text-danger">{{$message}}</span>
                                                            @enderror
                                                        </div>

                                                    </div>

                                                    <div class='form-row row'>
                                                        <div class='col form-group  required'>
                                                            <label class='control-label'>Card Number</label> <input
                                                                autocomplete='off' class='form-control card-number'
                                                                size='20' type='text' name="card_number">
                                                            @error("card_number")
                                                            <span
                                                                class="help-block text text-danger">{{$message}}</span>
                                                            @enderror
                                                        </div>

                                                    </div>

                                                    <div class='form-row row'>
                                                        <div class='col form-group cvc required'>
                                                            <label class='control-label'>CVC</label> <input
                                                                autocomplete='off' class='form-control card-cvc'
                                                                placeholder='ex. 311' size='4' type='text'
                                                                name="card_cvv">
                                                            @error("card_cvv")
                                                            <span
                                                                class="help-block text text-danger">{{$message}}</span>
                                                            @enderror
                                                        </div>
                                                        <div class='col form-group expiration required'>
                                                            <label class='control-label'>Month</label> <input
                                                                class='form-control card-expiry-month' placeholder='MM'
                                                                size='2' name="card_month" type='text'>
                                                            @error("card_month")
                                                            <span
                                                                class="help-block text text-danger">{{$message}}</span>
                                                            @enderror

                                                        </div>
                                                        <div class='col form-group expiration required'>
                                                            <label class='control-label'> Year</label> <input
                                                                class='form-control card-expiry-year' placeholder='YYYY'
                                                                size='4' type='text' name="card_year">
                                                            @error("card_year")
                                                            <span
                                                                class="help-block text text-danger">{{$message}}</span>
                                                            @enderror
                                                        </div>
                                                    </div>
                                                    @if(!empty($amount))
                                                    <div class="row">
                                                        <div class="col">
                                                            <input type="hidden" name="app_amount" value="{{$amount}}">
                                                            <input type="submit" class="btn  bg-blue-custom"
                                                                value="Pay Now {{'($'.$amount.'.00 )'}}">
                                                        </div>
                                                    </div>
                                                    @endif

                                                </div><!-- modal-body -->
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div><!-- modal-dialog -->
                                    </div><!-- modal -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->

    </body>

    <!-- JQuery js-->
    <script src="{{asset('admin/assets/js/jquery-3.2.1.min.js')}}"></script>
    <!-- Bootstrap js -->
    <script src="{{asset('admin/assets/plugins/bootstrap-4.3.1/js/popper.min.js')}}"></script>
    <script src="{{asset('admin/assets/plugins/bootstrap-4.3.1/js/bootstrap.min.js')}}"></script>

</html>
<script>
    $(document).ready(function(){

        console.log();
    //     var arr =[];
    //     $(':input[type="submit"]').prop('disabled', true);
    //     $('#table tr').click(function() {
    //         var trId = $(this).attr('id').split('_')[1];
    //         var tdName = $(this).children('#service').children('#service_name').text();
    //         var duration = $(this).children('#service').children('#duration').text().trim();
    //         $(this).toggleClass("trselected");
        
    //         if($.inArray(trId, arr) != -1) {
    //             arr = jQuery.grep(arr, function(value) {
    //             return value != trId;
    //             });
    //             $("#hidden-id").val(arr);
    //         }else {
    //             arr.push(trId);
    //             $("#hidden-id").val(arr);
    //         }

    //         if(arr.length == 0){
    //             $(':input[type="submit"]').prop('disabled', true);
    //         }else{
    //             $(':input[type="submit"]').prop('disabled', false);
    //         }
          
    //     })
       
    });

</script>