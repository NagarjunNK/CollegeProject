<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<script type='text/javascript' src='layout/unitegallery/js/jquery-11.0.min.js'></script>	
<script type='text/javascript' src='layout/unitegallery/js/unitegallery.min.js'></script>	
<link rel='stylesheet' href='layout/unitegallery/css/unite-gallery.css' type='text/css' />
<script type='text/javascript' src='layout/unitegallery/themes/tilesgrid/ug-theme-tilesgrid.js'></script>
	
<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Gallery</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="gallerybreadcrum">Gallery</a></li>
	    </ul>
	  </section>
	</div>
	<div id="upload" class="w3-modal">
						<div class="w3-modal-content w3-card-8 w3-animate-zoom"	style="max-width: 600px">
							<div class="w3-center">
								<br> <span	class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright"	onclick="resetUpload()" title="Close Modal">&times;</span>
								<h3>Upload</h3>
							</div>
							<div id="upload2">
								<form method="post" class="w3-container" id="uploadForm" enctype="multipart/form-data">
									<div class="w3-section">
									<div id="id021">
										<label><b>Select file to upload:</b></label> <input type="file" name="file" size="60" required/>
										<br/> 
										<div class="w3-center">
										<button class="w3-btn w3-orange w3-text-white"	type="submit" onclick="uploadImage(this)" >Upload</button>
										<button	onclick="resetUpload()"	type="button" class="w3-btn w3-grey w3-text-white">Cancel</button>
										</div>
									</div>
									</div>
								</form>
							</div>
						</div>
					</div>  
<div class="wrapper row3">
	  <main class="hoc container clear" id="gallerySection"> 
		<div style="width:100%;padding-bottom:60px;" ><h1>Gallery</h1>
		
		<div style="float:right;"><a class="btn" onclick="document.getElementById('upload').style.display='block'">Upload Image</a></div>
</div>
		
		<div class="scrollable">
<div id="gallery" style="display:none;">
 
 <%
 String imageUrl = request.getServletContext().getRealPath("")+File.separator+"images"+File.separator+"gallery";
 File imageDir = new File(imageUrl);
 if(imageDir.listFiles().length > 0){
 for(File imageFile : imageDir.listFiles()){
   String imageFileName = imageFile.getName();
 %>
 <img alt="Alumni"
		     src="images/gallery/<%= imageFileName%>"
		     data-image="images/gallery/<%= imageFileName%>"
		     style="display:none">
 
  <% 
 }}else{
 %>
 <h3 style="text-align:center;">No images found in gallery</h3>
 <%} %>
</div>
</div>
</main>
</div>

<script type="text/javascript">

		jQuery(document).ready(function(){

			jQuery("#gallery").unitegallery({
				theme_navigation_type:"arrows"
			});
			
			jQuery('#gallerybreadcrum').on("click",function(){
				 jQuery.ajax('/AluminiMgnt/gallery.do', {
				      success: function(data) {
				    	  $('#mainav li').each(function() {
				    		   $(this).removeAttr('class');
				    		});
				    	jQuery('#galleries').addClass('active');
				        jQuery('#contentSection').html(data);
				      },
				      error: function() {
				    	  console.log("error");
				      }
				   });
			});

		});
		
		function resetUpload(){
			$("input[name='file']").val('');
			document.getElementById('upload').style.display='none'
			
		}

		function uploadImage(ex) {
			var file = jQuery("input[name='file']").val();
			if(file !== ''){
				var formData = new FormData();
				formData.append('file', $("input[name='file']")[0].files[0]);

						$.ajax({
							url : "/AluminiMgnt/UploadServlet",
							data : formData,
							type : "POST",
							processData: false,
						    	contentType: false,
							success : function(data) {
								if (data == "success") {
									document.getElementById('upload').style.display = 'none';
									jQuery("#galleries").click();
								} else {
									document.getElementById('alert').style.display = 'block';
								}
							}
						});
			}
			
		}
	</script>