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

	<div class="post-wrapper" style="padding: 16px;">
		<form class="admin-form" name="registry" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
			
			<div class="form-cell">Registry</div>
			<div class="form-cell">
				<textarea name="content" id="content"><?php echo ltrim(file_get_contents("./lib/tpl/registry/registry.tpl")); ?></textarea>
			</div>
			
			<input type="hidden" name="mode" value="page">
			<input type="hidden" name="page" value="registry">
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="submit" value="Update Pages"></div>
		</form>
	</div>
	
	<br><br><br><br>

	<div class="post-wrapper" style="padding: 16px;">
		<form class="admin-form" name="license" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
			
			<div class="form-cell">License</div>
			<div class="form-cell">
				<textarea name="content" id="content"><?php echo ltrim(file_get_contents("./lib/tpl/license/license.tpl")); ?></textarea>
			</div>
			
			<input type="hidden" name="mode" value="page">
			<input type="hidden" name="page" value="license">
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="submit" value="Update Pages"></div>
		</form>
	</div>
	
	<br><br><br><br>

	<div class="post-wrapper" style="padding: 16px;">
		<form class="admin-form" name="archive" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
			
			<div class="form-cell">Archive</div>
			<div class="form-cell">
				<textarea name="content" id="content"><?php echo ltrim(file_get_contents("./lib/tpl/archive/archive.tpl")); ?></textarea>
			</div>
			
			<input type="hidden" name="mode" value="page">
			<input type="hidden" name="page" value="archive">
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="submit" value="Update Pages"></div>
		</form>
	</div>
	
	<br><br><br>
			
	<div class="response"></div>
		
</div>
	
<br>
<script>
	$(document).ready(function() {
		$('.show').click(function() {
			$('.hidden').toggle(); // Toggle the visibility of the div with class "c"
		});
	});
	
	function post(formData, append) {
		jQuery.ajax({
			url: '/lib/inc/async.php',
			data: formData,
			cache: false,
			contentType: false,
			processData: false,
			method: 'POST',
			type: 'POST', // For jQuery < 1.9
			success: function(response){				
				$(append).prop('disabled', true);
				$(append).val(response);
				
				setInterval(function() {
					$(append).prop('disabled', false).val('Update page')
				}, 5000);
			}
		});
	}
	
	$('.admin-form').submit(function(e){
		e.preventDefault();
		var formData = new FormData($(this)[0]);
		
		var append = $(this).find('input[type="submit"]');

		post(formData, append);
	});
</script>