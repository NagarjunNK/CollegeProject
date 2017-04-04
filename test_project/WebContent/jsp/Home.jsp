<!DOCTYPE html>
<html lang="">
<head>
<title>Alumni Management System</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script src="layout/scripts/jquery.min.js"></script>
<script src="layout/scripts/jquery.backtotop.js"></script>
<script src="layout/scripts/jquery.dataTables.min.js"></script>
<script src="layout/scripts/jquery.validate.min.js"></script>
<script src="layout/scripts/jquery.mobilemenu.js"></script>
<script src="layout/scripts/jquery.flexslider-min.js"></script>
<script src="layout/scripts/alumni.js"></script>
<%@ page import="java.util.*" %>
<%@ page buffer="128kb" autoFlush="false"  %>
<link rel="stylesheet" href="resources/w3.css">
<style>
blockquote {
    font-family: Georgia, serif;
    position: relative;
    margin: 0.5em;
    padding: 0.5em 2em 0.5em 3em;
}
blockquote:before {
    font-family: Georgia, serif;
    position: absolute;
    font-size: 6em;
    line-height: 1;
    top: 0;
    left: 0;
    content: "\201C";
}
blockquote:after {
    font-family: Georgia, serif;
    position: absolute;
    float:right;
    font-size:6em;
    line-height: 1;
    right:0;
    bottom:-0.5em;
    content: "\201D";
}
blockquote footer {
    padding: 0 2em 0 0;
    text-align:right;
}
blockquote cite:before {
    content: "\2013";
}
.error {
	color: red;
}
</style>
</head><body id="top">
<script>
<%
String forwardTo = (String)request.getAttribute("forwardTo");
%>
jQuery(document).ready(function() {
	 var forwardTo='<%=forwardTo%>';
	 if(forwardTo){
		 jQuery
		 jQuery('#'+forwardTo).click();
	 } 
	 var timer = setInterval( getThoughts, 10000);
	 jQuery('.flexslider').flexslider({
         animation: "slide",         slideshow:true,         slideshowSpeed:3000,         controlNav: false,         controlsContainer: ".flex-container",
         start: function(slider) {
           $('.total-slides').text(slider.count);
         },
         after: function(slider) {
           $('.current-slide').text(slider.currentSlide);
         }
    });
});
window.onclick = function(event) {
	if (event.target == document.getElementById('id01')) {		resetForm();	}
}
	</script>
	 <div id="id01" class="w3-modal">
						<div class="w3-modal-content w3-card-8 w3-animate-zoom"	style="max-width: 600px">
							<div class="w3-center">
								<br> <span	onclick="resetForm()"	class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright"	title="Close Modal">&times;</span>
								<h2>Login</h2>
							</div>
							<div id="id02">
								<form id="loginForm" class="w3-container">
									<div class="w3-section">
										<div id="id021">
											<input type="hidden" name="forwardTo" value="">
											<label><b>Username</b></label> <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="username" required>
											<label><b>Password</b></label> <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="password" required>
										</div>
										<div id="alert" class="w3-red" style="display:none;"><h6>Invalid Login!</h6></div>
										<div class="w3-center">
										<button class="w3-btn w3-orange w3-section w3-padding w3-text-white"	type="button" onclick="login()">Login</button>
										<button	onclick="document.getElementById('id01').style.display='none'"	type="button" class="w3-btn w3-grey w3-text-white">Cancel</button>
										</div>
									</div>
								</form>
							</div>
							<div id="id03" style="display: none;">
								<div class="w3-panel w3-green">
									<h3>Login success!</h3>
									<p>You have been logged in successfully into alumini
										management system</p>
								</div>
							</div>
						</div>
					</div>  
<div class="wrapper row1" style="background-color:white;">
<%
String role = (String)request.getSession().getAttribute("role"); 
%>
 <div id="login" style="text-align:right;color:brown;font-size:medium;"><%if(request.getSession().getAttribute("role") ==null){ %><a onclick="document.getElementById('id01').style.display='block'">Login</a><%}else{ %><a href="/AluminiMgnt/jsp/Logout.jsp">Logout</a><% }%>&nbsp; &nbsp;</div>
  <header id="header" class="hoc clear" style="max-width:1040px;"> <div> <img src="images/demo/backgrounds/univlogo1.jpg"  ></div>  </header>
</div>
<div class="wrapper row2">
  <nav id="mainav" class="hoc clear" style="display: block;text-align: center;"> 
    <ul class="clear">
      <li id="home" class="active"><a href="/AluminiMgnt/alumni.do?action=home">Home</a></li>
      <li id="aboutus"><a class="drop" href="#">About Us</a>
      	<ul>
              <li><a href="#">Department</a>
              		<ul>
              			<li><a  id="history" onclick="loadHistory();">History</a></li>
              			<li><a id="administration" onclick="loadAdmin();">Administration</a></li>
            		</ul>
              </li>
              <li><a id="mission" onclick="loadlMission();">Mission & Vision</a></li>
              <li><a id="alumniSerivce" onclick="loadlAlumniService();">Career Services</a></li>
         </ul>
      </li>
      <li id="alumni" onclick="loadAlumni();"><a>Alumni</a></li>
      <li id="event" onclick="loadEvents();"><a>Events</a></li>
      <li id="galleries" onclick="loadGallery();"><a>Gallery</a></li>
    <%if(role != null){ %>  <li id="conversation" onclick="loadConv();"><a>Conversation</a></li> <%} %>
    <%if(role != null && role.equalsIgnoreCase("admin")){ %>  <li id="annoucement" onclick="loadAnnouncement();"><a>Announcements</a></li> <%} %>
    <%if(role != null && role.equalsIgnoreCase("admin")){ %>  <li id="users" onclick="loadUser();"><a>Users</a></li> <%} %>
    <li id="contactUs" onclick="loadContactUs();"><a>Contact Us</a></li>
    <li id="faq" onclick="loadFAQ();"><a>FAQ</a></li>
    </ul>
  </nav>
</div>
<div id="galleryDiv"></div>
<div id="contentSection">
<div class="flexslider" style="width:1905px;max-height:380px;">
	<ul class="slides">  <li> <img src="images/demo/backgrounds/welcome11.jpg" style="width:1905px;max-height:380px;"/> </li> <li> <img src="images/demo/backgrounds/JAYA main logo.jpg" style="width:1905px;max-height:380px;"/> </li>   <li> <img src="images/demo/backgrounds/welcome.jpg" style="width:1905px;max-height:380px;"/> </li> </ul>
</div>
<div class="wrapper bgded overlay"  style="background-color: black;">
  <div class="hoc container clear"> 
	  <h6 class="heading">Welcome Alumni..!!</h6>
          <p>At MKU [DCS], we belive in fostering a strong alumni network that not anly helps former students remain connected but also provide an a venue for the philanthropic spirit of successful alumni.</p>
    	  <div class="clear"></div>  </div></div>
<div class="wrapper row3">
<table><tr><td width=33.33%>
  <section class="container clear" style="display:block;"> 
    <div class="sectiontitle">
      <h6 class="heading">Today's Birthday</h6>
    </div>
    <div class="group">
      <div class="one_half first">
        <p><strong>Today Birthday</strong></p>
        <p>BirthDay is the day to remember that time is flying, there is lot to learn</p>
      </div>
      <div class="one_half">
		<marquee direction="up" scrollamount="2" onmouseover="this.stop();" onmouseout="this.start();" style="height:180px;">
			<ul>
			<%
			ArrayList birthday = (ArrayList)request.getAttribute("birthday");
           if(birthday != null && !birthday.isEmpty()){
        	   for(int i=0; i<birthday.size(); i++){
        		   HashMap row = (HashMap)birthday.get(i);
        		   String name = (String)row.get("name");
        		   int id = (int)row.get("id");
        		    %>
				<li><a onclick="javascript:getAlumniDetails(this);" value="<%=id%>"><%=name %></a></li>
				 <%      	   }
           }else{
			%>
			<li>No birthday today..!!</li>
			<%} %>
			</ul>
		</marquee>
      </div>
    </div>
  </section>
</td>
<td width=33.33%>
  <section class="hoc container clear"> 
    <div class="sectiontitle">    <h6 class="heading">News & Announcement</h6>    </div>
    <div class="group testimonials">	      <div class="one_half first">
      <p><strong>News & Announcement</strong></p>
        <p>Alumni association will make many decisions that impact the members of the assocation.</p>
        <p class="btmspace-30">So, this announcement will be made public in this forum.</p>
	</div>
	      <div class="one_half">
 <marquee direction="up" scrollamount="2" onmouseover="this.stop();" onmouseout="this.start();"  style="height:180px;">
			<ul>
				<%
			ArrayList announcement = (ArrayList)request.getAttribute("announcements");
           if(announcement != null && !announcement.isEmpty()){
        	   for(int i=0; i<announcement.size(); i++){
        		   HashMap row = (HashMap)announcement.get(i);
        		   String msg = (String)row.get("message");
        		   long id = (long)row.get("id");
        		    %>
				<li><%=msg %></li>
				 <%      	   }
           }else{
			%>
			<li>No news or events from association..!!</li>
			<%} %>
			</ul>
	</marquee>    
	</div>
    </div>
  </section>
</td>
<td width=33.33%>
<section class="hoc container clear"> 
    <div class="sectiontitle">      <h6 class="heading">Share your thoughts</h6>    </div>
    <div>
    	<blockquote id="quote">		The biggest likelihood in studying at Madurai KamarajUniversity is that it will provide the experience they want and help them to achieve their goals.    
		<div id="quoteOwn"><cite >Rajamuthu.R, Senior Sceintist in DRDO, 1992-1996 Batch</cite>	</div>
    	</blockquote>
    	<br>
    	<br>
    	<div id="thoughtBtn">	
    	<%if(role != null && role.equalsIgnoreCase("alumni")){ %>
    	    	 <a  onclick="share();" id="share" class="btn">Share your thoughts</a><span>&nbsp;</span><a onclick="read();" id="read" class="btn">Read More</a>
    	<%}else { %>
    	    	<a onclick="loginShare();"  class="btn">Share your thoughts</a><span>&nbsp;</span><a onclick="loginRead();" class="btn">Read More</a>
    	<%} %> 
    	</div>
    	<div id="shareThoughts" style="display:none;">
    		<div id="thought-form">	<textarea id="cmt" style="width:100%; min-height:100px;"></textarea><br><a onclick="postThoughts();" class="btn">Post</a>&nbsp;<a id="sharecancel" class="btn">Cancel</a></div>
    	</div>
	</div>
  </section>
</td></tr></table>
</div>
</div>
<div class="wrapper row4 bgded overlay" style="background-color: black;">
  <footer id="footer" class="hoc clear"><div class="one_quarter first">      <h6 class="heading">About us</h6> <p>About us text-1</p><p>About us text-2</p>    </div>
    <div class="one_quarter">
      <h6 class="heading">Policy</h6>
      <nav>
        <ul class="nospace linklist"><li><a href="#">Terms</a></li><li><a href="#">Privacy</a></li><li><a href="#">Cookies</a></li><li><a href="#">Disclaimer</a></li>        </ul>
      </nav>
    </div>
    <div class="one_quarter">
      <h6 class="heading">Quick Links</h6>
      <ul class="nospace linklist"><li><a href="#">College website</a></li><li><a href="#">Library</a></li>        <li><a href="#">Career center</a></li>       <li><a href="#">News room</a></li>      </ul>
    </div>
     <div class="one_quarter">
      <h6 class="heading">Social Media</h6>
      <ul class="faico clear">
        <li><a class="faicon-facebook" href="#"><i class="fa fa-facebook"></i></a></li>
        <li><a class="faicon-twitter" href="#"><i class="fa fa-twitter"></i></a></li>
        <li><a class="faicon-dribble" href="#"><i class="fa fa-dribbble"></i></a></li>
        <li><a class="faicon-linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
        <li><a class="faicon-google-plus" href="#"><i class="fa fa-google-plus"></i></a></li>
        <li><a class="faicon-vk" href="#"><i class="fa fa-vk"></i></a></li>
      </ul>
    </div>
  </footer>
</div>
<div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    <p class="fl_left">Copyright &copy; 2017 - All Rights Reserved - <a href="#">Domain Name</a></p>
    <p class="fl_right">Developed by <a target="_blank" href="http://www.os-templates.com/" title="Free Website Templates">Team</a></p>
  </div>
</div>
<a id="backtotop" href="#top"><i class="fa fa-chevron-up"></i></a>

</body>
</html>