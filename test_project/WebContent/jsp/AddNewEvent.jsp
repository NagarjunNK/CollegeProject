<%@ page import="java.util.*" %>
<script>
jQuery(document).ready(function(){
	jQuery("#event-form").validate();
	jQuery('input[name="name"]').rules('add',{ 
		required: true,
		messages:{mandatory:"This field is required."}
	});
	jQuery('input[name="place"]').rules('add',{ 
		required: true,
		messages:{mandatory:"This field is required."}
	});
	jQuery('input[name="date"]').rules('add',{ 
		required: true,
		messages:{mandatory:"This field is required."}
	});
});
$("#event-form").on("submit", function(){
	if(jQuery("#event-form").valid()){
	var formdata = jQuery('#event-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/alumni.do?action=saveEvent',
		  data:formdata,
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
ArrayList event = (ArrayList)request.getAttribute("event");
if(event != null && !event.isEmpty()){
	for(int i=0; i<event.size(); i++){
		   HashMap row = (HashMap)event.get(i);
		   int id = (int)row.get("id");
		   String title = (String)row.get("title");
		   String desc = (String)row.get("description");
		   String place = (String)row.get("place");
		   String time = (String)row.get("time");
%>
jQuery(document).ready(function(){
	jQuery('#eventid').val('<%=id%>');
	jQuery('#name').val('<%=title%>');
	jQuery('#desc').val('<%=desc%>');
	jQuery('#place').val('<%=place%>');
	jQuery('#date').val('<%=time%>');
});
<%}
}%>
</script>
<div class="form-sec">
<h2>Add New Event</h2>
        <form id="event-form"  method="post">
        	<input type="hidden" name="eventid" id="eventid" value="">
          <div class="block clear first">
            <label for="name">Title <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" maxlength="255" required>
          </div>
          <div class="block clear">
            <label for="desc">Description</label>
            <input type="text" name="desc" id="desc" value="" size="22">
          </div>
          <div class="block clear">
            <label for="place">Place  <span>*</span></label>
            <input type="text" name="place" id="place" value="" size="22" maxlength="255" required>
          </div>
          <div class="block clear">
            <label for="comment">Date  <span>*</span></label>
            <input type="date" name="date" id="date" value="" size="22" required>
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>