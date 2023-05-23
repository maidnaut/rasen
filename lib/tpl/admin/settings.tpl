<div class="c" style="margin-top: -32px;">
	<form class="admin-form" action="" method="post" onsubmit="return post();" enctype="multipart/form-data">
		
		<div class="form-cell avatar"><img src="/lib/avatar.png?"></div>
		<div class="form-cell"><input type="file" name="file" id="file" multiple></div>
		
		<div class="form-cell">Login Name</div>
		<div class="form-cell">
			<input type="text" name="login" placeholder="Login Name" value="<?=$my['login']?>"> <br>
		</div>
		
		<div class="form-cell">Display Name</div>
		<div class="form-cell">
			<input type="text" name="username" placeholder="Display Name" value="<?=$my['username']?>"> <br>
		</div>
		
		<div class="form-cell">&nbsp;</div>
		<div class="form-cell">
			<input type="password" name="password1" placeholder="New Password"> <br>
			<input type="password" name="password2" placeholder="Verify Password"> <br>
		</div>


		
		<div class="form-cell">&nbsp;</div>
		<div class="form-cell">
			<hr>
		</div>
		
		
		<div class="form-cell">Website Name</div>
		<div class="form-cell">
			<input type="text" name="sitename" placeholder="Site Name" value="<?=$my['sitename']?>"> <br>
		</div>
		
		
		<div class="form-cell">&nbsp;</div>
		<div class="form-cell"><input type="submit" value="Update"></div>
		<input type="hidden" name="mode" value="settings">
	</form>
	<div class="response"></div>
</div>

<br><br>

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