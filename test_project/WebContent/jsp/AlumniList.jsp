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
	  <main class="hoc container clear" id="AlumniListSection" style="max-width: 1115px;"> 
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
		      <th style="width:5%;border-color: #c5c5c5;"></th>
		      <th style="width:5%;border-color: #c5c5c5;"></th>
		      <%} %>
		      <th style="width:10%;border-color: #c5c5c5;">Name</th>
		      <th style="width:8%;border-color: #c5c5c5;">Batch</th>
		      <th style="width:8%;border-color: #c5c5c5;">Year of PassOut</th>
		      <th style="width:12%;border-color: #c5c5c5;">Date of Birth</th>
		      <th style="width:12%;border-color: #c5c5c5;">Degree</th>
		      <th  style="width:15%;border-color: #c5c5c5;">Current Position</th>
		      <th style="width:10%;border-color: #c5c5c5;">Mobile Number</th>
		      <th style="width:15%;border-color: #c5c5c5;">Email</th>		      
		    </tr>
		  </thead>
		  <tbody>
		  <%
				ArrayList alumnilist = (ArrayList)request.getAttribute("alumniList");
		   if(alumnilist != null && !alumnilist.isEmpty()){
			   for(int i=0; i<alumnilist.size(); i++){
				   HashMap row = (HashMap)alumnilist.get(i);
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
				   
			<tr>
			<%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		       <td style="width:5%;border-color: #c5c5c5;"><a onClick="javascript:editAlumni(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;"></a></td>
		       <td style="width:5%;border-color: #c5c5c5;"><a onClick="javascript:deleteAlumni(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;"></a></td>
		       <%} %>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:10%;border-color: #c5c5c5;"><%=name %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:8%;border-color: #c5c5c5;"><%=batchyear %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:8%;border-color: #c5c5c5;"><%=passoutyear %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:12%;border-color: #c5c5c5;"><%=dobStr %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:12%;border-color: #c5c5c5;"><%=degree %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:15%;border-color: #c5c5c5;"><%=currentposition %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:10%;border-color: #c5c5c5;"><%=mobilenumber %></td>
		      <td onclick="javascript:getAlumniDetails(this);" value="<%=id %>" style="width:15%;border-color: #c5c5c5;"><%=email %></td>

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