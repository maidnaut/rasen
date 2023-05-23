<?php
	include_once($_SERVER['DOCUMENT_ROOT']."/lib/inc/db.php");
	include_once($_SERVER['DOCUMENT_ROOT']."/lib/inc/functions.php");
	error_reporting(E_ALL);
	$start = $_POST['start'];
	$limit = $_POST['limit'];
	$sub = $_POST['sub'];
	
	$sub = explode("/", $sub);
	$sub = $sub[4];
	
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	if ($result->num_rows > 0) {
	  $userdata = $result->fetch_assoc();
	}
	
	$postdata = array();
	$query = "SELECT * FROM posts WHERE hidden = '0' ORDER BY id DESC LIMIT $start, 7";
	$result = $db->query($query);
	
	$posts = array();
	if ($result->num_rows > 0) {
		$postdata = $result->fetch_all(MYSQLI_ASSOC);
		
		switch ($sub) {
			case 'art':
				foreach($postdata as $post) {
					if(preg_match('(png|gif|jpg|jpeg)', $post['files']) === 1) {
						array_push($posts, $post);
					}
				}
				break;
				
			case 'music':
				foreach($postdata as $post) {
					if(preg_match('(mp3|wav|ogg)', $post['files']) === 1) {
						array_push($posts, $post);
					}
				}
				break;
				
			case 'games':
				foreach($postdata as $post) {
					if(preg_match('(zip|rar|7z|exe)', $post['files']) === 1) {
						array_push($posts, $post);
					}
				}
				break;
				
			case 'text':
				foreach($postdata as $post) {
					if(preg_match('(png|gif|jpg|jpeg|mp3|wav|ogg|zip|rar|7z|exe)', $post['files']) === 0) {
						array_push($posts, $post);
					}
				}
				break;
			
			default:
				foreach($postdata as $post) {
					array_push($posts, $post);
				}
				break;
		}
		$posts = array_unique($posts, SORT_REGULAR);
	}
	
	foreach($posts as $post) { ?>
		<div class="checkpoint">
			<div class="post" style="width: calc(100% - 32px); padding-top: 0px;">
				<a href="/<?=$post['slug']?>/">
					<p>
						<div class="userinfo">
							<img src="/lib/avatar.png" class="avatar">
							<span class="posttitle"><?=$post['title']?></span>
							<span class="postdate" title="<?=date('H:i m/d/Y', $post[3])?>"><?=fuzzy_time($post['postdate'])?></span>
						</div>
					</p>
				</a>
				<?php if ($post['files'] !== "") {
					$files = explode(", ", $post['files']);
					array_pop($files);
					
					// Image Grid
					echo "<div class='image-grid'>";
					foreach($files as $file) {
						if(preg_match('(png|gif|jpg|jpeg)', $file) === 1) {
							echo '<a href="/'.$post['slug'].'/"><img src="/lib/files/'.$file.'"></a>';
						}
					}
					echo "</div><br>";
					
					// Audio
					foreach($files as $file) {
						if(preg_match('(mp3|wav|ogg)', $file) === 1) {
							echo '<a href="/'.$post['slug'].'/"><div class="download"><i class="fa-solid fa-music"></i> '.$file.'</div></a>';
						}
					}
					
					// Archives
					foreach($files as $file) {
						if(preg_match('(zip|rar|7z|exe)', $file) === 1) {
							echo '<a href="/'.$post['slug'].'/"><div class="download"><i class="fa fa-download" aria-hidden="true"></i> &nbsp; '.$file.'</div></a>';
						}
					}
				} ?>
			</div>
		</div>
<?php } ?>