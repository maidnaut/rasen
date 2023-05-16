<?php
	$url = explode("/", $_SERVER['REQUEST_URI']);
	$addr = $url[1];
	$sub = $url[3];
	
	$query = "SELECT * FROM posts WHERE slug='$sub'";
	$result = $db->query($query);
	if ($result->num_rows <= 0) {
		header("Location: /404/");
	}
	
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	if ($result->num_rows > 0) {
	  $userdata = $result->fetch_assoc();
	}
	
	$url = explode("/", $_SERVER['REQUEST_URI']);
	$addr = $url[3];
	$query = "SELECT * FROM posts ORDER BY id DESC";
	$result = $db->query($query);
	if ($result->fetch_all()) {
		foreach ($result as $row) {
			if ($row['slug'] == $addr) {
				
				$postdata = $row;
				$files = explode(", ", $postdata['files']);
				array_pop($files);

				$next = getSlug($db, $row['id'], -1);
				$prev = getSlug($db, $row['id'], 1);
				
				break;
				
			}
		}
	}
	
	$id = $postdata['id'];
?>

<br>

<div style="width: 100%; text-align: center;">
	Delete this post?<br><br>
	<form class="form" action="" method="post">
		<input type="submit" value="Yes" name="yes">
		&nbsp;-&nbsp;
		<input type="button" value="No" onclick="window.location.href = '/<?=$postdata['slug']?>/';">
		<input type="hidden" name="id" value="<?=$id?>">
		<input type="hidden" name="mode" value="delete">
	</form>
</div>

<div class="timeline">
	
	<br><br><br>
	
	<div class="post-wrapper">
		<div class="post" style="position: relative; left: 24px;">
			<p>
				<div class="userinfo" style="width: calc(100% - 48px);">
					<img src="<?=$userdata['avatar']?>" class="avatar">
					<span class="posttitle"><?=$postdata['title']?></span>
					<span style="position: relative; top: 24px;" class="postdate" title="<?=date('H:i m/d/Y', $postdata['postdate'])?>"><?=fuzzy_time($postdata['postdate'])?></span>
					
				</div>
				<?php if($postdata['content'] != '') { ?>
					<br>
					<div style="padding-right: 48px;"><?=parseText($postdata['content'])?></div>
				<?php } ?>
			</p>
			<?php if ($postdata['files'] != "") {
				echo "<hr>";
				
				
				// Download
				foreach($files as $file) {
					if(preg_match('(zip|rar|7z|exe)', $file) === 1) {
						echo '<br><div class="download"><a target=_blank href="/lib/files/'.$file.'"><i class="fa fa-download" aria-hidden="true"></i>&nbsp; DOWNLOAD: '.$file.'</a></div>';
					}
				}
				
				// Audio
				foreach($files as $file) {
					if(preg_match('(mp3|wav|ogg)', $file) === 1) {
						echo '<div class="ready-player-'.$postdata['id'].' player-with-download" style="position: relative; left: -16px;">';
							echo '<audio crossorigin preload="none">';
								echo '<source src="/lib/files/'.$file.'" type="audio/mpeg">';
							echo '</audio>';
						echo '</div>';
					}
				}
				
				// Images
				foreach($files as $file) {
					if(preg_match('(png|gif|jpg|jpeg)', $file) === 1) {
						echo '<a target=_blank href="/lib/files/'.$file.'"><img src="/lib/files/'.$file.'" style="width: calc(100% - 48px); height: auto; margin-bottom: 16px;"></a>';
					}
				}
				
			} ?>
			<br>
		</div>
		<div class="response"></div>
	</div>
	
</div>
<br><br>

<div style="margin-bottom: -16px;"></div>
<script>
  $(document).ready(function() {
    $('.form').submit(function(e){
		e.preventDefault();
		$.ajax({
			url: '/lib/inc/async.php',
			data: $(".form").serialize(),
			method: 'POST',
			success: function(response){
				$(".response").empty().append(response);
			}
		});
    });
  });
</script>