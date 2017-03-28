<%@ page import="java.util.*" %>
<script>
$("#user-form").on("submit", function(){
	var data = jQuery('#user-form').serialize();
	 jQuery.ajax({
		  url:'/AluminiMgnt/user.do?action=saveUser',
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
ArrayList user = (ArrayList)request.getAttribute("user");
if(user != null && !user.isEmpty()){
	for(int i=0; i<user.size(); i++){
		   HashMap row = (HashMap)user.get(i);
		   int id = (int)row.get("id");
		   String name = (String)row.get("name");
		   String role = (String)row.get("role");
%>
jQuery(document).ready(function(){
	jQuery('#id').val('<%=id%>');
	jQuery('#name').val('<%=name%>');
	jQuery('#role').val('<%=role%>');

});
<%}
}%>
</script>
<div class="form-sec">
<h2>Add New Event</h2>
        <form id="user-form"  method="post">
        	<input type="hidden" name="id" id="id" value="">
          <div class="block clear first">
            <label for="name">User Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" required>
          </div>
          <div class="block clear">
            <label for="role">Role</label>
            <select name="role" id="role" class="w3-select w3-white">
            	<option value="admin">admin</option>
            	<option value="faculity">faculity</option>
            	<option value="alumni">alumni</option>
       			<option value="student">student</option>
            </select>
          </div>
          <div class="block clear">
            <label for="place">Password  <span>*</span></label>
            <input type="password" name="password" id="password" value="" size="22" required>
          </div>
          <div>
            <input type="submit" name="submit" value="Save">
            &nbsp;
            <input type="reset" name="reset" value="Reset">
          </div>
        </form>
</div>