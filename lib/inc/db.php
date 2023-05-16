<?php
	error_reporting(0);
	$db = new mysqli("localhost", "root", "", "luminal_zone");
	
	if ($db->connection_error) {
		die("Connection failed: ". $db->connection_error);
	}
	

?>