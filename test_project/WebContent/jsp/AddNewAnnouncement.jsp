<%@ page import="java.util.*" %>
<script>
$("#announcement-form").on("submit", function(){
	var data = jQuery('#announcement-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/alumni.do?action=saveAnnouncement',
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
ArrayList announcement = (ArrayList)request.getAttribute("oneannouncement");
if(announcement != null && !announcement.isEmpty()){
	for(int i=0; i<announcement.size(); i++){
		   HashMap row = (HashMap)announcement.get(i);
		   int id = Integer.parseInt(row.get("id").toString());
		   String message = (String)row.get("message");
%>
jQuery(document).ready(function(){
	jQuery('#id').val('<%=id%>');
	jQuery('#message').val('<%=message%>');

});
<%}
}%>
</script>
<div class="form-sec">
<h2>Add New Announcement</h2>
        <form id="announcement-form"  method="post">
        	<input type="hidden" name="id" id="id" value="">
          <div class="block clear first">
            <label for="name">Announcement <span>*</span></label>
            <textarea rows="2" cols="10" id="message" name="message" required style="border-color: #c5c5c5;"></textarea>
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>