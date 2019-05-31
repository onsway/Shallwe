<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="hmjm.bean.dao.messageDAO" %>
<%@ page import="hmjm.bean.vo.messageVO" %>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<% 
	String id = (String)session.getAttribute("loginId");
	String sender = (String)session.getAttribute("s_send");
	int num=0;
	try{  
    	if(request.getParameter("s_num")!=null){
		num=Integer.parseInt(request.getParameter("s_num"));
		}
%>
<body>
<form method="post" name="messageform" action="messageWritePro.jsp" onsubmit="return writeSave()">
	<input type="hidden" name="s_num" value="<%=num%>">
<table width="800" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr><td width="100" align="center">보내는사람</td>
    	<td width="330"><input type="text" size="10" name="s_send" value="<%=id %>" readonly></td>
    	<td width="100" align="center">받는사람</td>
    	<td width="330"><input type="text" size="10" name="s_send" value="<%=sender %>" readonly></td>
	</tr>
  
	<tr><td width="70" align="center" >내 용</td>
	  	<td width="330" ><textarea name="s_content" rows="5" cols="50" required></textarea></td>
	</tr>
</table>

<table align="center">  
	<tr><td colspan=2 align="center"> 
			<input type="submit" value="보내기"/>
			<input type="reset" value="취소"/></td>
	</tr>
</table>    
<%}catch(Exception e){}%>     
</form>   
</body>
</html>      
