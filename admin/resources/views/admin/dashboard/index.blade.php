@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Dashboard'}} @endsection
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
                    <a href="{{ url('admin/users') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-users w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Active Users</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getUser}}
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-orange text-center">
                    <a href="{{ url('admin/business-category') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-globe w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p> Business Categories</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getBusinessCat}}</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-pink text-center">
                    <a href="{{ url('admin/user-business') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-sun w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>User Business</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getUserBusines}}</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-blue-custom text-center">
                    <a href="{{ url('admin/workout-level') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-map w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Workout Levels</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getWorkoutLevel}}</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-orange text-center">
                    <a href="{{ url('admin/meal-categories') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-credit-card w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Meal Categories</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getMealCat}}</h1>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="item-all-card bg-pink text-center">
                    <a href="{{ url('admin/meal-categories') }}"></a>
                    <div class="iteam-all-icon">
                        <i class="fe fe-layers w-30"></i>
                    </div>
                    <div class="item-all-text mt-3">
                        <p>Prayer Categories</p>
                        <h1 class="mb-0 counter font-weight-bold">{{$getPrayerCat}}</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection