@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Edit Profile'}} @endsection

<div class="app-content  my-3 my-md-5">
	<div class="side-app">
		<div class="page-header">
			<h6 class="page-title">Edit Profile</h6>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Pages</a></li>
				<li class="breadcrumb-item active" aria-current="page">Edit Profile</li>
			</ol>
		</div>
		<!--Page-Header-->
		<div class="row ">
			<div class="col-lg-12">
				<form class="card" method="post">
					@csrf
					<div class="card-header">
						<h3 class="card-title">Edit Profile</h3>
					</div>
					<div class="card-body">

						@include('admin.layouts.message')
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-label">Name*</label>
									<input type="text" value="{{$admin->name}}" name="name" class="form-control"
										placeholder="Enter name">
									@error("name")
									<p class="help-block  text text-danger">{{$message}}</p>
									@enderror
								</div>
							</div>
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label class="form-label">Email*</label>
									<input type="email" value="{{$admin->email}}" name="email" class="form-control"
										placeholder="Enter email">
									@error("email")
									<p class="help-block  text text-danger">{{$message}}</p>
									@enderror
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer text-right">
						<button type="submit" class="btn btn-primary">Update Profile</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>
@endsection