<!doctype html>
<html lang="en">

    <head>
        <!-- Meta data -->
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="Daly Doc - Login" name="description">
        <meta content="Daly Doc" name="author">
        <meta name="keywords"
            content="html rtl, html dir rtl, rtl website template, bootstrap 4 rtl template, rtl bootstrap template, admin panel template rtl, admin panel rtl, html5 rtl, academy training course css template, classes online training website templates, courses training html5 template design, education training rwd simple template, educational learning management jquery html, elearning bootstrap education template, professional training center bootstrap html, institute coaching mobile responsive template, marketplace html template premium, learning management system jquery html, clean online course teaching directory template, online learning course management system, online course website template css html, premium lms training web template, training course responsive website" />

        <!-- Favicon -->
        <link rel="icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" />

        <!-- Title -->
        <title>Daly Doc - Login</title>

        <!-- Bootstrap css -->
        <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />

        <!-- Sidemenu Css -->
        <link href="{{asset('admin/assets/plugins/sidemenu/sidemenu.css')}}" rel="stylesheet" />

        <!-- Dashboard Css -->
        <link href="{{asset('admin/assets/css/style.css')}}" rel="stylesheet" />
        <link href="{{asset('admin/assets/css/admin-custom.css')}}" rel="stylesheet" />

        <!-- c3.js Charts Plugin -->
        <link href="{{asset('admin/assets/plugins/charts-c3/c3-chart.css')}}" rel="stylesheet" />

        <!-- Custom scroll bar css-->
        <link href="{{asset('admin/assets/plugins/scroll-bar/jquery.mCustomScrollbar.css')}}" rel="stylesheet" />

        <!---Font icons-->
        <link href="{{asset('admin/assets/css/icons.css')}}" rel="stylesheet" />

        <!-- Switcher css -->
        <link href="{{asset('admin/assets/switcher/css/switcher.css')}}" rel="stylesheet" id="switcher-css"
            type="text/css" media="all" />

        <!-- Color Skin css -->
        <link id="theme" rel="stylesheet" type="text/css" media="all"
            href="{{asset('admin/assets/color-skins/color6.css')}}" />

    </head>

    <body class="construction-image">

        <!--Loader-->
        <div id="global-loader">
            <img src="{{asset('admin/assets/images/loader.svg')}}" class="loader-img" alt="">
        </div>
        <!--Loader-->

        <!--Page-->
        <div class="page page-h">
            <div class="page-content z-documentation-10" style="z-index: 9 !important;">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-4 col-md-12 col-md-12 d-block mx-auto">
                            <div class="card mb-0">
                                <div class="custom-logo cust-center">
                                    <img src="{{asset('admin/assets/images/Framelogo.png')}}" alt="logo">
                                </div>
                                <div class="card-header">

                                    <h3 class="card-title">Login to your Account</h3>
                                </div>
                                <form id="commentForm" method="post">
                                    @csrf
                                    @include('admin.layouts.message')
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label class="form-label text-dark">Email address*</label>
                                            <input type="email" name="email" class="form-control"
                                                placeholder="Enter email">
                                            @error("email")
                                            <p class="help-block  text text-danger">{{$message}}</p>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label text-dark">Password*</label>
                                            <input type="password" name="password" class="form-control"
                                                id="exampleInputPassword1" placeholder="Password">
                                            <span toggle="#password-field"
                                                class="fe fe-eye field_icon toggle-password"></span>

                                            @error("password")
                                            <p class="help-block  text text-danger">{{$message}}</p>
                                            @enderror
                                        </div>
                                        {{-- <div class="form-group">
                                            <label class="custom-control custom-checkbox">
                                                <a href="forgot-password.html"
                                                    class="float-right small text-dark mt-1">I forgot password</a>
                                                <input type="checkbox" class="custom-control-input">
                                                <span class="custom-control-label text-dark">Remember me</span>
                                            </label>
                                        </div> --}}
                                        <div class="form-footer mt-2">
                                            <input type="submit" value="Sign In" class="btn btn-primary btn-block">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JQuery js-->
        <script src="{{asset('admin/assets/js/jquery-3.2.1.min.js')}}"></script>

        <!-- Bootstrap js -->
        <script src="{{asset('admin/assets/plugins/bootstrap-4.3.1/js/popper.min.js')}}"></script>
        <script src="{{asset('admin/assets/plugins/bootstrap-4.3.1/js/bootstrap.min.js')}}"></script>

        <!--JQuery Sparkline Js-->
        <script src="{{asset('admin/assets/js/jquery.sparkline.min.js')}}"></script>

        <!-- Circle Progress Js-->
        <script src="{{asset('admin/assets/js/circle-progress.min.js')}}"></script>

        <!-- Star Rating Js-->
        <script src="{{asset('admin/assets/plugins/rating/jquery.rating-stars.js')}}"></script>

        <!-- Custom scroll bar Js-->
        <script src="{{asset('admin/assets/plugins/scroll-bar/jquery.mCustomScrollbar.concat.min.js')}}"></script>

        <!-- Fullside-menu Js-->
        <script src="{{asset('admin/assets/plugins/sidemenu/sidemenu.js')}}"></script>

        <!--Counters -->
        <script src="{{asset('admin/assets/plugins/counters/counterup.min.js')}}"></script>
        <script src="{{asset('admin/assets/plugins/counters/waypoints.min.js')}}"></script>

        <!-- Custom Js-->
        <script src="{{asset('admin/assets/js/admin-custom.js')}}"></script>

    </body>

</html>
<script>
    $("body").on('click','.toggle-password',function(){
        $(this).toggleClass("fe fe-eye fe fe-eye-off");
    
        var input = $("#exampleInputPassword1");
        // var input = $("#pass_log_id");
       
        if (input.attr("type") === "password") {
           
            input.attr("type", "text");
            
        } else {
            input.attr("type", "password");
            console.log( 'pas');
        }
    });
   
</script>
<style>
    .custom-logo img {
        width: 50%;
        padding: 20px 0px 15px 0px;
    }

    .cust-center {
        text-align: center;
    }

    .card-header {
        justify-content: center;
    }

    .btn-primary {
        color: #fff;
        background-color: #000000;
        border-color: #000000;
    }

    .toggle-password {
        float: right;
        top: -25px;
        right: 10px;
        position: relative;
        cursor: pointer;
    }
</style>