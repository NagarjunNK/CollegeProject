<%@ page import="java.util.*" %>

<script>
jQuery(document).ready(function(){
	var minOffset = 0, maxOffset = 200;

	var thisYear = new Date().getFullYear();
	var select = jQuery("#batch, #yearofpassout");

	for (var i = minOffset; i <= maxOffset; i++) {
	    var year = thisYear - i;
	    $('<option>', {value: year, text: year}).appendTo(select);
	}
	
	jQuery("#alumni-form").validate();
	jQuery('input[name="name"]').rules('add',{ 
		required: true,
		messages:{mandatory:"Enter valid name."}
	});
	jQuery('input[name="email"]').rules('add',{ 
		required: true,
		email:true,
		messages:{email:"Enter valid email."}
	});
	jQuery('input[name="batch"]').rules('add',{ 
		digits: true,
		messages:{digits:"Enter valid year"}
	});
	jQuery('input[name="mobile"]').rules('add',{ 
		digits: true,
		messages:{email:"Enter valid mobile number"}
	});
});
jQuery("#alumni-form").on("submit", function(){
	if(jQuery("#alumni-form").valid()){
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
	}
	   return false;
	 });
<%
ArrayList alumni = (ArrayList)request.getAttribute("alumni");
if(alumni != null && !alumni.isEmpty()){
	for(int i=0; i<alumni.size(); i++){
		   HashMap row = (HashMap)alumni.get(i);
		   int id = Integer.parseInt(row.get("id").toString());
		   String name = (String)row.get("name");
		   String batchyear = (String)row.get("batchyear");
		   String passoutyear = (String)row.get("passoutyear");
		   String dobStr = (String)row.get("dobStr");
		   String degree = (String)row.get("degree");
		   String currentposition = (String)row.get("currentposition");
		   String mobilenumber = (String)row.get("mobilenumber");
		   String email = (String)row.get("email");
%>
jQuery(document).ready(function(){
	jQuery('#alumniid').val('<%=id%>');
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
<h2>Add New Alumni</h2>
        <form id="alumni-form"  method="post">
        	        	<input type="hidden" name="alumniid" id="alumniid" value="">
          <div class="block clear first">
            <label for="name">Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22"  maxlength="255" required style="border-color: #c5c5c5;">
          </div>
          <div class="block clear">
            <label for="batch">Batch</label>
            <select name="batch" id="batch" class="w3-select w3-white" style="border-color: #c5c5c5;">
            	<option value="">--select batch--</option>
            </select>
          </div>
          <div class="block clear">
            <label for="yearofpassout">Year of PassOut  <span>*</span></label>
            <select name="yearofpassout" id="yearofpassout" class="w3-select w3-white" style="border-color: #c5c5c5;" required>
            	<option value="">--select year of pass out--</option>
            </select>
          </div>
          <div class="block clear">
            <label for="dob">Date of Birth <span>*</span></label>
            <input type="date" name="dob" id="dob" value="" size="22" required>
          </div>
           <div class="block clear">
            <label for="currentposition">Current Position <span>*</span></label>
            <input type="text" name="currentposition" id="currentposition" value="" size="22" maxlength="255" required style="border-color: #c5c5c5;">
          </div>
           <div class="block clear">
            <label for="degree">Degree<span>*</span></label>
            <input type="text" name="degree" id="degree" value="" size="22" maxlength="255" required style="border-color: #c5c5c5;">
          </div>
           <div class="block clear">
            <label for="mobile">Mobile Number</label>
            <input type="text" name="mobile" id="mobile" value="" maxlength="10" size="22" style="border-color: #c5c5c5;">
          </div>
           <div class="block clear">
            <label for="email">Email<span>*</span></label>
            <input type="email" name="email" id="email" value="" size="22" style="border-color: #c5c5c5;">
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>