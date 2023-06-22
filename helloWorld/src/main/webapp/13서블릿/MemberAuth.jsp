<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>MVC패턴으로 회원 인증하기</h2>

	<p>${authMessage }</p>
	<a href="./MemberAuth.mvc?id=musthave&pw=1234">a태그</a>
	
	<form action="./MemberAuth.mvc">
		<input type="text" value="아이디" name="id">
		<input type="text" value="비밀번호" name="pw">
		<button>로그인</button>
	</form>

</body>
</html>