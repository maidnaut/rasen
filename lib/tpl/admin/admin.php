<?php if ($loggedin == false) { header("Location: /404/"); } ?>

<br>
<div class="timeline">
	<div style="margin-left: -8px; width: 100%;">
		<img src="/lib/css/img/glyph.png" style="max-width: 32px; margin-right: 8px; margin-bottom: -24px; position: relative; top: -4px;"> 
		<span style="width: 100%; text-align: center;">
			<a href="/admin/posts/">Posts</a> &nbsp;-&nbsp;
			<a href="/admin/pages/">Pages</a> &nbsp;-&nbsp;
			<a href="/admin/upload/">Upload</a> &nbsp;-&nbsp;
			<a href="/admin/settings/">Settings</a> <br>
		</span>
	</div>

	<?php
		$url = explode("/", $_SERVER['REQUEST_URI']);
		
		switch ($url[2]) {
				
			case "posts":
				include("posts.tpl");
				break;
			
			case "pages":
				include("pages.tpl");
				break;
			
			case "upload":
				include("upload.tpl");
				break;
			
			case "settings":
				error_reporting(E_ALL);
				include_once($_SERVER['DOCUMENT_ROOT']."/lib/inc/db.php");
				$my = $db->query("SELECT * FROM users")->fetch_array();
				include("settings.tpl");
				break;
			
			case "edit":
				include("edit.tpl");
				break;
			
			case "delete":
				include("delete.tpl");
				break;
				
			default:
				header("Location: /admin/posts/");
				break;
		}
	?>

</div>