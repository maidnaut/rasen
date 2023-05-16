<?php
	$query = "SELECT * FROM users";
	$result = $db->query($query);
	$row = $result->fetch_assoc();
	if (session_id() != $row['session']) {
		header("Location: /404/");
		exit();
	}
?>
<br>

<div class="c">

	<div class="post-wrapper show" style="background: url('/lib/css/img/header.gif') repeat top left; padding: 8px; cursor: pointer;">
		[ + New Post + ]
	</div>

	<div class="hidden" style="display: none;">
	
	<br>
		
		<form class="admin-form" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
			<div class="form-cell">Post Title</div>
			<div class="form-cell"><input name="title" id="title"></div>
			
			<div class="form-cell">Post Content</div>
			<div class="form-cell"><textarea name="content" id="content" placeholder="Insert post here"></textarea></div>
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="file" name="file[]" id="file" multiple></div>
			
			<div class="form-cell">Hidden</div>
			<div class="form-cell">
				<label class="switch">
					<input type="checkbox" name="hidden" value="0">
					<span class="slider"></span>
				</label>
			</div>
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="submit" value="Post!"></div>
			
			<input type="hidden" name="mode" value="post">
		</form>
		<div class="response"></div>
	</div>
</div>

<br><br>

<div id="postList">
	<?php
		$_POST['start'] = 0;
		$_POST['limit'] = 10;
		$_POST['sub'] = "https://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
		include("getposts.php");
	?>
</div>
	
<br>
<script>
	$(document).ready(function() {
		$('.show').click(function() {
			$('.hidden').toggle(); // Toggle the visibility of the div with class "c"
		});
	});

	$("#files").on("change", function() {
		if ($("#files")[0].files.length > 4) {
			alert("You can select only 4 files.");
			$("#files").empty();
		}
	});
	
	function post(formData) {
		jQuery.ajax({
			url: '/lib/inc/async.php',
			data: formData,
			cache: false,
			contentType: false,
			processData: false,
			method: 'POST',
			type: 'POST', // For jQuery < 1.9
			success: function(response){
				$(".response").empty().append(response);
				$( '.admin-form' ).each(function(){
					this.reset();
				});
			}
		});
	}
	
	$('.admin-form').submit(function(e){
		e.preventDefault();
		var formData = new FormData($(this)[0]);
		post(formData);
	});
	
	var start = 7;
	var limit = 7;

	$(document).ready(function() {
		getData();
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
			url: '/lib/tpl/admin/getposts.php',
			type: 'POST',
			data: {start:start, limit:limit},
			success: function(response) {
				start += limit;
				$('#postList').append(response);
			}
		});
	}
</script>