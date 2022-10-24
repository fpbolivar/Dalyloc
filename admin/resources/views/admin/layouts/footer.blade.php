			<div class="modal fade" id="exampleModal" tabdocumentation="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog" role="document">
	          <div class="modal-content">
	            <div class="modal-header">
	              <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                <span aria-hidden="true">×</span>
	              </button>
	            </div>
	            <div class="modal-body">
	              <p>Modal body text goes here.</p>
	            </div>
	            <div class="modal-footer">
	              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	              <button type="button" class="btn btn-primary">Save changes</button>
	            </div>
	          </div>
	        </div>
	      </div>

			</div>

			<!--Footer-->
			{{-- <footer class="footer">
				<div class="container">
					<div class="row align-items-center flex-row-reverse">
						<div class="col-lg-12 col-sm-12 mt-3 mt-lg-0 text-center">
							Copyright © 2019 <a href="#">Eudica</a>. Designed by <a href="#">Spruko</a> All rights reserved.
						</div>
					</div>
				</div>
			</footer> --}}
			<!--/Footer-->
		</div>

		<!-- Back to top -->
		<a href="#top" id="back-to-top" ><i class="fa fa-long-arrow-up"></i></a>

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

		<!-- Fullside-menu Js-->
		<script src="{{asset('admin/assets/plugins/sidemenu/sidemenu.js')}}"></script>

		<!--Select2 js -->
		<script src="{{asset('admin/assets/plugins/select2/select2.full.min.js')}}"></script>

		<!-- Timepicker js -->
		<script src="{{asset('admin/assets/plugins/time-picker/jquery.timepicker.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/time-picker/toggles.min.js')}}"></script>

		<!-- Datepicker js -->
		<script src="{{asset('admin/assets/plugins/date-picker/spectrum.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/date-picker/jquery-ui.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/input-mask/jquery.maskedinput.js')}}"></script>

		<!-- Inline js -->
		<script src="{{asset('admin/assets/js/select2.js')}}"></script>
		<script src="{{asset('admin/assets/js/formelements.js')}}"></script>

		<!-- file uploads js -->
        <script src="{{asset('admin/assets/plugins/fileuploads/js/fileupload.js')}}"></script>

        <script src="{{asset('admin/assets/plugins/fileuploads/js/dropify.js')}}"></script>

		<!--InputMask Js-->
		<script src="{{asset('admin/assets/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js')}}"></script>

		<!-- Custom scroll bar Js-->
		<script src="{{asset('admin/assets/plugins/scroll-bar/jquery.mCustomScrollbar.concat.min.js')}}"></script>

		<!--Counters -->
		<script src="{{asset('admin/assets/plugins/counters/counterup.min.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/counters/waypoints.min.js')}}"></script>

		<!-- CHARTJS CHART -->
		<script src="{{asset('admin/assets/plugins/chart/Chart.bundle.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/chart/utils.js')}}"></script>

		<!-- Index Scripts -->
		<script src="{{asset('admin/assets/plugins/echarts/echarts.js')}}"></script>
		<script src="{{asset('admin/assets/js/index4.js')}}"></script>


		<!-- Data tables -->
		<script src="{{asset('admin/assets/plugins/datatable/jquery.dataTables.min.js')}}"></script>
		<script src="{{asset('admin/assets/plugins/datatable/dataTables.bootstrap4.min.js')}}"></script>
		<script src="{{asset('admin/assets/js/datatable.js')}}"></script>

        <!-- WYSIWYG Editor js -->
		<script src="{{asset('admin/assets/plugins/wysiwyag/jquery.richtext.js')}}"></script>
		<script src="{{asset('admin/assets/js/formeditor.js')}}"></script>
		<!-- Custom Js-->
		<script src="{{asset('admin/assets/js/admin-custom.js')}}"></script>
		{{-- <script src="{{asset('cropping/cropzee.js')}}" defer></script> --}}
		<script src="{{asset('admin/croppie/croppie.js')}}" defer></script>
		<!--- validation js -->
		<script src="{{asset('admin/assets/validation/jquery.validate.min.js')}}" ></script>
		<script src="{{asset('admin/assets/validation/custom-validation.js')}}" ></script>
		<script src="{{asset('admin/assets/validation/selectize.js')}}" ></script>
		<link rel="stylesheet" type="text/css" href="{{asset('admin/assets/validation/selectize.css')}}" /> 

	{{-- other scripts --}}
	{{-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script> --}}
	{{-- <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script> --}}
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
	{{-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script> --}}
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.html5.min.js"></script>
	{{-- <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.print.min.js"></script> --}}


	

		
<!-- Modal -->
			<div class="modal fade" id="DeleteModal" tabdocumentation="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="DeleteModalLabel">Modal title</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body" >
							<p id="DeleteModalBody" >Modal body text goes here.</p>
						</div>
						<div class="modal-footer">
							<button type="button"  class="btn btn-secondary" data-dismiss="modal">No</button>
							<a href="" id="DeleteModalSubmit" class="btn btn-danger">Yes</a>
						</div>
					</div>
				</div>
			</div>

<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script type="text/javascript">
	$('input[name="dates"]').daterangepicker({ startDate: '01/01/2021', endDate: '{{date('m/d/Y')}}' });
</script>


<script type="text/javascript">
	$( "body" ).delegate( "#delete-data", "click", function(){
		var label = $(this).data('label');
		// console.log(label);
		var body = $(this).data('body');
		var url = $(this).data('url');
		$("#DeleteModalLabel").text(label)
		$("#DeleteModalBody").text(body)
		$("#DeleteModalSubmit").attr('href',url);
		$("#DeleteModal").modal('show');
	});
</script>
<script type="text/javascript">
	window.onload = function() {
		setTimeout(function() {
	    	$('.alert-dismissible').fadeOut('slow');
		}, 5000);
   }

   setTimeout(function() {
      $('.alert-dismissible').fadeOut('slow');
  }, 5000);

   // To make the workout dropdown list searchable
        $(function () {
  $(".select-show-search").select2();
});
        
</script>
@yield('js')
{{-- @yield('bar-graph-js') --}}

	</body>
</html>