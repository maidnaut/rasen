<?php

	include("db.php");
	
	if ($_POST['mode'] == '') {
		echo "What are you trying to do?";
		die();
	} else {
		
		function validate($data) {
			$data = trim($data);
			$data = stripslashes($data);
			$data = htmlspecialchars($data);
			return $data;
		}

		function slug($slug) {
			global $db;
			$query = "SELECT * FROM posts WHERE slug='$slug'";
			$result = $db->query($query);
			if ($result->num_rows > 0) {
				$i = 1;
				while ($result->num_rows > 0) {
					$new_slug = $slug . $i;
					$query = "SELECT * FROM posts WHERE slug='$new_slug'";
					$result = $db->query($query);
					$i++;
				}
				return $new_slug;
			} 
			return $slug;
		}
		
		// POST
		if ($_POST['mode'] == "post") {
			
			$title = validate($_POST['title']);
			$slug = preg_replace('/[^\w\s]+/u', '', $title);
			$slug = strtolower(str_replace(" ", "-", $slug));
			$content = validate($_POST['content']);
			$files = $_POST['files'];
			$time = time();
			$hidden = ($_POST['hidden'] == 'on') ? "1" : "0";
			
			$slug = slug($slug);
			
			if (empty($title)) {
				print("A post title is required. <br><br>");
				exit();
			}

			if(isset($_FILES['file'])){
				$num_files = count($_FILES['file']['name']);
				if ($num_files > 4) {
					echo("You can only post 4 files.");
					die();
				}
				
				$upload_dir = $_SERVER['DOCUMENT_ROOT']."/lib/files/";
				foreach($_FILES['file']['name'] as $key=>$val){
					$path_parts = pathinfo($_FILES['file']['name'][$key]);
					$extension = $path_parts['extension'];
					
					if ($extension != "") {			
						$file_name = $_FILES['file']['name'][$key];
						$target_path = $upload_dir . $file_name;
						
						$i = 1;
						while (file_exists($target_path)) {
							$new_filename = pathinfo($file_name, PATHINFO_FILENAME) . '_' . $i . '.' . pathinfo($file_name, PATHINFO_EXTENSION);
							$target_path = $upload_dir . $new_filename; // update to use $new_filename instead of $file_name
							$i++;
						}
						
						if(!move_uploaded_file($_FILES['file']['tmp_name'][$key], $target_path)){
							echo("Failed to upload ".$file_name);
						} else {
							$uploaded_files .= $file_name;
							$uploaded_files .= ", ";
						}
						
					}
				}
			}
			
			$sql = "INSERT INTO posts (title, slug, postdate, content, files, hidden)
				VALUES ('$title', '$slug', '$time', '$content', '$uploaded_files', '$hidden')";
			if ($db->query($sql)) {
				echo("The system has posted your entry. You can view it at <a href='/".$slug."/'>".$slug."</a>.");
			}
		}

		// EDIT
		if ($_POST['mode'] == "edit") {
			
			$original_slug = $_POST['original_slug'];
			$title = validate($_POST['title']);
			$slug = preg_replace('/[^\w\s]+/u', '', $title);
			$slug = strtolower(str_replace(" ", "-", $slug));
			$content = validate($_POST['content']);
			$hidden = ($_POST['hidden'] == 'on') ? "1" : "0";
			
			if (empty($title)) {
				print("A post title is required. <br><br>");
				exit();
			}
			
			if ($original_slug != $slug) {
				$slug = slug($slug);
			}
			
			$sql = "UPDATE posts SET title='$title', slug='$slug', content='$content', hidden='$hidden' WHERE slug='$original_slug'";
			if ($db->query($sql)) {
				echo("Post has been edited. You can view it at <a href='/".$slug."/'>".$slug."</a>.");
			}
		}
		
		// KILL
		if ($_POST['mode'] == "delete") {
			$postdata = array();
			$id = $_POST['id'];
			$query = "SELECT * FROM posts WHERE id=$id";
			$result = $db->query($query);
			if ($result->num_rows <= 0) {
				echo "Could not find post.";
				die();
			} else {
				$post = $result->fetch_assoc();
				
				// Delete files
				if ($post['files'] != "") {
					$files = explode(", ", $post['files']);
					array_pop($files);
					foreach($files as $file) {
						if (!unlink($_SERVER['DOCUMENT_ROOT']."/lib/files/".$file)) {
							echo "Could not delete file.";
							die();
						}
					}
				}
				
				$sql = "DELETE FROM posts WHERE id=$id";
				if (!$db->query($sql)) {
					echo "Could not delete post";
					die();
				} else {
					echo "Post deleted.";
					echo "<script>setTimeout(document.location.href = '/feed/', 5000);</script>";
				}
			}
		}
		
		// UPLOAD
		if ($_POST['mode'] == "upload") {
			$upload_dir = $_SERVER['DOCUMENT_ROOT']."/lib/up/";
			foreach($_FILES['file']['name'] as $key=>$val){
				$path_parts = pathinfo($_FILES['file']['name'][$key]);
				$extension = $path_parts['extension'];
				
				if ($extension != "") {			
					$file_name = $_FILES['file']['name'][$key];
					$target_path = $upload_dir . $file_name;
					
					$i = 1;
					while (file_exists($target_path)) {
						$new_filename = pathinfo($file_name, PATHINFO_FILENAME) . '_' . $i . '.' . pathinfo($file_name, PATHINFO_EXTENSION);
						$target_path = $upload_dir . $new_filename; // update to use $new_filename instead of $file_name
						$i++;
					}
					
					if(!move_uploaded_file($_FILES['file']['tmp_name'][$key], $target_path)){
						echo("Failed to upload ".$file_name);
					} else {
						echo "<a href='/lib/up/".$file_name."' target=_blank><img src='/lib/up/".$file_name."'></a>";
					}
					
				}
			}
		}
		
		// EDIT PAGES
		if ($_POST['mode'] == "page") {
			
			function stripTags($input) {
				$input = preg_replace('/<\?php.*?\?>/s', '', $input);
				$input = preg_replace('/<script\b[^>]*>(.*?)<\/script>/is', '', $input);
				return $input;
			}

			$content = stripTags($_POST['content']);
			
			$page = $_POST['page'];
			
			if ($_POST['page'] != '') {
				if (!file_put_contents($_SERVER['DOCUMENT_ROOT']."/lib/tpl/".$page."/".$page.".tpl", $content)) {
					echo "Could not update page.";
					die();
				}
			}
			
			echo "Page updated.";
		}
		
		// SETTINGS	
		if ($_POST['mode'] == "settings") {
			if ($_POST['login'] == '') { echo "You need a login name."; die(); }
			if ($_POST['username'] == '') { echo "You need a username."; die(); }
			if ($_POST['sitename'] == '') { echo "You need to name your site."; die(); }
			if ($_POST['password1'] != $_POST['password2']) { echo "Password mismatch."; die(); }

			$upload_dir = $_SERVER['DOCUMENT_ROOT']."/lib/";
			$path_parts = pathinfo($_FILES['file']['name']);
			$extension = $path_parts['extension'];
			
			if ($extension != "") {
				$file_name = "avatar.png";
				$target_path = $upload_dir . $file_name;
				if(!move_uploaded_file($_FILES['file']['tmp_name'], $target_path)){
					echo("Failed to upload ".$file_name);
					die();
				}
			}
			
			$login = validate($_POST['login']);
			$username = validate($_POST['username']);
			$sitename = validate($_POST['sitename']);
			$sql = "UPDATE users SET login='$login', username='$username', sitename='$sitename'";
			if (!$db->query($sql)) {
				echo("Could not change password.");
				die();
			}
			
			if ($_POST['password1'] != '') {	
				$password = password_hash($_POST['password1'], PASSWORD_DEFAULT);
				$sql = "UPDATE users SET password='$password'";
				if (!$db->query($sql)) {
					echo("Could not change password.");
					die();
				}
			}
			
			echo "Settings updated.";
			die();
			
		}
		
	}
		
	exit();

?>