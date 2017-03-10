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
	<script>
	jQuery(document).ready(function() {
	    jQuery('#events').DataTable({ "info": false});
	    jQuery('#AddNewEvent').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=addNewEvent', {
			      success: function(data) {
				jQuery('#EventSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	 
	} );
	
	function editEvent(ele){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/alumni.do?action=editEvent'+'&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
			jQuery('#EventSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	function deleteEvent(ele){
		if(confirm("Are you sure?")){
			var id = jQuery(ele).attr('value');
			var url = '/AluminiMgnt/alumni.do?action=deleteEvent'+'&id='+id;
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
	function getEventDetails(ele){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/alumni.do?action=geteventdetail'+'&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
			jQuery('#EventSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	</script>
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Events</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a href="#">Events</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="EventSection"> 
		<div style="width:100%;padding-bottom:60px;" ><h1>Events</h1><a style="float:right;" class="btn" id="AddNewEvent">Add Event</a></div>
		<div class="scrollable">
		<table id="events" >
		  <thead>
		    <tr>
		      <th></th>
		      <th></th>
		      <th>Title</th>
		      <th>Description</th>
		      <th>Place</th>
		      <th>Date</th>
		    </tr>
		  </thead>
		  <tbody>
		  <%
				ArrayList events = (ArrayList)request.getAttribute("events");
		   if(events != null && !events.isEmpty()){
			   for(int i=0; i<events.size(); i++){
				   HashMap row = (HashMap)events.get(i);
				   int id = (int)row.get("id");
				   String title = (String)row.get("title");
				   String desc = (String)row.get("description");
				   String place = (String)row.get("place");
				   String time = (String)row.get("time"); %>
				   
			<tr>
		       <td><a onClick="javascript:editEvent(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;" ></a></td>
		       <td><a onClick="javascript:deleteEvent(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;" ></a></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>"><%=title %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>"><%=desc %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>"><%=place %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>"><%=time %></td>
		    </tr>
				   
	  <%      	   }
		   }
				%>
		  </tbody>
		</table>
	      </div>
	      </main>
	</div>