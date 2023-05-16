<?php

	include("db.php");
	
	session_unset();
	session_destroy();
	
	$sql = "UPDATE users SET session='' WHERE id=1";
	if ($db->query($sql) === FALSE) {
		print("Could not unset session.");
		die();
	}
	
	header("Location: /login/");
?>