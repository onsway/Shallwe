<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="hmjm.bean.admin.adminDAO" %>

<%
	String id= request.getParameter("aid");
	String apw= request.getParameter("apw");
	adminDAO dao = adminDAO.getInstance();
	
	boolean result = dao.adminLoginCheck(apw);
	
	if(result){
		session.setAttribute("loginId",id);
		response.sendRedirect("/hmjm/Admin/adminMain.jsp");%>
	<%}else{%>
		<script>
			alert("id/pw확인");
			history.go(-1);
		</script>
	<%}
%>
