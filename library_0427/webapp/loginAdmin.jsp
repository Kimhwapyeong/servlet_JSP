<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	a{
		text-decoration : none;
	}
</style>
</head>
<body>
<%@ include file="/common/header.jsp" %>
<%
	// 세션에 저장된 멤버 객체로부터 이름을 출력
	if(session.getAttribute("member") != null){
		Member member = (Member)session.getAttribute("member");
		out.print(member.getName() + "님 환영합니다.");
	}
%>

	<h2>관리자 메뉴</h2>
	<ul>
		<li><a href='insertBook.jsp'>도서등록</a></li>
		<li>도서삭제 - 도서 상세보기 삭제버튼을 이용하세요</li>
		<li>관리자등록</li>
		<li>관리자삭제</li>
	</ul>
	
	<button onclick="location.href='logout.jsp'">로그아웃</button>
</body>
</html>