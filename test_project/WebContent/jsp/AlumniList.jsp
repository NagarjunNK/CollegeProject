	<%@ page import="java.util.*" %>
	<link rel="stylesheet" href="layout/styles/jquery.dataTables.min.css">
	<style>
	.dataTables_length label{
	display:inline-flex;
	}
	.dataTables_filter label{
	display:inline-flex;
	}
	</style>
	<script>
	$(document).ready(function() {
	    $('#alumniList').DataTable({ "info":     false});
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

	} );
	</script>
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Alumni</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a href="#">Alumni</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="AlumniListSection"> 
		<div style="width:100%;padding-bottom:60px;" id="AddNewAlumni"><h1>Alumni</h1><a style="float:right;" class="btn" href="#">Add Alumni</a></div>
		<div class="scrollable">
		<table id="alumniList" >
		  <thead>
		    <tr>
		      <th></th>
		      <th></th>
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
				   String name = (String)row.get("name");
				   long batchyear = (long)row.get("batchyear");
				   long passoutyear = (long)row.get("passoutyear");
				   String dobStr = (String)row.get("dobStr");
				   String degree = (String)row.get("degree");
				   String currentposition = (String)row.get("currentposition");
				   long mobilenumber = (long)row.get("mobilenumber");
				   String email = (String)row.get("email");
				   
				   %>
				   
			<tr>
		       <td><a href="#"><img src="images/edit.png" style="height:17px;width:25px;"></a></td>
		       <td><a href="#"><img src="images/delete.png" style="height:17px;width:25px;"></a></td>
		      <td><a href="#"><%=name %></a></td>
		      <td><%=batchyear %></td>
		      <td><%=passoutyear %></td>
		      <td><%=dobStr %></td>
		      <td><%=degree %></td>
		      <td><%=currentposition %></td>
		      <td><%=mobilenumber %></td>
		      <td><%=email %></td>

		    </tr>
				   
	  <%      	   }
		   }
				%>
		  </tbody>
		</table>
	      </div>
	      </main>
	</div>