<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="hmjm.bean.product.*"%>
<%@ page import="hmjm.bean.buy.*"%>
<%@ page import="hmjm.bean.tutor.*"%>
<%@ page import="hmjm.bean.classtime.*"%>
<%@ page import="hmjm.bean.classimg.*"%>
<%@ page import="java.util.List"%>
<%@ page import="oracle.net.aso.b"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>강의 상세페이지</title>
<style type="text/css">

body {
	min-width: 1000px;
	background-color: white;
}
.mySlides {display: none}
img {vertical-align: middle;}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 30%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}
/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 0.5s;
  animation-name: fade;
  animation-duration: 0.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}
/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
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
  background-color: rgba(0,0,0,0.8);
}

</style>
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
</head>

<%
		String id = (String) session.getAttribute("loginId");
	
		int num = Integer.parseInt(request.getParameter("p_num"));
		String pageNum = request.getParameter("pageNum");
		
		System.out.println("로그인아이디"+id);
		
		classtimeDAO time = classtimeDAO.getInstance();
		classtimeVO t = time.getClasstime(num);
	
		classimgDAO aa  = classimgDAO.getInstance();
		classimgVO bb = aa.getImg(num);
	//내수업인지 신청한 수업인지 구별하기 위해 불러오는 값..테스트중
		tutorDAO tu = tutorDAO.getInstance();
		tutorVO ee = tu.getMember(id);
		
		System.out.println("튜터정보**e**"+ee);
		
		buyDAO buyer = buyDAO.getInstance();
		buyVO b = buyer.getBuy(id);
		buyVO c =buyer.getBuy3(id,num);//구매한 상품 신청 못하게
		System.out.println("구매정보**b**"+b);
		
		//System.out.println("구매한경우강의넘버**bbb**"+bbb);
		
		
	
		productDAO dbPro = productDAO.getInstance();
		productVO vo = dbPro.getProduct(num);
		productVO vc = dbPro.getProduct2(id,num);//등록한 상품 신청 못하게
		productVO vd = dbPro.getProduct4(id);
		
		
		
		//내가 등록한 강의 번호
		
		//System.out.println("등록한경우강의넘버가 아닌가보다**vv**"+vv);
		
		
		

		//사진 불러오기 할려고 했는데 이건 아닌 듯....미완성
		if (pageNum == null) { pageNum = "1"; }
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number=0;
		
		List classimgList = null;
		classimgDAO pic = classimgDAO.getInstance();
		count = pic.getClassimgCount(num);
		
		if (count > 0) {
			classimgList = pic.getClassimg(num,startRow, endRow);}	
%>

<body>
	<jsp:include page="/Home/header.jsp" />
	<jsp:include page="/SideMenu/sideMenu.jsp" />
	<div>
		<h1>강의 상세 페이지</h1>
		<p><%=vo.getP_num() %>:::::::::::::이거 강의번호를 신청할때 넘겨야한다
		</p>
		<br> 강의제목::::::::<%=vo.getP_classname() %><br>
		강사소개::::::::<%=vo.getP_self() %><br>
		카테고리::::::::<%=vo.getP_category() %><br>
		<input type="hidden" name="p_email"
			value="<%=vo.getP_email()%>" />
		강사이메일:::::::: <a href="#"
			onClick="window.open('/hmjm/Message/messageWriteForm.jsp?p_email=<%=vo.getP_email()%>&p_num=<%=num%>',
		'_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,directories=no,width=650,height=660')">
			<%=vo.getP_email() %></a>
		<br>
		<br>
<%--수업가능시간 --%>
		<div>
			수업가능시간::::::::
			<%if(t == null){ %>
			<h1>시간 미등록 튜터</h1>
			<%}else{ %>
			<%if(t.getCt_mon()==null){%>
			<%}else{%>
			월:
			<%=t.getCt_mon()%>
			<%}%>

			<%if(t.getCt_tue()==null){%>
			<%}else{%>
			화:
			<%=t.getCt_tue()%>
			<%}%>

			<%if(t.getCt_wed()==null){%>
			<%}else{%>
			수:
			<%=t.getCt_wed()%>
			<%}%>

			<%if(t.getCt_thu()==null){%>
			<%}else{%>
			목:
			<%=t.getCt_thu()%>
			<%}%>

			<%if(t.getCt_fri()==null){%>
			<%}else{%>
			금:
			<%=t.getCt_fri() %>
			<%}%>

			<%if(t.getCt_sta()==null){%>
			<%}else{%>
			토:
			<%=t.getCt_sta()%>
			<%}%>

			<%if(t.getCt_sun()==null){%>
			<%}else{%>
			일:
			<%=t.getCt_sun() %>
			<% %>

			<%if(t.getCt_day()==null){%>
			<%}else{%>
			데이수업<%=t.getCt_day()%>
			<%}%>
			<%}%>
			<%}%>

		</div>
		<br>
		<% if(bb==null){%>
		<h1>사진 미등록 튜터</h1>
		<%}else{ %>

		<%if(count == 0){%>
		test
		<%}else{%>
		
		<% for(int i = 0 ; i < classimgList.size(); i++){
			classimgVO g = (classimgVO)classimgList.get(i);%>
			<div class="slideshow-container">
			<div class="mySlides fade">	
				<img src="/hmjm/Images/Classimg/<%=g.getCi_name()%>" style="width:35%">
			</div>
			
			</div>
		<%}%>
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>	
		<%}%>
		<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span> 
</div>
		<%}%>


		<br>

<%--신청하기 if문 --%>
<%
if(id!=null){
	if(ee!=null){
		if(vd!=null){
			if(vc!=null){%>
		내가 등록한글 <a href="/hmjm/Home/main.jsp"> 처음으로</a>
		<%}else{
					if(b!=null){
						if(c!=null){%>
		튜터o 구매한 강의 <a href="/hmjm/Home/main.jsp"> 처음으로</a>
		<%}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터 o
			구매이력 o 신청하기</a>
		<%}
			
							}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터o
			구매이력 x 신청하기</a>
		<%}
					
				}
			
		}else{
				if(b!=null){
					if(c!=null){%>
		튜터 o 판매x 구매한 강의 <a href="/hmjm/Home/main.jsp"> 처음으로</a>
		<%}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터 o
			판매x 구매이력 o 신청하기</a>
		<%}
			
					}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터o
			판매x 구매이력 x 신청하기 </a>
		<%}
			
				}
				
		}else{
				if(b!=null){
					if(c!=null){%>
		튜터x 구매한글
		<%}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터x
			구매이력o 신청하기</a>
		<%}
			
				}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>"> 튜터x
			구매이력 x 첫구매!</a>
		<%}	
			
			}
	}else{%>
		<a href="/hmjm/Talent/check.jsp?p_num=<%=vo.getP_num() %>">비로그인 신청</a>
		<%}


%>


		<br> <br>
	</div>
	<jsp:include page="/Review/review.jsp?p_num=<%=num%>" />
	<jsp:include page="/Home/footer.jsp" />
</body>
</html>