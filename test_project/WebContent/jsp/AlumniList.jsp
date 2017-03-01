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
		<div style="width:100%;padding-bottom:60px;" ><h1>Alumni</h1><a style="float:right;" class="btn"  id="AddNewAlumni">Add Alumni</a></div>
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
				   
			<tr>
		       <td><a onClick="javascript:editAlumni(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;"></a></td>
		       <td><a onClick="javascript:deleteAlumni(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;"></a></td>
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