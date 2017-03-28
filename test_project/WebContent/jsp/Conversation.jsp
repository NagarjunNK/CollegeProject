    <%@ page import="java.util.*" %>
    <% ArrayList<HashMap> conv = (ArrayList<HashMap>)request.getAttribute("conversation");
    if(conv != null && !conv.isEmpty()){
    %>
    <ul style="list-style-type:none;height:615px;overflow:auto;" id="commentlist">
    <%
    for(int i=0; i<conv.size(); i++){
    	HashMap msg = (HashMap)conv.get(i);
    	String username = (String)msg.get("username");
    	String comment = (String)msg.get("message");
    	String time = (String)msg.get("time");
    %>
	<li style="border-bottom:0px;">
		<article class="w3-container w3-pale-blue w3-round-large w3-padding">
			
			<div class="comcont">
				<p><%=comment%></p>
			</div>
			<header>
				<address style="color: cadetblue;">
					By <a href="#"><%=username%></a> @<%=time%>
				</address>
			</header>
		</article>
	</li>
	<br>
	<%} %>
</ul>
<%}else{ %>
<h6 class="heading w3-display-middle">No Conversation found</h6>
<%}%>