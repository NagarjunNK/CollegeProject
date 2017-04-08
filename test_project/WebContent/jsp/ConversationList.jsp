<%@ page import="java.util.*" %>
<script>
jQuery(document).ready(function() {
		jQuery(".conversationList").on("click",function(){
			var val = jQuery(this).attr("value");
			 jQuery.ajax('/AluminiMgnt/conversation.do?action=getconversation&id='+val, {
			      success: function(data) {
			        jQuery('#conv').html(data);
			        jQuery("#commentBox").show();
			        jQuery("#postComment").attr("value",val);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
			 jQuery.ajax('/AluminiMgnt/conversation.do?action=markAsRead&id='+val, {
				 success: function(data) {
				     
				      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
		jQuery("#postComment").on("click",function(){
			var comment = jQuery("#comment").val();
			var val = jQuery(this).attr("value");
			jQuery.ajax({
				url:'/AluminiMgnt/conversation.do?action=postComment&id='+val+'&message='+comment,
				success:function(data){
					jQuery('#conv').html(data);
			        jQuery("#commentBox").show();
			        jQuery("#postComment").attr("value",val);
			        jQuery("#comment").val("");
				},
				error:function(){
					 console.log("error");
				}
			});
		});
		jQuery(".w3-hover-grey").on("click",function(){
			jQuery(".w3-grey").removeClass("w3-grey").addClass("w3-hover-grey");
			jQuery(this).addClass("w3-grey");
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
	  <%
		int newMsgCount = (int)request.getAttribute("newMessageCount");
		if( newMsgCount>0){
		%>
	  <div class="w3-panel w3-green w3-display-container">
	  		<span onclick="this.parentElement.style.display='none'" class="w3-button w3-green w3-large w3-display-topright"><a>x</a></span>
			<div class="w3-padding-16" style="text-align:center;">You have <div class="w3-badge"><%=newMsgCount %></div> new message </div>
	</div>
	<%} %>
<%
ArrayList userList = (ArrayList)request.getAttribute("conversationList");
if(userList != null && !userList.isEmpty()){
%>
	  <div class="w3-cell-row">
		<div class="w3-container w3-cell w3-border w3-cell-top" style="width: 16%;height:700px;display:table-cell; padding:0px;">
<ul class="w3-ul " style="height:700px;overflow-y:auto;">
<%
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
  <%}%>
  
  </ul>
</div>
<div  class="w3-display-container w3-cell w3-border" style="width: 37%;height:700px;display:table-cell; position:relative;">
<div id="conv"><h6 class="heading w3-display-middle">Select user to start conversation</h6></div>
<div class="w3-cell-row" style="position:absolute;width:100%;bottom:0;display:none;" id="commentBox">
<table style="margin-bottom:0px;"><tr><td style="width:95%;"><textarea class="w3-input w3-border w3-round-large " type="text" id="comment"></textarea></td>
<td><button type="button" class="w3-btn w3-padding w3-teal w3-round-large " id="postComment">Send &nbsp; ></button></td></tr></table>

    
    </div>
    </div>
    </div>
  
	<%   }else{%>
  <li style="text-align:center;"><span>No user in portal to chat..!!</span></li>
  <%} %>

   
</main>
</div>
</div>