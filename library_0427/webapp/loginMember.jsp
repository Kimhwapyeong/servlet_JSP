<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<%
	if(session.getAttribute("member") != null){
		Member member = (Member)session.getAttribute("member");
		out.print(member.getName() + "님 환영합니다.");
	}
%>
	<h2>사용자 메뉴</h2>
	<ul>
		<li>도서대여</li>
		<li>도서반납</li>
	</ul>
	
	<button onclick="location.href='logout.jsp'">로그아웃</button>
</body>
</html>