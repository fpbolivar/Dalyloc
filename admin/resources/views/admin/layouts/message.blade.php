@if (session('success'))
 <div class="row ">
	<div class="col-sm-12">
		<div class="alert alert-success alert-dismissible">
			{{-- <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			  <i class="material-icons">close</i>
			</button> --}}
			<span>{{ session('success') }}</span>
		</div>
	</div>
</div>
@endif
@if (session('error'))
 <div class="row">
	<div class="col-sm-12">
		<div class="alert alert-danger alert-dismissible">
			{{-- <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			  <i class="material-icons">close</i>
			</button> --}}
			<span>{{ session('error') }}</span>
		</div>
	</div>
</div>
@endif


{{--  <div class="row ajax-validation-message" style="display: none;">
	<div class="col-sm-12">
		<div class="alert alert-danger">
			<span class="message-error"></span>
		</div>
	</div>
</div> --}}