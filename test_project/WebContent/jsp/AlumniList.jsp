	<%@ page import="java.util.*" %>
	<link rel="stylesheet" href="layout/styles/jquery.dataTables.min.css">
	<style>
	.dataTables_length label{
	display:inline-flex;
	}
	.dataTables_filter label{
	display:inline-flex;
	}
	#alumniList tr:hover {
    background-color: #ccc;
    cursor:pointer;
	}
	</style>
	<script>
	jQuery(document).ready(function() {
		jQuery('#alumniList').DataTable({ "info": false});
	    jQuery('#AddNewAlumni').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=addNewAlumni', {
			      success: function(data) {
				jQuery('#AlumniListSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	    
	    jQuery('#alumnibreadcrum').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=getalumnilist', {
			      success: function(data) {
			    	  $('#mainav li').each(function() {
			    		   $(this).removeAttr('class');
			    		});
			    	jQuery('#alumni').addClass('active');
			        jQuery('#contentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});

	} );
	function editAlumni(ele){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/alumni.do?action=editAlumni'+'&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
			jQuery('#AlumniListSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	function deleteAlumni(ele){
		if(confirm("Are you sure?")){
			var id = jQuery(ele).attr('value');
			var url = '/AluminiMgnt/alumni.do?action=deleteAlumni'+'&id='+id;
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
	function getAlumniDetails(ele){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/alumni.do?action=getalumnidetail'+'&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
			jQuery('#AlumniContent').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	</script>
	<div id="AlumniContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Alumni</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="alumnibreadcrum">Alumni</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="AlumniListSection"> 
		 <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		<div style="width:100%;padding-bottom:60px;" ><h1>Alumni</h1><a style="float:right;" class="btn"  id="AddNewAlumni">Add Alumni</a></div>
		<%} %>
		<div class="scrollable">
		<table id="alumniList" >
		  <thead>
		    <tr>
		    <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		      <th></th>
		      <th></th>
		      <%} %>
		      <th>Name</th>
		      <th>Batch</th>
		      <th>Year of PassOut</th>
		      <th>Date of Birth</th>
		      <th>Degree</th>
		      <th>Current Position</th>
		      <th>Mobile Number</th>
		      <th>Email</th>		      
		    </tr>
		  </thead>
		  <tbody>
		  <%
				ArrayList alumnilist = (ArrayList)request.getAttribute("alumniList");
		   if(alumnilist != null && !alumnilist.isEmpty()){
			   for(int i=0; i<alumnilist.size(); i++){
				   HashMap row = (HashMap)alumnilist.get(i);
				   int id = (int)row.get("id");
				   String name = (String)row.get("name");
				   String batchyear = (String)row.get("batchyear");
				   String passoutyear = (String)row.get("passoutyear");
				   String dobStr = (String)row.get("dobStr");
				   String degree = (String)row.get("degree");
				   String currentposition = (String)row.get("currentposition");
				   String mobilenumber = (String)row.get("mobilenumber");
				   String email = (String)row.get("email");
				   
				   %>
				   
			<tr>
			<%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		       <td><a onClick="javascript:editAlumni(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;"></a></td>
		       <td><a onClick="javascript:deleteAlumni(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;"></a></td>
		       <%} %>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=name %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=batchyear %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=passoutyear %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=dobStr %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=degree %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=currentposition %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=mobilenumber %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>"><%=email %></td>

		    </tr>
				   
	  <%      	   }
		   }
				%>
		  </tbody>
		</table>
	      </div>
	      </main>
	</div>
	</div>