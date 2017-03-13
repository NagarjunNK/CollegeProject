<%@ page import="java.util.*" %>
<script>
jQuery(document).ready(function() {
	
});
	
function showHide(eve){
	var val = jQuery(eve).attr("value");
	jQuery("#li_"+val).toggleClass("w3-hover-grey");
	jQuery(eve).on("click",function(){
		 jQuery.ajax('/AluminiMgnt/conversation.do?action=getconversation&id='+val, {
		      success: function(data) {
		        jQuery("#conv_"+val).html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	});
	jQuery("#conv_"+val).toggleClass("w3-hide");
}
	
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
<ul class="w3-ul w3-card-4">
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
 	<div id="convheader_<%=id%>" value="<%=id%>" onclick="javascrtip:showHide(this);">
    <img src="images/demo/avatar.png" class="w3-left w3-circle w3-margin-right" style="width:50px">
    <span class="w3-large"><%=name %></span><br>
    <span><%=role %></span>
    </div>
    <div id="conv_<%=id%>" class="w3-hide">
    	
    </div>
  </li>  
  <%}
	   }%>
  <li class="w3-padding-16 w3-hover-grey" id="convName">
  	<div id="conv1">
    <img src="images/demo/avatar.png" class="w3-left w3-circle w3-margin-right" style="width:50px">
    <span class="w3-large">Mike</span><br>
    <span>Student</span>
    </div>
    <div id="conv" class="w3-hide">
	</div>
  </li>
  <li class="w3-padding-16  w3-hover-grey">
    <img src="images/demo/avatar.png" class="w3-left w3-circle w3-margin-right" style="width:50px">
    <span class="w3-large">Jill</span><br>
    <span>Admin</span>
  </li>  
  <li class="w3-padding-16  w3-hover-grey">
    <img src="images/demo/avatar.png" class="w3-left w3-circle w3-margin-right" style="width:50px">
    <span class="w3-large">Jane</span><br>
    <span>Student</span>
  </li> 
</ul>
</main>
</div>
</div>