<?php

	class Model {
	
		public $addr;
		public $inc;
		
		public function minify($inc) {
		
			ob_start();
			extract($GLOBALS, EXTR_REFS | EXTR_SKIP);
			
			include("lib/tpl/globals/header.tpl");
			include($inc);
			include("lib/tpl/globals/footer.tpl");
			
			$inc = ob_get_contents();
			ob_end_clean();
			
			//$inc = preg_replace('/\s\s+/', ' ', $inc);
			//$inc = str_replace(array("\n", "\r"), "", $inc);
			return $inc;
		 
		}
      
		public function getPage($addr) {
			include("db.php");
			$query = "SELECT * FROM posts WHERE slug='".$addr."'";
			$result = $db->query($query);
			$row = $result->fetch_assoc();
			if ($addr == $row['slug']) {
				$inc = "lib/tpl/post/post.tpl";
			} else {	
				if (file_exists("lib/tpl/".$addr."/".$addr.".php")) {
					$inc = "lib/tpl/".$addr."/".$addr.".php";
				} else if (file_exists("lib/tpl/".$addr."/".$addr.".tpl")) {
					$inc = "lib/tpl/".$addr."/".$addr.".tpl";
				} else {
					if ($addr != "404") {
						header("Location: /404/");
					}
				}
			}
			
			return $this->minify($inc);
			
		}
		
	}
	
?>