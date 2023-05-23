<html>
	<head>
		<link rel="stylesheet" href="/lib/css/skeleton.css?"></link>
		<link rel="stylesheet" href="/lib/css/luminal.css?"></link>
		<link rel="stylesheet" href="/lib/css/green-audio-player.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		<title>Luminesence Interface</title>
		<link rel="icon" href="/lib/css/img/favicon.png">
		<script src="/lib/js/green-audio-player.js"></script>
	</head>
	<body>
		<div class="nav">
			<div class="container">
				<div class="left">
					<a href="/home/"><?=$sitename?></a>
				</div>
				<div class="right">
					<a href="/registry/">Registry</a>
					<a target=_blank href="https://twitter.com/angelicbile"><img src="/lib/css/img/twitter.svg"></a>
				</div>
			</div>
		</div>
		
		<div id="scroll-to-top">&#9650; Scroll Up <img src="/lib/css/img/heart.png" style="margin-bottom: -8px; margin-top: -32px;"></div>
		<script>
			window.addEventListener('scroll', function() {
				var scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
				if (scrollPosition > 200) {
					document.getElementById('scroll-to-top').style.display = 'block';
				} else {
					document.getElementById('scroll-to-top').style.display = 'none';
				}
			});
			document.getElementById('scroll-to-top').addEventListener('click', function() {
				window.scrollTo({
					top: 0,
					behavior: 'smooth'
				});
			});
		</script>
		
		<div class="container">
			<div class="content">