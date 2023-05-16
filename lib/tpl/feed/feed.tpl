<?php
	$url = explode("/", $_SERVER['REQUEST_URI']);
	$addr = $url[1];
	$sub = $url[2];
	if ($url[3] != '') {
		header("Location: /404/");
	}
	
	if (($sub != '') && (!in_array($sub, array("art", "music", "games", "text")))) {
		header("Location: /404/");
	}
?>

<br>

<div class="timeline">
	<div style="margin-left: -8px; width: 100%;">
		<img src="/lib/css/img/glyph.png" style="max-width: 32px; margin-right: 8px; margin-bottom: -24px; position: relative; top: -4px;"> 
		Sort by: &nbsp;
		<span style="width: 100%; text-align: center;">
			<a href="/feed/">All</a> &nbsp;-&nbsp;
			<a href="/feed/games/">Games</a> &nbsp;-&nbsp;
			<a href="/feed/art/">Art</a> &nbsp;-&nbsp;
			<a href="/feed/music/">Music</a> &nbsp;-&nbsp;
			<a href="/feed/text/">Blog</a> <br><br>
		</span>
	</div>
	
	<div id="postList">
		<?php
			$_POST['start'] = 0;
			$_POST['limit'] = 10;
			$_POST['sub'] = "https://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
			include("getposts.php");
		?>
	</div>
	
	...
	
</div>

<br>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		GreenAudioPlayer.init({
			selector: '.player',
			stopOthersOnPlay: true
		});

		GreenAudioPlayer.init({
			selector: '.player-with-download',
			stopOthersOnPlay: true,
			showDownloadButton: true,
			enableKeystrokes: true
		});

		GreenAudioPlayer.init({
			selector: '.player-with-accessibility',
			stopOthersOnPlay: true,
			enableKeystrokes: true
		});
	});
</script>

<script>
var start = 7;
var limit = 7;

$(document).ready(function() {
    getData(); // Call getData() to load the first 10 posts on page load
    $(window).scroll(function() {
        var scrollHeight = $('#postList')[0].scrollHeight;
        var scrollPosition = $('#postList').height() + $('#postList').scrollTop();
        if (scrollPosition >= scrollHeight - 100) {
            getData();
        }
    });
});

function getData() {
    $.ajax({
        url: '/lib/tpl/feed/getposts.php',
        type: 'POST',
        data: {start:start, limit:limit, sub:window.location.href},
        success: function(response) {
            start += limit;
            $('#postList').append(response);
        }
    });
}
</script>