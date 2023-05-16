<?php
	function fuzzy_time($timestamp) {
		$current_time = time();
		$diff = $current_time - $timestamp;

		if ($diff < 60) {
			return 'just now';
		}

		$intervals = array(
			1 => array('year', 31536000),
			array('month', 2592000),
			array('week', 604800),
			array('day', 86400),
			array('hour', 3600),
			array('minute', 60)
		);

		$counter = 0;

		foreach ($intervals as $interval) {
			$seconds = $interval[1];
			if ($diff > $seconds) {
				$counter = round($diff / $seconds);
				break;
			}
		}

		if ($counter > 1) {
			return $counter . ' ' . $interval[0] . 's ago';
		} else {
			return $counter . ' ' . $interval[0] . ' ago';
		}
	}
	
	
				
	function getSlug($db, $id, $increment) {
		for ($i = 1; $i < 100; $i++) {
			$next = $id + $increment * $i;
			$query = "SELECT * FROM posts WHERE id=$next";
			$result = $db->query($query);
			if ($result && $result->num_rows > 0) {
				$row = $result->fetch_assoc();
				return $row['slug'];
			}
		}
		return 0;
	}
	
	function parseText($text) {
		$text = nl2br($text);
		
		$text = str_replace('[b]', '<strong>', $text);
		$text = str_replace('[/b]', '</strong>', $text);
		$text = str_replace('[i]', '<em>', $text);
		$text = str_replace('[/i]', '</em>', $text);
		$text = str_replace('[u]', '<u>', $text);
		$text = str_replace('[/u]', '</u>', $text);
		$text = str_replace('[center]', '<div style="text-align:center; margin-bottom: -16px;">', $text);
		$text = str_replace('[/center]', '</div>', $text);
		
		$text = preg_replace(
			'/\[img\](.*?)\[\/img\]/is',
			'<img src="$1">',
			$text
		);

		return $text;
	}
?>