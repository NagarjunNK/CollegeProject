<!DOCTYPE html>
<html>
<title>Alumini Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../resources/w3.css">
<script src="../resources/jquery-3.1.1.min.js"></script>

<body>
	<script>
		function login() {
			var inputs = $('#loginForm').serializeArray();
			$
					.ajax({
						url : "/AluminiMgnt/login",
						data : inputs,
						type : "GET",
						success : function(data) {
							if (data == "success") {
								console.log(data);
								document.getElementById('id02').style.display = 'none';
								document.getElementById('id03').style.display = 'block';
							} else {
								console.log(data);
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
	</script>
	<div class="w3-container">
		<table style="width: 100%">
			<tr>
				<td style="text-align: center;"><h2>Alumini Management System</h2></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<button	onclick="document.getElementById('id01').style.display='block'"	class="w3-btn w3-green w3-large">Login</button>
					<div id="id01" class="w3-modal">
						<div class="w3-modal-content w3-card-8 w3-animate-zoom"	style="max-width: 600px">
							<div class="w3-center">
								<br> <span	onclick="resetForm()"	class="w3-closebtn w3-hover-red w3-container w3-padding-8 w3-display-topright"	title="Close Modal">&times;</span>
								<h2>LOGIN</h2>
							</div>
							<div id="id02">
								<form id="loginForm" class="w3-container">
									<div class="w3-section">
										<div id="id021">
											<label><b>Username</b></label> <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="username" required>
											<label><b>Password</b></label> <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="password" required>
										</div>
										<div id="alert" class="w3-red" style="display:none;"><h6>Invalid Login!</h6></div>
										<button class="w3-btn-block w3-green w3-section w3-padding"	type="button" onclick="login()">Login</button>
									</div>
								</form>
								<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
									<button	onclick="document.getElementById('id01').style.display='none'"	type="button" class="w3-btn w3-red">Cancel</button>
								</div>
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
				</td>
			</tr>
		</table>
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
</body>
</html>