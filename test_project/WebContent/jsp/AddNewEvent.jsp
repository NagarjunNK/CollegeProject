<script>
$("#event-form").on("submit", function(){
	var data = jQuery('#event-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/alumni.do?action=saveEvent',
		  data:data,
	      success: function(data) {
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
	   return false;
	 });
</script>
<div class="form-sec">
<h2>Add New Event</h2>
        <form id="event-form"  method="post">
          <div class="block clear first">
            <label for="name">Title <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="desc">Description</label>
            <input type="text" name="desc" id="desc" value="" size="22">
          </div>
          <div class="block clear">
            <label for="place">Place  <span>*</span></label>
            <input type="text" name="place" id="place" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="comment">Date  <span>*</span></label>
            <input type="date" name="date" id="date" value="" size="22" required>
          </div>
          <div>
            <input type="submit" name="submit" value="Submit Form">
            &nbsp;
            <input type="reset" name="reset" value="Reset Form">
          </div>
        </form>
</div>