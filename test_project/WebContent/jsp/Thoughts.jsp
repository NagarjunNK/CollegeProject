	<%@ page import="java.util.*" %>

	<script>
	jQuery(document).ready(function() {	
	    jQuery('#thoughtsbreadcrum').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/alumni.do?action=getallthoughts', {
			      success: function(data) {
			    	  $('#mainav li').each(function() {
			    		   $(this).removeAttr('class');
			    		});
			        jQuery('#contentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	    jQuery('#share').on("click",function(){
			 jQuery.ajax('/AluminiMgnt/jsp/NewThoughts.jsp', {
			      success: function(data) {
			    	  jQuery('#mainav li').each(function() {
			    		  jQuery(this).removeAttr('class');
			    		});
				jQuery('#contentSection').html(data);
			      },
			      error: function() {
			    	  console.log("error");
			      }
			   });
		});
	 
	} );
	

	</script>
	<div id="ThoughtsContent">
	<div class="wrapper bgded overlay" style="background-image:url('../images/demo/backgrounds/01.png');">
	  <section id="breadcrumb" class="hoc clear"> 
	    <h6 class="heading">Alumni Thoughts</h6>
	    <ul>
	      <li><a href="#">Home</a></li>
	      <li><a id="thoughtsbreadcrum">Alumni Thoughts</a></li>
	    </ul>
	  </section>
	</div>
	<div class="wrapper row3">
	  <main class="hoc container clear" id="EventSection"> 
		<div class="scrollable">
		<div style="width:100%;padding-bottom:60px;" ><h1>Alumni Thoughts</h1><a style="float:right;" class="btn" id="share">Share Your Thoughts</a></div>
		  <%
				ArrayList thoughts = (ArrayList)request.getAttribute("thoughts");
		   if(thoughts != null && !thoughts.isEmpty()){
			   for(int i=0; i<thoughts.size(); i++){
				   HashMap row = (HashMap)thoughts.get(i);
				   String name = (String)row.get("name");
				   String message = (String)row.get("message");
				    %>
				   
			<div class="w3-panel w3-leftbar w3-light-grey">
  				<p class="w3-xlarge w3-serif">
  				<i>"<%=message %>"</i></p>
  				<p><%=name %></p>
			</div>
			<br>
				   
	  <%      	   }
		   }
				%>
		  
	      </div>
	      </main>
	</div>
	</div>