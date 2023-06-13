<%@page import="dto.Member"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 쿠키에 저장된 아이디 보여주기
	// 쿠키에 저장된 아이디가 있다면 id필드의 value 속성에 아이디 값을 넣어줍니다.
	
	String userId = CookieManager.readCookie(request, "userId");
	
	/*
	Cookie[] cookies = request.getCookies();
	String userId = "";
	
	if(cookies != null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("userId")){
				userId = cookie.getValue();
				break;
			}
		}		
	}
	*/
	
	String loginErr = request.getParameter("loginErr");
	if("Y".equals(loginErr)){
		out.print("<script>alert('아이디/비밀번호를 확인해주세요.')</script>");
	}

	Member member = null;
	if(session.getAttribute("member") != null){
		member = (Member)session.getAttribute("member");
	}
	
	if(member != null){
		out.print(member.getName() + "님 환영합니다.");
		%> <button onclick="location.href='logout.jsp'"> 로그아웃</button> <%
	} else {
%>
	<!-- /// form : form 태그 안의 요소들을 가지고 서버에 페이지를 요청 -->
	<form action="LoginAction.jsp" method="post">
		<div class='loginbox'>
			<div id='login'>
				<input type="text" name="userid" id="userid"
					placeholder='ID를 입력해주세요.' required value="<%=userId%>"><br>
				<input type="password"
					name="userpw" id="userpw" placeholder='PW를 입력해주세요.' required="required"><br>
				<input type="checkbox" name="save_check" value="Y">아이디 저장하기<br>
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
</body>
</html>