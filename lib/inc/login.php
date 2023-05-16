<?php

	include("db.php");
	
	function validate($data) {
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}
	
	$email = validate($_POST['email']);
	$password = validate ($_POST['password']);
	
	if (empty($email)) {
		print("An email is required. <br><br>");
		exit();
	}
	if (empty($password)) {
		print("A password is required. <br><br>");
		exit();
	}
	
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	$row = $result->fetch_assoc();
	if (($email != $row['email']) || (!password_verify($password, $row['password']))) {
		print("Incorrect credentials. <br><br>");
		exit();
	}

	$_SESSION['name'] = $row['username'];
	$_SESSION['id'] = $row['id'];
	session_write_close();
	
	$session_id = session_id();
	$sql = "UPDATE users SET session='".$session_id."' WHERE id=1";
	if ($db->query($sql) === FALSE) {
		print("Could not set session.");
		die();
	}
	
	print("success");
	exit();

?>