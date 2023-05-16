<?php
	include_once($_SERVER['DOCUMENT_ROOT']."/lib/inc/db.php");
	include_once($_SERVER['DOCUMENT_ROOT']."/lib/inc/functions.php");
	error_reporting(E_ALL);
	$start = $_POST['start'];
	$limit = $_POST['limit'];
	
	$postdata = array();
	$query = "SELECT * FROM posts ORDER BY id DESC LIMIT $start, $limit";
	$result = $db->query($query);
	if ($result->num_rows > 0) {
		$postdata = $result->fetch_all();
	}
	foreach($postdata as $post) { ?>
		<div class="post-wrapper" style="margin-bottom: 48px; height: 32px;">
			<div class="post" style="width: calc(100% - 32px); position: relative; top: -28px; left: 16px;">
				<a href="/<?=$post[2]?>/">
					<p>
						<div class="userinfo">
							<?php if ($post[6] == 1) { echo '<i class="fa-solid fa-lock" style="position: relative; top: 15px; margin-right: 8px;"></i>'; } ?>
							<span class="posttitle"><?=$post[1]?></span>
							<span class="postdate" style="position: relative; top: 20px;" title="<?=date('H:i m/d/Y', $post[3])?>"><?=fuzzy_time($post[3])?></span>
						</div>
					</p>
				</a>
			</div>
		</div>
<?php } ?>