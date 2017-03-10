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
});
<%}
}%>
</script>

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