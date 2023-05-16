<?php
	error_reporting(0);
	if (!isset($_SESSION)) { session_start(); }
	
	// Include objects
	include_once("lib/inc/db.php");
	include_once("lib/inc/controller.php");
	include_once("lib/inc/functions.php");
	
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	$row = $result->fetch_assoc();
	if (session_id() == $row['session']) {
		$loggedin = true;
	} else {
		$loggedin = false;
	}
	
	$controller = new Controller();
	$controller->output();
?>