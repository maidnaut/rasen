<?php
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	$row = $result->fetch_assoc();
	if ($_SESSION['name'] == $row['username']) {
		header("Location: /logout/");
	}
?>

<form name="login-form" action="" method="post" onsubmit="return login();">
	<fieldset>
		<h1>Access Terminal</h1> <br><br>
		<input id="email" type="text" size="12" name="email" placeholder="Email"><br>
		<input id="password" type="password" size="12" name="password" placeholder="Password"><br><br>
		<input type="submit" value="Log in">
	</fieldset>
</form>

<div class="response">

</div>

<script type="text/javascript">
	function login() {
		var email=$("#email").val();
		var password=$("#password").val();		
		$("#loading_spinner").css({"display":"block"});
		$.ajax({
			type:'post',
			url:'/lib/inc/login.php',
			data:{
				email:email,
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
</script>