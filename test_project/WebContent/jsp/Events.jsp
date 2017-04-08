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
	    jQuery('#eventsList').DataTable({ "info": false});
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
	    
	    jQuery('#eventbreadcrum').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=getevents', {
			      success: function(data) {
			    	  $('#mainav li').each(function() {
			    		   $(this).removeAttr('class');
			    		});
			    	jQuery('#event').addClass('active');
			        jQuery('#contentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	 
	} );
	
	function editEvent(ele){
		var id = jQuery(ele).attr('value');
		var url = '/AluminiMgnt/alumni.do?action=editEvent&id='+id;
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
			var url = '/AluminiMgnt/alumni.do?action=deleteEvent&id='+id;
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
		var url = '/AluminiMgnt/alumni.do?action=geteventdetail&id='+id;
		jQuery.ajax(url, {
		      success: function(data) {
			jQuery('#EventContent').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	}
	</script>
	<div id="EventContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Events</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="eventbreadcrum">Events</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="EventSection" style="max-width: 1115px;"> 
	  <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		<div style="width:100%;padding-bottom:60px;" ><h1>Events</h1><a style="float:right;" class="btn" id="AddNewEvent">Add Event</a></div>
		<%} %>
		<div class="scrollable">
		<table id="eventsList" >
		  <thead>
		    <tr>
		    <%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		      <th style="width:5%;border-color: #c5c5c5;"></th>
		      <th style="width:5%;border-color: #c5c5c5;"></th>
		      <%} %>
		      <th style="width:30%;border-color: #c5c5c5;">Title</th>
		      <th style="width:30%;border-color: #c5c5c5;">Description</th>
		      <th style="width:20%;border-color: #c5c5c5;">Place</th>
		      <th style="width:10%;border-color: #c5c5c5;">Date</th>
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
			<%
	  if(request.getSession().getAttribute("role") != null && request.getSession().getAttribute("role").toString().equalsIgnoreCase("admin")){
	  %>
		       <td style="width:5%;border-color: #c5c5c5;"><a onClick="javascript:editEvent(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;" ></a></td>
		       <td style="width:5%;border-color: #c5c5c5;"><a onClick="javascript:deleteEvent(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;" ></a></td>
		       <%} %>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>" style="width:30%;border-color: #c5c5c5;"><%=title %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>" style="width:30%;border-color: #c5c5c5;"><%=desc %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>" style="width:20%;border-color: #c5c5c5;"><%=place %></td>
		      <td onclick="javascript:getEventDetails(this);" value="<%=id %>" style="width:10%;border-color: #c5c5c5;"><%=time %></td>
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