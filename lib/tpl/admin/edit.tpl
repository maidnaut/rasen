<?php
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
?>

<div class="c">

	<div style="width: 100%; text-align: center;">
		Edit
	</div>
	
	<br>
		
		<form class="admin-form" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
			<div class="form-cell">Post Title</div>
			<div class="form-cell"><input name="title" id="title" value="<?=$postdata['title']?>"></div>
			
			<div class="form-cell">Post Content</div>
			<div class="form-cell"><textarea name="content" id="content"><?=$postdata['content']?></textarea></div>
			
			
			
			<div class="form-cell">Images</div>
			
			<div class="form-cell">
				<?php
					if ($postdata['files'] != "") {
						echo "<div class='admin-image-grid'>";
							foreach($files as $file) {
								echo "<div class='form-cell'><img class='admin-img' src='/lib/files/".$file."'></div>";
							}
						echo "</div>";
					} else {
						echo "No images";
					}
				?>
			</div>
			
			<div class="form-cell">Hidden</div>
			<div class="form-cell">
				<label class="switch">
					<input type="checkbox" name="hidden" <?php echo ($postdata['hidden'] == 1 ? 'checked' : '');?>>
					<span class="slider"></span>
				</label>
			</div>
			
			<div class="form-cell">&nbsp;</div>
			<div class="form-cell"><input type="submit" value="Edit"></div>
			
			<input type="hidden" name="mode" value="edit">
			<input type="hidden" name="original_slug" value="<?=$postdata['slug']?>">
		</form>
		<div class="response"></div>
</div>

<script>
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
			}
		});
	}
	
	$('.admin-form').submit(function(e){
		e.preventDefault();
		var formData = new FormData($(this)[0]);
		post(formData);
	});
</script>