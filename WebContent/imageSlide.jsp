<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지슬라이드 테스트</title>
<style media="screen">
	*{
		margin: 0; padding: 0;
	}
	.slide{
		width: 1000px;
		height: 500px;
		overflow: hidden;
		position: relative;
		margin: 0 auto;
	}
	.slide ul{
		width: 9000px;
		position: absolute;
		top:0;
		left:0;
		font-size: 0;
	}
	.slide ul li{
		display: inline-block;
	}
	#back{
		position: absolute;
		top: 250px;
		left: 0;
		cursor: pointer;
		z-index: 1;
	}
	#next{
		position: absolute;
		top: 250px;
		right: 0;
		cursor: pointer;
		z-index: 1;
	}
	.images{
		width:1000px;
		height:500px;
	}
</style>

</head>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var imgs;
	var img_length = 1000;
	var img_count;
	var img_position = 1;
	
	imgs = $(".slide ul");
	img_count = imgs.children().length;
	console.log("img_count : " + img_count);
	var frontToEnd = (img_count-1) * img_length;
// 	console.log("frontToEnd : " + frontToEnd);
	
	//버튼을 클릭했을 때 함수 실행
	$('#back').click(function () {
		back();
	});
	$('#next').click(function () {
		next();
	});
	
	function back() {
		if(1<img_position){
			imgs.animate({
				left:'+=' + img_length + 'px'
			});
			img_position--;
			console.log(img_position);
		}else if(1==img_position){
			imgs.animate({
				left:'-=' + frontToEnd + 'px'
			});
			img_position = 6;
			console.log(img_position);
		}	
	}
	function next() {
		if(img_count>img_position){
			imgs.animate({
				left:'-=' + img_length + 'px'
			});
			img_position++;
			console.log(img_position);
		}else if(img_count == img_position){
			imgs.animate({
				left:'+=' + frontToEnd + 'px'
			});
			img_position = 1;
			console.log(img_position);
		}
	}
});
</script>
<style>
	
</style>

<body>
	<div class="slide">
		<img id="back" src="resources/images/btn_prev.png" alt="" width="50">
		<ul>
			<li><img class="images" src="resources/images/pexels-photo-1.jpeg" alt="" ></li>
			<li><img class="images" src="resources/images/pexels-photo-2.jpeg" alt="" ></li>
			<li><img class="images" src="resources/images/pexels-photo-3.jpeg" alt="" ></li>
			<li><img class="images" src="resources/images/pexels-photo-4.jpeg" alt="" ></li>
			<li><img class="images" src="resources/images/pexels-photo-5.jpeg" alt="" ></li>			
			<li><img class="images" src="resources/images/pexels-photo-9.jpeg" alt="" ></li>
		</ul>
		<img id="next" src="resources/images/btn_next.png" alt="" width="50">
	</div>	
</body>
</html>