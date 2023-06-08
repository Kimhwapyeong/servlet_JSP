<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="css/gogreen_style.css">
</head>
<body>
<%
	String loginErr = request.getParameter("loginErr");
	if("Y".equals(loginErr)){
		out.print("<script>alert('아이디/비밀번호를 확인해주세요.')</script>");
	}
	
	String name = "";
	if(session.getAttribute("member") != null){
 		name = ((Member)session.getAttribute("member")).getName();
	}
	if(name != null && !name.equals("")){
		out.print(name + "님 환영합니다.");
	} else {
%>
<aside id='rightside'>
<div class='loginbox'>
	<!-- /// form : form 태그 안의 요소들을 가지고 서버에 페이지를 요청 -->
	<form action="loginAction.jsp" method="post">
		<div class='loginbox'>
			<div id='login'>
				<input type="text" name="userid" id="userid"
					placeholder='ID를 입력해주세요.'> 
				<input type="password"
					name="userpw" id="userpw" placeholder='PW를 입력해주세요.'>
			</div>
			<div id='button'>
				<input type="submit" value="로그인">
			</div>
		</div>
		<div id='info'>
			<a href="">회원가입</a> <a href="">ID찾기</a> <a href="">PW찾기</a>
		</div>
	</form>
	<%} %>
</div>
</aside>
</body>
</html>