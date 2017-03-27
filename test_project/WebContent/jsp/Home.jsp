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
<script src="layout/scripts/jquery.mobilemenu.js"></script>
<script src="layout/scripts/jquery.flexslider-min.js"></script>
<%@ page import="java.util.*" %>
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
</style>
</head>
<body id="top">
<script>
jQuery(document).ready(function() {
	
	 jQuery('.flexslider').flexslider({
         animation: "slide",
         slideshow:true,
         slideshowSpeed:3000,
         controlNav: false,
         controlsContainer: ".flex-container",
         start: function(slider) {
           $('.total-slides').text(slider.count);
         },
         after: function(slider) {
           $('.current-slide').text(slider.currentSlide);
         }
    });
	jQuery('#galleries').on("click",function(){
		 jQuery.ajax('/AluminiMgnt/gallery.do', {
		      success: function(data) {
		    	  $('#mainav li').each(function() {
		    		   $(this).removeAttr('class');
		    		});
		    	jQuery('#galleries').addClass('active');
		        jQuery('#contentSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	});
	jQuery('#event').on("click",function(){
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
	jQuery('#alumni').on("click",function(){
		 jQuery.ajax('/AluminiMgnt/alumni.do?action=getalumnilist', {
		      success: function(data) {
		    	  $('#mainav li').each(function() {
		    		   $(this).removeAttr('class');
		    		});
		    	jQuery('#alumni').addClass('active');
		        jQuery('#contentSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	});
	jQuery('#conversation').on("click",function(){
		 jQuery.ajax('/AluminiMgnt/conversation.do?action=getconversationlist', {
		      success: function(data) {
		    	  $('#mainav li').each(function() {
		    		   $(this).removeAttr('class');
		    		});
		    	jQuery('#conversation').addClass('active');
		        jQuery('#contentSection').html(data);
		      },
		      error: function() {
		    	  console.log("error");
		      }
		   });
	});
});
function login() {
	var inputs = $('#loginForm').serializeArray();
	$
			.ajax({
				url : "/AluminiMgnt/login",
				data : inputs,
				type : "GET",
				success : function(data) {
					if (data == "success") {
						window.location.reload();
						document.getElementById('id02').style.display = 'none';
						document.getElementById('id03').style.display = 'block';
					} else {
						document.getElementById('alert').style.display = 'block';
					}
				}
			});
}
function resetForm(){
	document.getElementById('id01').style.display='none'
	document.getElementById('id02').style.display = 'block';
	document.getElementById('id03').style.display = 'none';
	document.getElementById('alert').style.display='none'
	$("input[name='username']").val('');
	$("input[name='password']").val('');

}
function getAlumniDetails(ele){
	var id = jQuery(ele).attr('value');
	var url = '/AluminiMgnt/alumni.do?action=getalumnidetail'+'&id='+id;
	jQuery.ajax(url, {
	      success: function(data) {
		jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function getEventDetails(ele){
	var id = jQuery(ele).attr('value');
	var url = '/AluminiMgnt/alumni.do?action=geteventdetail'+'&id='+id;
	jQuery.ajax(url, {
	      success: function(data) {
		jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
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
					
<script>
		// Get the modal
		var modal = document.getElementById('id01');

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				resetForm();
			}
		}
</script>
<div class="wrapper row1">
<%

String role = (String)request.getSession().getAttribute("role"); 
%>
  <header id="header" class="hoc clear" style="max-width:1040px;"> 
  
  	<table style="border-color:#0a0a0a;"><tr style="background-color:#0a0a0a;">
  	<td style="border-color:#0a0a0a;width:15%;"><div><img src="images/demo/backgrounds/mdu_logo.jpg"  ></div></td>
  	<td style="border-color:#0a0a0a;width:70%;">
    <div id="logo"  style="text-align:center;">
    <h1><a href="/AluminiMgnt/alumni.do?action=home">MADURAI KAMARAJ UNIVERSITY</a></h1>
    <h1><a href="/AluminiMgnt/alumni.do?action=home">DEPARTMENT OF COMPUTER SCIENCE</a></h1>
      <h1><a href="/AluminiMgnt/alumni.do?action=home">ALUMNI INFORMATION MANAGEMENT SYSTEM</a></h1>
    </div>
    </td>
    <td style="border-color:#0a0a0a;width:15%;"> <div><img src="images/demo/backgrounds/mdu_logo.jpg"  ></div></td>
    </tr></table>
   <!--  <div id="quickinfo" class="fl_right">
      <ul class="nospace inline">
        <li><strong><a onclick="document.getElementById('id01').style.display='block'">Login</a></strong></li>|
        <li style="margin-left:50px;"><strong><a>Register</a></strong></li>
      </ul>
    </div> -->
  </header>
</div>

<div class="wrapper row2">
  <nav id="mainav" class="hoc clear" style="display: block;text-align: center;"> 
    <ul class="clear">
      <li id="home" class="active"><a href="/AluminiMgnt/alumni.do?action=home">Home</a></li>
      <li id="aboutus"><a class="drop" href="#">About Us</a>
      	<ul>
              <li><a href="#">Department</a>
              		<ul>
              			<li><a href="#">History</a></li>
              			<li><a href="#">Administration</a></li>
            		</ul>
              </li>
              <li><a href="#">Mission & Goals</a></li>
              <li><a href="#">Alumni Services</a></li>
         </ul>
      </li>
      <li id="alumni"><a>Alumni</a></li>
      <li id="event"><a>Events</a></li>
      <li id="galleries"><a>Gallery</a></li>
      <li id="conversation"><a>Conversation</a></li>
      <li id="login"><%if(request.getSession().getAttribute("role") ==null){ %><a onclick="document.getElementById('id01').style.display='block'">Login</a><%}else{ %><a href="/AluminiMgnt/jsp/Logout.jsp">logout</a><% }%></li>
    </ul>

  </nav>
</div>
<div id="galleryDiv">
</div>
<div id="contentSection">
<div class="flexslider" style="width:1905px;max-height:380px;">
	<ul class="slides">
        <li>
          <img src="images/demo/backgrounds/mkuniv2.jpg" style="width:1905px;max-height:380px;"/>
        </li>
        <li>
          <img src="images/demo/backgrounds/mkuniv2.jpg" style="width:1905px;max-height:380px;"/>
        </li>
        <li>
         <img src="images/demo/backgrounds/mkuniv2.jpg" style="width:1905px;max-height:380px;"/>
        </li>
      </ul>
</div>
<div class="wrapper bgded overlay"  style="background-color: black;">
  <main class="hoc container clear"> 
	  <h6 class="heading">Welcome Alumni..!!</h6>
          <p>At MKU [DCS], we belive in fostering a strong alumni network that not anly helps former students remain connected but also provide an a venue for the philanthropic spirit of successful alumni.</p>
          <!-- <footer><a class="btn" href="#">Read More &raquo;</a></footer> -->
    	  <div class="clear"></div>
  </main>
</div>
<div class="wrapper row3">
<table><tr><td width:33.33%>

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
<td width:33.33%>
  <section class="hoc container clear"> 
    <div class="sectiontitle">
      <h6 class="heading">News & Announcement</h6>
    </div>
    <div class="group testimonials">
	      <div class="one_half first">
      <p><strong>News & Announcement</strong></p>
        <p>Alumni association will make many decisions that impact the members of the assocation.</p>
        <p class="btmspace-30">So, this announcement will be made public in this forum.</p>
	</div>
	      <div class="one_half">
 <marquee direction="up" scrollamount="2" onmouseover="this.stop();" onmouseout="this.start();"  style="height:180px;">
			<ul>
				<%
			ArrayList event = (ArrayList)request.getAttribute("event");
           if(event != null && !event.isEmpty()){
        	   for(int i=0; i<event.size(); i++){
        		   HashMap row = (HashMap)event.get(i);
        		   String msg = (String)row.get("title");
        		   int id = (int)row.get("id");
        		    %>
				<li><a onclick="javascript:getEventDetails(this);" value="<%=id%>"><%=msg %></a></li>
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
<td width:33.33%>
<section class="hoc container clear"> 
    <div class="sectiontitle">
      <h6 class="heading">Share your thoughts</h6>
    </div>
    <div>
    <blockquote>
The biggest likelihood in studying at Madurai KamarajUniversity is that it will provide the experience they want and help them to achieve their goals.    <footer>
        <cite>
            Rajamuthu.R, 
            Senior Sceintist in DRDO,
            1992-1996 Batch
        </cite>
    </footer>
    </blockquote>
    <footer><a class="btn" href="#">Read More &raquo;</a></footer>
</div>
    <div class="clear"></div>
  </section>
</td></tr></table>
</div>

</div>
<div class="wrapper row4 bgded overlay" style="background-color: black;">
  <footer id="footer" class="hoc clear"> 
    <div class="one_quarter first">
      <h6 class="heading">About us</h6>
      <p>About us text-1</p>
      <p>About us text-2</p>
    </div>
    <div class="one_quarter">
      <h6 class="heading">Policy</h6>
      <nav>
        <ul class="nospace linklist">
          <li><a href="#">Terms</a></li>
          <li><a href="#">Privacy</a></li>
          <li><a href="#">Cookies</a></li>
          <li><a href="#">Disclaimer</a></li>
        </ul>
      </nav>
    </div>
    <div class="one_quarter">
      <h6 class="heading">Quick Links</h6>
      <ul class="nospace linklist">
        <li><a href="#">College website</a></li>
        <li><a href="#">Library</a></li>
        <li><a href="#">Career center</a></li>
        <li><a href="#">News room</a></li>
      </ul>
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