<%@ page import="java.util.*" %>
<script>
<%
ArrayList event = (ArrayList)request.getAttribute("event");
if(event != null && !event.isEmpty()){
	for(int i=0; i<event.size(); i++){
		   HashMap row = (HashMap)event.get(i);
		   int id = (int)row.get("id");
		   String title = (String)row.get("title");
		   String desc = (String)row.get("description");
		   String place = (String)row.get("place");
		   String time = (String)row.get("time");
%>
jQuery(document).ready(function(){
	jQuery('#eventid').text('<%=id%>');
	jQuery('#name').text('<%=title%>');
	jQuery('#desc').text('<%=desc%>');
	jQuery('#place').text('<%=place%>');
	jQuery('#date').text('<%=time%>');
	
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
});
<%}
}%>
</script>
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
	  <main class="hoc container clear" id="EventSection"> 
<div class="form-sec">
<h2>Event Details</h2>
        <form id="event-form"  method="post">
        	<input type="hidden" name="eventid" id="eventid" value="">
        	<table>
        		<tr><td> <label for="name">Title :</label></td><td><span id="name"></span></td></tr>
        		<tr><td><label for="desc">Description :</label></td><td><span id="desc"></span></td></tr>
        		<tr><td><label for="place">Place  :</label></td><td><span id="place"></span></td></tr>
        		<tr><td> <label for="comment">Date :</label></td><td><span id="date"></span></td></tr>
        	</table>
        </form>
</div>
</main>
</div>