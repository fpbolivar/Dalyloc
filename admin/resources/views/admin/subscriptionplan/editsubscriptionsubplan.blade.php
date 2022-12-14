@extends('admin.layouts.main')
@section('contents')

<div class="app-content  my-3 my-md-5">
    {{--@php echo $category->name; exit;@endphp --}}
    <div class="side-app">
        <div class="page-header">
            <h6 class="page-title">Edit Subscription Sub Plan</h6>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a
                        href="{{env('BACK_URL').'subscription-types/'.$subscriptionSubPlan->id}}"> <i
                            class="fa fa-arrow-left "></i>
                        Go
                        Back</a></li>
            </ol>
        </div>
        <!--Page-Header-->
        <div class="row ">
            <div class="col-lg-12">
                <form class="card" method="post" action="" enctype="multipart/form-data">
                    @csrf
                    <div class="card-header">
                        <!-- <h5><a href="{{env('BACK_URL').'category'}}"> <i class="fa fa-arrow-left "></i> Go Back</a> -->
                        <h3 class="card-title">Edit Subscription Sub Plan</h3>
                    </div>
                    <div class="card-body">
                        @include('admin.layouts.message')
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="form-label">Subscription Plan</label>

                                        <input type="text" class="form-control"
                                            placeholder="Enter subscription sub plan name" name="name"
                                            value="{{$subscriptionSubPlan->Plan->name}}" readonly>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12">

                                    <div class="form-group">
                                        <label class="form-label"> Sub Plan Name</label>
                                        <input type="text" class="form-control"
                                            placeholder="Enter subscription sub plan name" name="name"
                                            value="{{$subscriptionSubPlan->name}}">
                                        @error("name")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-12">

                                    <div class="form-group">
                                        <label class="form-label">Amount</label>
                                        <input type="text" class="form-control"
                                            placeholder="Enter subscription sub plan name" name="amount"
                                            value="{{$subscriptionSubPlan->amount}}">
                                        @error("amount")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="form-label">Price Id</label>
                                        <input type="text" class="form-control"
                                            placeholder="Enter subscription sub plan name" name="subscription_price_id"
                                            value="{{$subscriptionSubPlan->subscription_price_id}}">
                                        @error("subscription_price_id")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-12">

                                    <div class="form-group">
                                        <label class="form-label">Type</label>
                                        <select class="form-control select2" name="type"
                                            data-placeholder="Choose Type Plan">
                                            <option disabled="disabled" selected>Choose Plan Type</option>
                                            @if($subscriptionSubPlan->subscription_plan_id == 4)
                                            <option value="monthly"
                                                {{ ($subscriptionSubPlan->type) == 'monthly' ? 'selected' : '' }}>
                                                Monthly
                                            </option>
                                            <option value="annual"
                                                {{ ($subscriptionSubPlan->type) == 'annual' ? 'selected' : '' }}>Annual
                                            </option>
                                            @else
                                            <option value="free"
                                                {{ ($subscriptionSubPlan->type) == 'free' ? 'selected' : '' }}>Free
                                            </option>
                                            <option value="monthly"
                                                {{ ($subscriptionSubPlan->type) == 'monthly' ? 'selected' : '' }}>
                                                Monthly
                                            </option>
                                            <option value="annual"
                                                {{ ($subscriptionSubPlan->type) == 'annual' ? 'selected' : '' }}>Annual
                                            </option>
                                            @endif
                                        </select>
                                        @error("type")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="form-label">Price Id</label>
                                        <input type="text" class="form-control"
                                            placeholder="Enter subscription sub plan name" name="subscription_price_id"
                                            value="{{$subscriptionSubPlan->subscription_price_id}}">
                                        @error("subscription_price_id")
                                        <span class="help-block  text text-danger">{{$message}}</span>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Discription</label>
                                    <textarea type="text" class="form-control content" name="description" row="4"
                                        cols="6">{!!$subscriptionSubPlan->description !!}</textarea>
                                    @error("description")
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
    </div>
</div>
@endsection