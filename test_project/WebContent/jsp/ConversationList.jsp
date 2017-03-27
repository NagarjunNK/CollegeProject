<%@ page import="java.util.*" %>
<script>
jQuery(document).ready(function() {
		jQuery(".conversationList").on("click",function(){
			var val = jQuery(this).attr("value");
			 jQuery.ajax('/AluminiMgnt/conversation.do?action=getconversation&id='+val, {
			      success: function(data) {
			        jQuery('#conv').append(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
});
	

	
	
</script>
<div id="ConversationContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Conversations</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="eventbreadcrum">Conversations</a></li>
	    </ul>
	  </section>
	</div>
<div class="wrapper row3">
	  <main class="hoc container clear" id="ConvSection"> 

	  <div class="w3-cell-row">
		<div class="w3-container w3-cell w3-border w3-cell-top" style="width: 16%;height:700px;display:table-cell; padding:0px;">
<ul class="w3-ul " style="height:700px;overflow-y:auto;">
<%
ArrayList userList = (ArrayList)request.getAttribute("conversationList");
if(userList != null && !userList.isEmpty()){
	   for(int i=0; i<userList.size(); i++){
		   HashMap row = (HashMap)userList.get(i);
		   int id = (int)row.get("id");
		   String name = (String)row.get("username");
		   String role = (String)row.get("role");
%>
 <li class="w3-padding-16  w3-hover-grey" id="li_<%=id%>">
 	<div id="convheader_<%=id%>" value="<%=id%>" class="conversationList">
    <img src="images/demo/avatar.png" class="w3-left w3-circle w3-margin-right" style="width:50px;">
    <span class="w3-large"><%=name %></span><br>
    <span><%=role %></span>
    </div>
    
  </li>  
  <%}
	   }else{%>
  <li style="text-align:center;"><span>No user in portal to chat..!!</span></li>
  <%} %>
</ul>
</div>
<div  class="w3-display-container w3-cell w3-border" style="width: 37%;height:700px;display:table-cell; position:relative;">
<div id="conv"></div>
<div class="w3-cell-row" style="position: absolute;width:100%;bottom:0;">
<table style="margin-bottom:0px;"><tr><td style="width:95%;"><input class="w3-input w3-border w3-round-large " type="text"></td>
<td><button type="button" class="w3-btn w3-padding w3-teal w3-round-large ">Send &nbsp; ></button></td></tr></table>

    
    </div>
    </div>
    </div>
   
</main>
</div>
</div>