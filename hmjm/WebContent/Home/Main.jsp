<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>쉘위?- 나만의 튜터를 만들어보세요.</title>
<style>
* {
	box-sizing: border-box
}

#main {
	font-family: Verdana, sans-serif;
	margin: 0
}

.mySlides {
	display: none
}

img {
	vertical-align: middle;
}

/* Slideshow container */
.slideshow-container {
	width: 1920px;
	height: 450px;
	overflow-x: hidden;
	overflow-y: hidden;
	position: relative;
	margin: auto;
}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
	user-select: none;
}

/* Position the "next button" to the right */
.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* The dots/bullets/indicators */
.dot {
	cursor: pointer;
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

.active, .dot:hover {
	background-color: #717171;
}

/* Fading animation */
.fade {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 1.5s;
	animation-name: fade;
	animation-duration: 1.5s;
}

@
-webkit-keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
	.prev, .next, .text {
		font-size: 11px
	}
}
</style>
</head>
<body id="main">
	<%--상단 카테고리bar: header --%>
	<jsp:include page="Header.jsp" />
	


	<div class="slideshow-container">
		<div class="mySlides fade">
			<a href="#"><img src="/WebContent/Images/main1.jpg" style="width: 100%"></a>
		</div>

		<div class="mySlides fade">
			<a href="#"><img src="/WebContent/Images/main2.jpg" style="width: 100%"></a>
		</div>

		<div class="mySlides fade">
			<a href="#"><img src="/WebContent/Images/main3.jpg" style="width: 100%"></a>
		</div>

		<div class="mySlides fade">
			<a href="#"><img src="/WebContent/Images/main4.jpg" style="width: 100%"></a>
		</div>

		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>
	</div>

	<br>
	<div style="text-align: center;">
		<span class="dot" onclick="currentSlide(1)"></span> <span class="dot"
			onclick="currentSlide(2)"></span> <span class="dot"
			onclick="currentSlide(3)"></span> <span class="dot"
			onclick="currentSlide(4)"></span>
	</div>
	<script>
		var slideIndex = 1;
		showSlides(slideIndex);

		function plusSlides(n) {
		  showSlides(slideIndex += n);
		}

		function currentSlide(n) {
		  showSlides(slideIndex = n);
		}

		function showSlides(n) {
  		var i;
 		 var slides = document.getElementsByClassName("mySlides");
 		 var dots = document.getElementsByClassName("dot");
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
	<%--중간 카테고리bar: category --%>
	<jsp:include page="Category.jsp" />

	<%--footer --%>
	<jsp:include page="Footer.jsp" />
	

</body>
</html>
