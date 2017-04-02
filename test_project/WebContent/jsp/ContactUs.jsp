<<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery("#contact-form").validate();
	jQuery('input[name="email"]').rules('add',{ 
		required: true,
		email:true,
		messages:{mandatory:"Enter valid email."}
	});
});
$("#contact-form").on("submit", function(){
	if(jQuery("#contact-form").valid()){
	var data = jQuery('#contact-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/alumni.do?action=saveContactUs',
		  data:data,
	      success: function(data) {
	    	  if(data === 'true'){
		    	  jQuery('#success').show();
		    	  jQuery('#success').delay(3000).fadeOut('slow');
	    	  }else{
	    		  jQuery('#fail').show();
		    	  jQuery('#fail').delay(3000).fadeOut('slow');
	    	  }
		  },
	      error: function() {
	    	  jQuery('#fail').show();
	    	  jQuery('#fail').delay(5000).fadeOut('slow');
	      }
	   });
	}
	   return false;
	 });
</script>

<div id="contactUsContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Contact Us</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="eventbreadcrum">Contact Us</a></li>
	    </ul>
	  </section>
	</div>
<div class="wrapper row3">
	  <main class="hoc container clear" id="contactSection"> 
	  <div class="w3-panel w3-green" style="display:none;" id="success">
		  <p>Your comment added successfully.</p>
	</div>
	 <div class="w3-panel w3-red" style="display:none;" id="fail">
		  <p>Problem while sending your comment.</p>
	</div> 
	
	  <form id="contact-form" action="#" method="post" class="form-sec">
          <div class="one_third first">
            <label for="name">Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" maxlength="255" required="">
          </div>
          <div class="one_third">
            <label for="email">Mail <span>*</span></label>
            <input type="email" name="email" id="email" value="" size="22" required="">
          </div>
          <div class="block clear">
            <label for="comment">Your Comment</label>
            <textarea name="msg" id="msg" cols="25" rows="10"></textarea>
          </div>
          <div>
            <input type="submit" name="submit" value="Send">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
	  
	   </main>
</div>
