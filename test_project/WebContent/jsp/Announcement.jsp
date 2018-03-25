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
	jQuery(document).ready(function() {	
		jQuery('#announcementList').DataTable({ "info": false});
	    jQuery('#newsbreadcrum').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=getallannouncement', {
			      success: function(data) {
			    	  $('#mainav li').each(function() {
			    		   $(this).removeAttr('class');
			    		});
			        jQuery('#ContentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	    jQuery('#addNewAnnouncement').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=addNewAnnouncement', {
			      success: function(data) {
			    	  jQuery('#mainav li').each(function() {
			    		  jQuery(this).removeAttr('class');
			    		});
					jQuery('#AnnouncementSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	 
	   
	} );
	 function editAnnouncement(ele){
	    	var id = jQuery(ele).attr('value');
	    	var url = '/AluminiMgnt/alumni.do?action=editAnnouncement&id='+id;
	    	jQuery.ajax(url, {
	    	      success: function(data) {
	    		jQuery('#AnnouncementSection').html(data);
	    	      },
	    	      error: function() {
	    	    	  console.log("error");
	    	      }
	    	   });
	    }
	    function deleteAnnouncement(ele){
	    	if(confirm("Are you sure?")){
	    		var id = jQuery(ele).attr('value');
	    		var url = '/AluminiMgnt/alumni.do?action=deleteAnnouncement&id='+id;
	    		jQuery.ajax(url, {
	    		      success: function(data) {
	    				  jQuery('#NewsContent').html(data);
	    		      },
	    		      error: function() {
	    		    	  console.log("error");
	    		      }
	    		   });
	    	}
	    	return false;
	    }

	</script>
	<div id="NewsContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">News & Announcement</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="">News & Announcement</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="AnnouncementSection"> 
		<div class="scrollable">
		<div style="width:100%;padding-bottom:60px;" ><h1>News & Announcement</h1><a style="float:right;" class="btn" id="addNewAnnouncement">Add New Announcement</a></div>
		<table id="announcementList" >
		  <thead>
		    <tr>
		    <th width='5%'></th>
		      <th width='5%'></th>
		      <th width='8'>Announcement</th>
		    </tr>
		  </thead>
		  <tbody>
		  <%
				ArrayList announcements = (ArrayList)request.getAttribute("announcements");
		   if(announcements != null && !announcements.isEmpty()){
			   for(int i=0; i<announcements.size(); i++){
				   HashMap row = (HashMap)announcements.get(i);
				   String message = (String)row.get("message");
				   Long id = Long.parseLong(row.get("id").toString());
				    %>
				   
			<tr>
				<td><a onClick="javascript:editAnnouncement(this);" value="<%=id %>"><img src="images/edit.png" style="height:17px;width:25px;" ></a></td>
		       <td><a onClick="javascript:deleteAnnouncement(this);" value="<%=id %>"><img src="images/delete.png" style="height:17px;width:25px;" ></a></td>
		       <td  value="<%=id %>"><%=message %></td>
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