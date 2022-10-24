@extends('admin.layouts.main')
@section('contents')
<!--App-Content-->
<div class="app-content  my-3 my-md-5">
    <div class="side-app">
        <!--Page-Header-->
        <div class="page-header">
            <h6 class="page-title">Dashboard</h6>
        </div>
        <!--/Page-Header-->
        <div class="row item-all-cat">
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-blue-custom text-center">
                    <a href="#"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-user w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Current Users</p>
                        <h1 class="mb-0 counter font-weight-bold">10</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-orange text-center">
                    <a href="#"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-thumbs-up w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Categories</p>
                        <h1 class="mb-0 counter font-weight-bold">10</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-blue-custom text-center">
                    <a href="#"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-user w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Products</p>
                        <h1 class="mb-0 counter font-weight-bold">10</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-pink text-center">
                    <a href="#"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-volume-1 w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Designs</p>
                        <h1 class="mb-0 counter font-weight-bold">10</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-orange text-center">
                    <a href="#"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-credit-card w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Total Orders</p>
                        <h1 class="mb-0 counter font-weight-bold">10</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection