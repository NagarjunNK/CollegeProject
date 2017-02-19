<script>
$("#alumni-form").on("submit", function(){
	var data = jQuery('#alumni-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/alumni.do?action=saveAlumni',
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
        <form id="alumni-form"  method="post">
          <div class="block clear first">
            <label for="name">Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="desc">Batch</label>
            <input type="text" name="batch" id="batch" value="" size="22">
          </div>
          <div class="block clear">
            <label for="place">Year of PassOut  <span>*</span></label>
            <input type="text" name="yearofpassout" id="yearofpassout" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="comment">Date of Birth <span>*</span></label>
            <input type="date" name="dob" id="dob" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="comment">Current Position <span>*</span></label>
            <input type="date" name="currentposition" id="currentposition" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="comment">Degree<span>*</span></label>
            <input type="date" name="degree" id="degree" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="comment">Mobile Number</label>
            <input type="date" name="mobile" id="mobile" value="" size="22">
          </div>
           <div class="block clear">
            <label for="comment">Email<span>*</span></label>
            <input type="date" name="email" id="email" value="" size="22">
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>