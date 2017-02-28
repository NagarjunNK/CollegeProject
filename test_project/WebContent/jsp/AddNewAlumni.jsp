<%@ page import="java.util.*" %>

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
<%
ArrayList alumni = (ArrayList)request.getAttribute("alumni");
if(alumni != null && !alumni.isEmpty()){
	for(int i=0; i<alumni.size(); i++){
		   HashMap row = (HashMap)alumni.get(i);
		   int id = (int)row.get("id");
		   String name = (String)row.get("name");
		   String batchyear = (String)row.get("batchyear");
		   String passoutyear = (String)row.get("passoutyear");
		   String dobStr = (String)row.get("dobStr");
		   String degree = (String)row.get("degree");
		   String currentposition = (String)row.get("currentposition");
		   long mobilenumber = (long)row.get("mobilenumber");
		   String email = (String)row.get("email");
%>
jQuery(document).ready(function(){
	jQuery('#name').val('<%=name%>');
	jQuery('#batch').val('<%=batchyear%>');
	jQuery('#yearofpassout').val('<%=passoutyear%>');
	jQuery('#dob').val('<%=dobStr%>');
	jQuery('#currentposition').val('<%=currentposition%>');
	jQuery('#degree').val('<%=degree%>');
	jQuery('#mobile').val('<%=mobilenumber%>');
	jQuery('#email').val('<%=email%>');

});
<%}
}%>
</script>
<div class="form-sec">
<h2>Add New Event</h2>
        <form id="alumni-form"  method="post">
        	        	<input type="hidden" name="alumniid" id="alumniid" value="">
          <div class="block clear first">
            <label for="name">Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="batch">Batch</label>
            <input type="text" name="batch" id="batch" value="" size="22">
          </div>
          <div class="block clear">
            <label for="yearofpassout">Year of PassOut  <span>*</span></label>
            <input type="text" name="yearofpassout" id="yearofpassout" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="dob">Date of Birth <span>*</span></label>
            <input type="date" name="dob" id="dob" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="currentposition">Current Position <span>*</span></label>
            <input type="text" name="currentposition" id="currentposition" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="degree">Degree<span>*</span></label>
            <input type="text" name="degree" id="degree" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="mobile">Mobile Number</label>
            <input type="text" name="mobile" id="mobile" value="" size="22">
          </div>
           <div class="block clear">
            <label for="email">Email<span>*</span></label>
            <input type="text" name="email" id="email" value="" size="22">
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>