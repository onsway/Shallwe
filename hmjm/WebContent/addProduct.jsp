<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="hmjm.bean.dao.memberDAO"%>
<%@ page import="hmjm.bean.vo.memberVO"%>
<%@ page import="hmjm.bean.dao.tutorDAO"%>
<%@ page import="hmjm.bean.vo.tutorVO"%>

<%-- 19.06.04失肯 拙失 , 耕刃失, --%>
<%--

 --%>
<%
	request.setCharacterEncoding("UTF-8");
	String preUser = (String) session.getAttribute("loginId");//薄仙 室芝,戚五析戚 級嬢姶
	//析鋼政煽 舛左
	memberDAO mdao = memberDAO.getInstance();
	memberVO mvo = mdao.getMember(preUser);
	//透斗 去系 舛左, 爽汐熱檎 拭君降持. 酔識 爽汐含焼客
	//nick葵 閤焼神奄是敗
	//tutorDAO tdao = tutorDAO.getInstance();		
	//tutorVO tvo = tdao.getMember(preUser);
%>


<html>
<head>
<title>呪穣 去系</title>
<script language="JavaScript" src="script.js"></script>
<script>
	function div_onoff(v,id){/*虞巨神 獄動 value葵 繕闇 搾嘘*/
		if(v=="2"){
			document.getElementById(id).style.display="";//左食捜
		}else
			document.getElementById(id).style.display="none";//需沿		
	}
</script>
<style>
	 input[type=number]{
		width:80px;	
	}
</style>
</head>
<%--
	//透斗 去系聖 馬走省壱, 羨悦梅聖 獣 (透斗 舛左x(室芝 糎仙x)
	if(session.getAttribute("memId")==null){--%>
<%-- 
		<script>
			alert("透斗 奄沙 脊径 舛左拭辞 [妃企穿鉢 腰硲], [重歳/俳径 昔装] 舛左研 胡煽 去系背爽室推");
			window.location='tutorRegister.jsp';
		</script>
	--%>

<%--}--%>
<%
	int num = 0; //越 授辞腰硲
	try {
		if (request.getParameter("num") != null) {//歯越析凶 疑拙x
			num = Integer.parseInt(request.getParameter("num"));
		}
%>
<%--
 呪穣腰硲> 切疑生稽 葵 採食p_num;
戚五析> 透斗table拭辞 亜閃臣依
>脊径
呪穣誤p_classname;
歳嫌	p_category;
悪紫社鯵 p_self;
呪穣社鯵p_class;
社推獣娃p_time;
亜維p_cost;
昔据p_student;
ps越 p_memo;
private String imgsrc;	//戚耕走督析聖 亜閃神奄是廃 痕呪 蓄亜 拙失
    --%>

<body>
	<b>呪穣去系</b>
	<br>
	<div class="container">
		<form method="post" name="writeform" action="writePro.jsp"
			onsubmit="return writeSave()">
			<%--呪穣 腰硲 切疑 採食背醤敗 hidden--%>
			<input type="text" name="num" value="<%=num%>">

			<div>
				<label>[戚硯]</label><%=mvo.getM_name()%>
			</div>
			<%-- 
	<div>
		<label>莞革績</label><%=tvo.getT_nick()%>
	</div>
	--%>
			<div>
				<label>[戚五析]</label><%=mvo.getM_email()%>
			</div>

			<div>
				<%--鯉系 益血 --%>
				<label>呪穣 誤</label> <input type="text" size="40" maxlength="50"
					name="p_classname" placeholder="戚鯉聖 怪 套套蕩澗 呪穣誤聖 脊径馬室推!">
			</div>

			<div>
				<%--鯉系 益血:select稽 壱研 呪 赤亀系 姥薄拝依 --%>
				<label>朝砺壱軒(企>社)</label>
				<select id="p_category" name="p_category">
					<optgroup label="昔奄呪穣">
						<option value="archi">しし</option>
						<option value="computer" selected>しし</option>
					</optgroup>
					<optgroup label="巨切昔">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="叔巷蝕勲">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="坂銅">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="慎雌">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="須厩嬢">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="製焦">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="虞戚覗什析">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
					<optgroup label="奄展">
						<option value="history">しし</option>
						<option value="lang">しし</option>
					</optgroup>
				</select><br />
			</div>

			<div>
				<%--鯉系 益血 /rows="15" cols="100"稽 竺舛馬奄--%>
				<label>悪紫社鯵</label><br>
				<textarea name="p_self" rows="3" cols="5"></textarea>
			</div>
			<div>
				<%--鯉系 益血 --%>
				<h3>社鯵馬奄</h3>
				<label>透斗舛左</label><br>
				<textarea name="p_class1" rows="3" cols="5"></textarea><br>
				<label>呪穣社鯵</label><br>
				<textarea name="p_class2" rows="3" cols="5"></textarea><br>
				<label>呪穣 企雌</label><br>
				<textarea name="p_class3" rows="3" cols="5"></textarea><br>
				<label>朕軒擢軍</label><br>
				<textarea name="p_class4" rows="3" cols="5"></textarea>
			</div>

			<div>
				<%--鯉系 益血 --%>
				<label>社推獣娃</label> 
				<input type="number" name="p_time" min=1>
			</div>
			<div>
				<%--鯉系 益血 --%>
				<label>亜維</label> 
				<input type="number" name="p_cost" step="1000" min=0>据
			</div>
			<div>
				<%--鯉系 益血 --%>
				<label>昔据</label><br>
				<input type="radio" name="howmany" value="1" onclick="div_onoff(this.value,'con');">1:1 悪柔<br>
				<input type="radio" name="howmany" value="2" onclick="div_onoff(this.value,'con');">1:N 悪柔
				<div id="con" style="display:none">
					置社昔据: <input type="number" name="p_count_min" min=1>
					置企昔据: <input type="number" name="p_count_max" min=1>
				</div>

			</div><br>
			
			<div>
				<%--鯉系 益血 --%>
				<label>PS</label><br>
				<textarea name="p_memo" rows="5" cols="100"></textarea>
			</div>

			<input type="submit" value="呪穣 去系"> 
			<input type="reset"	value="乞窮 鎧遂 昼社"> 
			<input type="button" value="鯉系左奄"	OnClick="window.location='list.jsp'">
			<%} catch (Exception e) {}%>
		</form>
	</div>
</body>
</html>
