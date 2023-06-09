<?php
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	if ($result->num_rows > 0) {
	  $userdata = $result->fetch_assoc();
	}
	
	$url = explode("/", $_SERVER['REQUEST_URI']);
	$addr = $url[1];
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
?>

<br>
<?php 
	if ($loggedin == true) {
		echo "<span style='float: right; position: relative; right: -64px; height: 0px;'>
			<a href='/admin/edit/".$postdata['slug']."/'><i class='fas fa-edit'></i></a> &nbsp;
			<a href='/admin/delete/".$postdata['slug']."/'><i class='fas fa-trash'></i></a>
		</span>";
	}
?>
<div class="timeline">
	
	<img src="/lib/css/img/glyph.png" style="max-width: 32px; margin-left: -8px; margin-right: 8px; margin-bottom: -24px; position: relative; top: -4px;"> 
	<a href="/feed/">&laquo; Back to feed</a>	
	
	<span>
		<?php if ($next != 0) { ?>
			<a href="/<?=$next?>/" style="float: right; font-size: 16pt;">&raquo;</a>
		<?php } ?>
		<span style="float: right;">...</span>
		<?php if ($prev != 0) { ?>
			<a href="/<?=$prev?>/" style="float: right; font-size: 16pt;">&laquo;</a>
		<?php } ?>
		
	</span>
	
	<br><br><br><br>
	
	<div class="post-wrapper">
		<div class="post" style="position: relative; left: 24px;">
			<p>
				<div class="userinfo" style="width: calc(100% - 48px);">
					<img src="/lib/avatar.png" class="avatar">
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
	</div>
	
</div>
<br><br>

<div style="margin-bottom: -16px;"></div>

<script src="/lib/js/green-audio-player.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		GreenAudioPlayer.init({
			selector: '.player-with-download',
			stopOthersOnPlay: true,
			showDownloadButton: true,
			enableKeystrokes: true
		});
	});
</script>