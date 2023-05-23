<?php
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	$row = $result->fetch_assoc();
	if ($_SESSION['name'] == $row['username']) {
		header("Location: /logout/");
	}
?>

<form class="login" name="login-form" action="" method="post">
	<fieldset>
		<h1>Access Terminal</h1> <br><br>
		<input id="login" type="text" size="12" name="login" placeholder="Username"><br>
		<input id="password" type="password" size="12" name="password" placeholder="Password"><br><br>
		<input type="submit" value="Log in">
	</fieldset>
</form>

<div class="response">

</div>

<script type="text/javascript">
	$(document).ready(function() {
		$(".login").on("submit", function (e) {
			e.preventDefault();
			login();
		});
		function login() {
			var login=$("#login").val();
			var password=$("#password").val();		
			$("#loading_spinner").css({"display":"block"});
			$.ajax({
				type:'post',
				url:'/lib/inc/login.php',
				data:{
					login:login,
					password:password
				},
				success:function(response) {
					if(response!="success") {
						$("#loading_spinner").css({"display":"none"});
						$(".response").empty().append(response);
					} else {
						$(location).prop('href', '/admin/');
					}
				}
			});

			return false;
		}
	});
</script>