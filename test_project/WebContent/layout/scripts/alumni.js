function getAlumniDetails(ele){
	var id = jQuery(ele).attr('value');
	jQuery.ajax('/AluminiMgnt/alumni.do?action=getalumnidetail&id='+id, {
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
	var url = "/AluminiMgnt/alumni.do?action=geteventdetail&id="+id;
	jQuery.ajax(url, {
	      success: function(data) {
			jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function resetForm(){
	document.getElementById('id01').style.display='none';	document.getElementById('id02').style.display = 'block';	document.getElementById('id03').style.display = 'none';	document.getElementById('alert').style.display='none';	jQuery("input[name='username']").val('');	jQuery("input[name='password']").val('');
}

function login() {
	var inputs = $('#loginForm').serializeArray();
	$.ajax({				url : "/AluminiMgnt/login",				
							data : inputs,			
							type : "GET",
							success : function(data) {
								var json = JSON.parse(data);
								var status = json.status;
								var forwardTo = json.forwardTo;
									if (status == "success") {
										window.location.href="/AluminiMgnt/alumni.do?action=home&forwardTo="+forwardTo;
										document.getElementById('id02').style.display = 'none';			
										document.getElementById('id03').style.display = 'block';
									} else {
										document.getElementById('alert').style.display = 'block';
									}
							}
			});
}
function postThoughts(){
	var thoughts = jQuery("#cmt").val();	var url = '/AluminiMgnt/alumni.do?action=postThoughts&thoughts='+thoughts;
	jQuery.ajax(url, {
	      success: function(data) {
			jQuery("#thoughtBtn").show();
			jQuery("#cmt").val('');
			jQuery("#shareThoughts").hide();
	      },
	      error: function() {	    	  console.log("error");	      }
	   });
}
function getThoughts(){
	jQuery.ajax('/AluminiMgnt/alumni.do?action=getThoughts', {
	      success: function(data) {
	    	  jQuery("#quote").text(data.message);		    	  jQuery("#quoteOwn").text(data.name);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}

function loadGallery(){
	 jQuery.ajax('/AluminiMgnt/gallery.do', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {		    		  
	    		  $(this).removeAttr('class');		    		
	    		  });
	    	jQuery('#galleries').addClass('active');	
	    	jQuery('#contentSection').html(data);
	      },
	      error: function() {		    	 
	    	  console.log("error");		      }
	   });
}
function loadEvents(){
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
}
function loadAlumni(){
	jQuery.ajax('/AluminiMgnt/alumni.do?action=getalumnilist', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {		    		   $(this).removeAttr('class');		    		});
	    	jQuery('#alumni').addClass('active');		        jQuery('#contentSection').html(data);
	      },
	      error: function() {		    	  console.log("error");		      }
	   });
}
function loadConv(){
	 jQuery.ajax('/AluminiMgnt/conversation.do?action=getconversationlist', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {		    		   $(this).removeAttr('class');		    		});
	    	jQuery('#conversation').addClass('active');		        jQuery('#contentSection').html(data);
	      },
	      error: function() {		    	  console.log("error");		      }
	   });
}
function loadHistory(){
	 jQuery.ajax('/AluminiMgnt/jsp/History.jsp', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {		    		   $(this).removeAttr('class');		    		});
	    	jQuery('#aboutus').addClass('active');		        jQuery('#contentSection').html(data);
	      },
	      error: function() {		    	  console.log("error");		      }
	   });
}
function loadAdmin() {
	 jQuery.ajax('/AluminiMgnt/jsp/Administration.jsp', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	jQuery('#aboutus').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loadlMission(){
	 jQuery.ajax('/AluminiMgnt/jsp/MissionAndVision.jsp', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	jQuery('#aboutus').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loadlAlumniService(){
	 jQuery.ajax('/AluminiMgnt/jsp/AlumniService.jsp', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	jQuery('#aboutus').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loadUser(){
	 jQuery.ajax('/AluminiMgnt/user.do?action=userList', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	jQuery('#users').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loadContactUs(){
	jQuery.ajax('/AluminiMgnt/jsp/ContactUs.jsp', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	jQuery('#contactUs').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loadFAQ(){
	 jQuery.ajax('/AluminiMgnt/jsp/FAQ.jsp', {
	      success: function(data) {
	    	  jQuery('#mainav li').each(function() {
	    		  jQuery(this).removeAttr('class');
	    		});
	    	jQuery('#faq').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}
function loginShare(){
	jQuery("input[name='forwardTo']").val("share")
	document.getElementById('id01').style.display='block';
}
function loginRead(){
	jQuery("input[name='forwardTo']").val("read");
	document.getElementById('id01').style.display='block';
}
function share(){
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
}

function read(){
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
}
function loadAnnouncement(){
	 jQuery.ajax('/AluminiMgnt/alumni.do?action=getallannouncement', {
	      success: function(data) {
	    	  $('#mainav li').each(function() {
	    		   $(this).removeAttr('class');
	    		});
	    	  jQuery('#annoucement').addClass('active');
	        jQuery('#contentSection').html(data);
	      },
	      error: function() {
	    	  console.log("error");
	      }
	   });
}