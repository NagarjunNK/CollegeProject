<%@ page import="java.util.*" %>
	<link rel="stylesheet" href="layout/styles/jquery.dataTables.min.css">
	<style>
	.dataTables_length label{
	display:inline-flex;
	}
	.dataTables_filter label{
	display:inline-flex;
	}
	#events tr:hover {
    background-color: #ccc;
    cursor:pointer;
	}
	</style>
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery('#AddNewUser').on("click",function(){
		 jQuery.ajax('/AluminiMgnt/user.do?action=addNewUser', {
		      success: function(data) {
			jQuery('#userSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	});
 
} );

function editUser(ele){
	var id = jQuery(ele).attr('value');
	var url = '/AluminiMgnt/user.do?action=editUser'+'&id='+id;
	jQuery.ajax(url, {
	      success: function(data) {
		jQuery('#userSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function deleteUser(ele){
	if(confirm("Are you sure?")){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/user.do?action=deleteUser'+'&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
				  jQuery('#contentSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	return false;
}
function getUserDetails(ele){
	var id = jQuery(ele).attr('value');
	var url = '/AluminiMgnt/user.do?action=getuserdetail'+'&id='+id;
	jQuery.ajax(url, {
	      success: function(data) {
		jQuery('#userContent').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
</script>
<div id="userContent">
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
	  <main class="hoc container clear" id="userSection"> 
	  
	   <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		<div style="width:100%;padding-bottom:60px;" ><h1>Users</h1><a style="float:right;" class="btn" id="AddNewUser">Add New User</a></div>
		<%} %>
		<div class="scrollable">
		<table id="users" >
		  <thead>
		    <tr>
		    <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		      <th width='5%'></th>
		      <th width='5%'></th>
		      <%} %>
		      <th width='40%'>User</th>
		      <th width='40%'>Role</th>
		    </tr>
		  </thead>
		  <tbody>
		  <%
				ArrayList users = (ArrayList)request.getAttribute("users");
		   if(users != null && !users.isEmpty()){
			   for(int i=0; i<users.size(); i++){
				   HashMap row = (HashMap)users.get(i);
				   int id = Integer.parseInt(row.get("id").toString());
				   String name = (String)row.get("name");
				   String role = (String)row.get("role");
		 %>
				   
			<tr>
			<%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		       <td><a onClick="javascript:editUser(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;" ></a></td>
		       <td><a onClick="javascript:deleteUser(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;" ></a></td>
		       <%} %>
		      <td onclick="javascript:getUserDetails(this);" value="<%=id %>"><%=name %></td>
		      <td onclick="javascript:getUserDetails(this);" value="<%=id %>"><%=role %></td>
		    </tr>
				   
	  <%      	   }
		   }
				%>
		  </tbody>
		</table>
	      </div>
	   </main>
</div>
