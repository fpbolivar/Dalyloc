<!doctype html>
<html lang="en">

<head>
    <!-- Meta data -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="Daly Doc - Dashboard" name="description">
    <meta content="Daly Doc" name="author">
    <meta name="keywords"
        content="html rtl, html dir rtl, rtl website template, bootstrap 4 rtl template, rtl bootstrap template, admin panel template rtl, admin panel rtl, html5 rtl, academy training course css template, classes online training website templates, courses training html5 template design, education training rwd simple template, educational learning management jquery html, elearning bootstrap education template, professional training center bootstrap html, institute coaching mobile responsive template, marketplace html template premium, learning management system jquery html, clean online course teaching directory template, online learning course management system, online course website template css html, premium lms training web template, training course responsive website" />

    <!-- Favicon -->
    <link rel="icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="{{asset('admin/assets/images/brand/favicon.ico')}}" />

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins" rel="stylesheet">

    <!-- Title -->
    <title>Daly Doc - Dashboard</title>

    <!-- Bootstrap css -->
    <link href="{{asset('admin/assets/plugins/bootstrap-4.3.1/css/bootstrap.min.css')}}" rel="stylesheet" />

    <!-- Sidemenu Css -->
    <link href="{{asset('admin/assets/plugins/sidemenu/sidemenu.css')}}" rel="stylesheet" />

    <!-- Dashboard Css -->
    <link href="{{asset('admin/assets/css/style.css')}}" rel="stylesheet" />
    <link href="{{asset('admin/assets/css/admin-custom.css')}}" rel="stylesheet" />

    <!-- Date Picker Plugin -->
    <link href="{{asset('admin/assets/plugins/date-picker/spectrum.css')}}" rel="stylesheet" />

    <!-- c3.js Charts Plugin -->
    <link href="{{asset('admin/assets/plugins/charts-c3/c3-chart.css')}}" rel="stylesheet" />

    <!-- Custom scroll bar css-->
    <link href="{{asset('admin/assets/plugins/scroll-bar/jquery.mCustomScrollbar.css')}}" rel="stylesheet" />

    <!---Font icons-->
    <link href="{{asset('admin/assets/css/icons.css')}}" rel="stylesheet" />

    <!-- Switcher css -->
    <link href="{{asset('admin/assets/switcher/css/switcher.css')}}" rel="stylesheet" id="switcher-css" type="text/css"
        media="all" />

    <!-- Color Skin css -->
    <link id="theme" rel="stylesheet" type="text/css" media="all"
        href="{{asset('admin/assets/color-skins/color6.css')}}" />
    <!-- Data table css -->
    <link href="{{asset('admin/assets/plugins/datatable/dataTables.bootstrap4.min.css')}}" rel="stylesheet" />
    <link href="{{asset('admin/assets/plugins/datatable/jquery.dataTables.min.css')}}" rel="stylesheet" />

    <!-- file Uploads -->
    <link href="{{asset('admin/assets/plugins/fileuploads/css/fileupload.css')}}" rel="stylesheet" type="text/css" />

    <!-- WYSIWYG Editor css -->
    <link href="{{asset('admin/assets/plugins/wysiwyag/richtext.css')}}" rel="stylesheet" />

    <!-- select2 Plugin -->
    <link href="{{asset('admin/assets/plugins/select2/select2.min.css')}}" rel="stylesheet" />
    <link href="{{asset('admin/croppie/croppie.css')}}" rel="stylesheet" />


</head>

<style type="text/css">
.add-class-btn {
    position: absolute;
    right: 2%;
}

#audio_file-error {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
}

#photo-upload-error {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
}

.dt-buttons {
    position: absolute;
}

.dataTables_filter {
    text-align: right;
}

.richText .richText-editor,
.e-richtexteditor {
    font-family: "Poppins";
}
</style>

<body class="app sidebar-mini">

    <!--Loader-->
    <div id="global-loader">
        <img src="{{asset('admin/assets/images/loader.svg')}}" class="loader-img" alt="">
    </div>
    <!--Loader-->

    <!--Page-->
    <div class="page">
        <div class="page-main h-100">

            <!--App-Header-->
            <div class="app-header1 header py-1 d-flex">
                <div class="container-fluid">
                    <div class="d-flex">
                        <a class="header-brand">
                            {{--<img src="{{asset('/images/logo1.png')}}" class="header-brand-img" alt="Daly Doc
                            logo">--}}
                            <h1>Daly Doc</h1>
                        </a>
                        <a aria-label="Hide Sidebar" class="app-sidebar__toggle" data-toggle="sidebar" href="#"></a>
                        <div class="header-navicon">
                            <a href="#" data-toggle="search" class="nav-link d-lg-none navsearch-icon">
                                <i class="fa fa-search"></i>
                            </a>
                        </div>
                        {{-- <div class="header-navsearch">
								<a href="#" class=" "></a>
								<form class="form-inline mr-auto">
									<div class="nav-search">
										<input type="search" class="form-control header-search" placeholder="Search…" aria-label="Search" >
										<button class="btn btn-primary" type="submit"><i class="fa fa-search"></i></button>
									</div>
								</form>
							</div> --}}
                        <div class="d-flex order-lg-2 ml-auto">
                            {{-- <div class="dropdown d-none d-md-flex" >
									<a  class="nav-link icon full-screen-link">
										<i class="fe fe-maximize-2"  id="fullscreen-button"></i>
									</a>
								</div>
 --}}
                            <div class="dropdown ">
                                <a href="#" class="nav-link pr-0 leading-none user-img" data-toggle="dropdown">
                                    <img src="{{asset('admin/assets/images//25.png')}}" alt="profile-img"
                                        class="avatar avatar-md brround">
                                </a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow ">
                                    <a class="dropdown-item" href="{{ url('admin/update-profile') }}">
                                        <i class="dropdown-icon icon icon-user"></i> My Profile
                                    </a>
                                    {{-- <a class="dropdown-item" href="emailservices.html">
											<i class="dropdown-icon icon icon-speech"></i> Inbox
										</a> --}}
                                    <a class="dropdown-item" href="{{ url('admin/change-password') }}">
                                        <i class="dropdown-icon  icon icon-settings"></i> Change password
                                    </a>
                                    <a class="dropdown-item" href="{{ url('admin/logout') }}">
                                        <i class="dropdown-icon icon icon-power"></i> Log out
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/App-Header-->