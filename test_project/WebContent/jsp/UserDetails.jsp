<%@ page import="java.util.*" %>
<script>
<%
ArrayList user = (ArrayList)request.getAttribute("user");
if(user != null && !user.isEmpty()){
	for(int i=0; i<user.size(); i++){
		   HashMap row = (HashMap)user.get(i);
		   int id = Integer.parseInt(row.get("id").toString());
		   String name = (String)row.get("name");
		   String role = (String)row.get("role");
%>
jQuery(document).ready(function(){
	jQuery('#id').text('<%=id%>');
	jQuery('#name').text('<%=name%>');
	jQuery('#role').text('<%=role%>');
	
});
<%}
}%>
</script>
<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Users</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="eventbreadcrum">Users</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="EventSection"> 
<div class="form-sec">
<h2>User Details</h2>
        <form id="event-form"  method="post">
        	<input type="hidden" name="id" id="id" value="">
        	<table>
        		<tr><td> <label for="name">User Name :</label></td><td><span id="name"></span></td></tr>
        		<tr><td><label for="desc">Role :</label></td><td><span id="role"></span></td></tr>
        	</table>
        </form>
</div>
</main>
</div>