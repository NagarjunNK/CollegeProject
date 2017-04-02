	<%@ page import="java.util.*" %>

	<script>
	jQuery(document).ready(function() {	
	    jQuery('#thoughtsbreadcrum, #sharecancel').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=getallthoughts', {
			      success: function(data) {
			    	  $('#mainav li').each(function() {
			    		   $(this).removeAttr('class');
			    		});
			        jQuery('#contentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	 
	} );
	function postNewThoughts(){
		var thoughts = jQuery("#cmt").val();
		var url = '/AluminiMgnt/alumni.do?action=postThoughts&thoughts='+thoughts;
		jQuery.ajax(url, {
		      success: function(data) {
		    	  jQuery.ajax('/AluminiMgnt/alumni.do?action=getallthoughts', {
				      success: function(data) {
				    	  $('#mainav li').each(function() {
				    		   $(this).removeAttr('class');
				    		});
				        jQuery('#contentSection').html(data);
				      },
				      error: function() {
				    	  console.log("error");
				      }
				   });
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}


	</script>
	<div id="ThoughtsContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Alumni Thoughts</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="thoughtsbreadcrum">Alumni Thoughts</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="EventSection"> 
		<div class="scrollable">
		
		<div id="thought-form">
    			<textarea id="cmt" style="width:100%; min-height:150px;" ></textarea>
    			<br>
    			<a onclick="postNewThoughts();" class="btn">Post</a>&nbsp;<a id="sharecancel" class="btn">Cancel</a>
    		</div>
		  
	      </div>
	      </main>
	</div>
	</div>