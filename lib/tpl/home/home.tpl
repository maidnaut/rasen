<?php
	$posts = array();

	$query = "SELECT * FROM posts WHERE hidden='0' ORDER BY id DESC";
	$result = $db->query($query);
	if ($result->num_rows > 0) {
		$postdata = $result->fetch_all();
		foreach($postdata as $post) {
			if(preg_match('(png|gif|jpg|jpeg)', $post[5]) === 1) {
				array_push($posts, $post);
			}
		}
	}
	
	$img = array();
	$link = array();
	foreach($posts as $post) {
		$files = explode(", ", $post[5]);
		array_pop($files);
		array_push($img, $files[0]);
		array_push($link, $post[2]);
	}
?>

<div class="header">
	ｌｕｍｉｎｅｓｃｅｎｃｅ ｉｎｔｅｒｆａｃｅ <br><br>
	<div class="small">０００░▒▓ｌｏｇ ｏｆ ｂｉｌｅｘｔｈ； ｄｉｇｉｔａｌ ｓｈｒｉｎｅ ｍａｉｄｅｎ ▓▒░ ７７７</div>
</div>

<br>

<div class="slideshow-container">

<div class="mySlides fade">
  <a href="/<?=$link[0]?>/"><img src="/lib/files/<?=$img[0]?>" style="width:100%"></a>
</div>

<div class="mySlides fade">
  <a href="/<?=$link[1]?>/"><img src="/lib/files/<?=$img[1]?>" style="width:100%"></a>
</div>

<div class="mySlides fade">
  <a href="/<?=$link[2]?>/"><img src="/lib/files/<?=$img[2]?>" style="width:100%"></a>
</div>

<div class="mySlides fade">
  <a href="/<?=$link[3]?>/"><img src="/lib/files/<?=$img[3]?>" style="width:100%"></a>
</div>

<div class="mySlides fade">
  <a href="/<?=$link[4]?>/"><img src="/lib/files/<?=$img[4]?>" style="width:100%"></a>
</div>

<a class="prev" onclick="plusSlides(-1)">❮</a>
<a class="next" onclick="plusSlides(1)">❯</a>

</div>
<br>

<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span> 
  <span class="dot" onclick="currentSlide(4)"></span> 
  <span class="dot" onclick="currentSlide(5)"></span> 
</div>

<script>
let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

setInterval ( function() { 
     showSlides(slideIndex += 1)
 }, 5000);

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
</script>

<br>

<div class="grid-container">
	<a href="/feed/games/"><div class="grid"><i class="fa-solid fa-gamepad"></i> &nbsp; Games</div></a>
	<a href="/feed/art/"><div class="grid"><i class="fa-solid fa-paintbrush"></i> &nbsp; Art</div></a>
	<a href="/feed/music/"><div class="grid"><i class="fa-solid fa-music"></i> &nbsp; Music</div></a>
	<a href="/feed/text/"><div class="grid"><i class="fa-solid fa-book"></i> &nbsp; Blog</div></a>
	<a href="/license/"><div class="grid"><i class="fa-solid fa-scale-unbalanced-flip"></i> &nbsp; License</div></a>
	<a href="/archive/"><div class="grid"><i class="fa-solid fa-file-zipper"></i> &nbsp; Archive</div></a>
</div>

<div class="usagi">
	<img src="/lib/css/img/usagi.gif">
</div>

<br>