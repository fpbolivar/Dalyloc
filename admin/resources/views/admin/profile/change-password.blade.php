@extends('admin.layouts.main')
@section('contents')
@section('title') {{'Change Password'}} @endsection
<style>
	.error {
		color: #f84242;
	}

	input.error {
		color: black
	}
</style>

<div class="app-content  my-3 my-md-5">
	<div class="side-app">
		<div class="page-header">
			<h6 class="page-title">Change Password</h6>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Pages</a></li>
				<li class="breadcrumb-item active" aria-current="page">Change Password</li>
			</ol>
		</div>
		<!--Page-Header-->
		<div class="row ">
			<div class="col-lg-12">
				<form id="validateChangePassword" class="card" method="post">
					@csrf
					<div class="card-header">
						<h3 class="card-title">Change Password</h3>
					</div>
					<div class="card-body">

						@include('admin.layouts.message')
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label class="form-label">Old Password*</label>
									<input type="password" id="maxfield" class="form-control"
										placeholder="Enter old password" name="old_password" minlength="6" required>
									@error("old_password")
									<span class="help-block  text text-danger">{{$message}}</span>
									@enderror
								</div>
							</div>
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label class="form-label">New Password*</label>
									<input id="password" type="password" class="form-control"
										placeholder="Enter new password" name="password" minlength="6" required>
									@error("password")
									<span class="help-block  text text-danger">{{$message}}</span>
									@enderror
									@error("passwordj")
									<span class="help-block  text text-danger">{{$message}}</span>
									@enderror
								</div>
							</div>
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label class="form-label">Confirm Password*</label>
									<input type="password" class="form-control" placeholder="Enter confirm password"
										name="password_confirmation" minlength="6" required>
									@error("password_confirmation")
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

@section('js')
<!-- <script type="text/javascript">
        $("#validateChangePassword").validate({
            errorClass: "text-danger",
            //validClass: "text-success",
            rules: {
                old_password: {
                    required : true
                },
                password: {
                    required: true,
                },
                password_confirmation: {
                    required: true,
                    equalTo: "#password",
                },
            },
            messages: {
                old_password: {
                    required: "The old password is required"
                },
                password: {
                    required: "The new password is required"
                },
                password_confirmation: {
                    required: "The confirm password field is required",
                    equalTo: "The confirm password must be equal to new password"
                },
                
            },
        });
  </script> -->
<script type="text/javascript">
	$("#validateChangePassword").validate();
</script>
@endsection