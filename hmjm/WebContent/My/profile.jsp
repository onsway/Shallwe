<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="hmjm.bean.member.*"%>


<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정^^</title>
<script type="text/javascript">
</script>
<style>
.box{
	height:100px;
	background-color:white;
}
</style>
</head>
<body>
	

	<%
		String m_email = (String) session.getAttribute("loginId");
		//System.out.println("====="+m_email);
		memberDAO manager = memberDAO.getInstance();
		memberVO c = manager.getMember(m_email);
	%>
	<div>
		<div class="box">
		</div>
		<form action="profilePro.jsp" name="member" method="post"
			align="center">

			<table width="550" align="center">
				<tr height="80" bgcolor="333F48">
					<th colspan="3"><font color="white">회원정보 수정</th>
				</tr>
				<tr height="50">
					<th>이메일</th>
					<th><%=c.getM_email()%></th>
				</tr>
				<tr height="50">
					<th>이 름</th>
					<th><input type="text" autofosus name="m_name"
						value="<%=c.getM_name()%>"></th>
				</tr>
				<tr height="50">
					<th>전화번호</th>
					<th><input type="text" name="m_phone"
						value="<%=c.getM_phone()%>"></th>
				</tr>
				<tr height="50">
					<th>비밀번호</th>
					<th><input type="password" name="m_pw"
						value="<%=c.getM_pw()%>"></th>
				</tr>
			</table>
			<br> <input type="submit" name="modify" value="회원정보 수정"
				" style="height: 30px; width: 100px;"><br>
			<br> <input type="button" value="취소"
				" style="height: 30px; width: 50px;"
				onclick="javascript:window.location='application.jsp'"> <input
				type="button" value="탈퇴" " style="height: 30px; width: 50px;"
				onclick="window.open('/hmjm/Admin/adminMessageForm.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,resizable=no,directories=no,width=620,height=600')">


		</form>

	</div>
</body>
</html>