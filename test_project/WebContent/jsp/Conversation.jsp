    <%@ page import="java.util.*" %>

    <% ArrayList<HashMap> conv = (ArrayList<HashMap>)request.getAttribute("conversation");
    if(conv != null && !conv.isEmpty()){
    %>
    <br><br>
    <ul style="list-style-type:none;">
    <%
    for(int i=0; i<conv.size(); i++){
    	HashMap msg = (HashMap)conv.get(i);
    	String username = (String)msg.get("username");
    	String comment = (String)msg.get("message");
    	String time = (String)msg.get("time");
    %>
	<li style="border-bottom:0px;">
		<article class="w3-container w3-pale-blue w3-round-large w3-padding">
			<header>
				<address>
					By <a href="#"><%=username%></a>
				</address>
				<time datetime="2045-04-06T08:15+00:00">
					<%=time%>
				</time>
			</header>
			<div class="comcont">
				<p><%=comment%></p>
			</div>
		</article>
	</li>
	<br>
	<%}} %>
	<ul style="list-style-type:none;">
	<li style="border-bottom:0px;">
		<article class="w3-container w3-pale-blue w3-round-large">
			<header>
				<address>
					By <a href="#">A Name</a>
				</address>
				<time datetime="2045-04-06T08:15+00:00">
					Friday, 6<sup>th</sup> April 2045 @08:15:00
				</time>
			</header>
			<div class="comcont">
				<p>This is an example of a comment made on a post. You can
					either edit the comment, delete the comment or reply to the
					comment. Use this as a place to respond to the post or to share
					what you are thinking.</p>
			</div>
		</article>
	</li>
	<br>
	<li style="border-bottom:0px;">
		<article class="w3-container w3-pale-blue w3-round-large">
			<header>
				<address>
					By <a href="#">A Name</a>
				</address>
				<time datetime="2045-04-06T08:15+00:00">
					Friday, 6<sup>th</sup> April 2045 @08:15:00
				</time>
			</header>
			<div class="comcont">
				<p>This is an example of a comment made on a post. You can
					either edit the comment, delete the comment or reply to the
					comment. Use this as a place to respond to the post or to share
					what you are thinking.</p>
			</div>
		</article>
	</li>
</ul>