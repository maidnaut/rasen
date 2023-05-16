<div class="c" style="margin-top: -32px;">
	<form class="admin-form" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
		
		<div class="form-cell">Upload File</div>
		<div class="form-cell"><input type="file" name="file[]" id="file" multiple></div>
		
		<div class="form-cell">&nbsp;</div>
		<div class="form-cell"><input type="submit" value="Upload!"></div>
		<input type="hidden" name="mode" value="upload">
	</form>
	<div class="response"></div>
</div>

<?php
	$files = scandir('./lib/files');
	foreach (new DirectoryIterator('./lib/up') as $fileInfo) {
		if($fileInfo->isDot()) continue;
		echo "<a href='/lib/up/".$fileInfo->getFilename()."' target=_blank><img src='/lib/up/".$fileInfo->getFilename()."' style='width: 100px; height: 100px; object-fit: cover;'></a>";
	}
?>

<br><br>

<script>

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
</script>