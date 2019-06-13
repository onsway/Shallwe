<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="hmjm.bean.product.*"%>

<%	request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<link rel="stylesheet" href="/hmjm/css/bootstrap.min.css" />
<title>수업 등록</title>
<script language="javascript" src="script.js"></script>
<script language="javascript" type="text/javascript">
/*
    private int ci_num;			//고유넘버(순서를 위함)_시퀀스 
	private int ci_classnum;	//수업번호(p_num)	
	private String ci_img;		//이미지 경로  
 */	
 
	/*유효성 검사*/
	function writeSave() {
		var form = document.addClassimgForm;

		if (form.ci_img.value == "") {
			alert("하나 이상의 수업 사진을 등록 하세요.");
			form.ci_img.focus();
			return false;
		}
	}
	
</script>

<style>
input[type=number] {
	width: 80px;
}
</style>

</head>

<body>
	<jsp:include page="/Home/header.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">수업 사진 등록</h1>
		</div>
	</div>
	<div class="container">

		<%-- enctype="multipart/form-data" 파일이나 대용량 데이터 보낼때 데이터 전송 방식 --%>
		
		<form action="addClassimgPro.jsp" name="addClassimgForm" method="post"
									enctype="multipart/form-data">

			<div class="form-group row">
				<label class="col-sm-2">수업 사진 등록하기</label>
				<div class="col-sm-5">
					<input type="file" name="filename[]" class="form-control" multiple required />
				</div>
			</div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" value="사진 등록">&nbsp;&nbsp;&nbsp; <input
						type="reset" value="모든 내용 취소">
				</div>
			</div>

		</form>
		<%-- 
		<form method="post" name="addClassimgForm" action="addClassimgPro.jsp"
			enctype="multipart/form-data">

			<div class="form-group row">
				<label class="col-sm-2">수업 사진 등록하기</label>
				<div class="col-sm-5">
					 <input multiple="multiple" type="file" name="filename[]"  class="form-control"/> 
					
				</div>
			</div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" value="사진 등록">&nbsp;&nbsp;&nbsp; <input
						type="reset" value="모든 내용 취소">
				</div>
			</div>

		</form>
		--%>
	</div>
	
	<jsp:include page="/Home/footer.jsp" />
</body>
</html>
