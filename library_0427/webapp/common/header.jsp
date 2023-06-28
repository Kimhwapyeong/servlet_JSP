<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/list_style.css">
</head>
<body>

<header>
 	<c:if test="${sessionScope.userId != null }">
 		${sessionScope.userId } 님 환영합니다!
 	</c:if>
	
	<!-- 어드민 -->
	<c:if test="${sessionScope.adminYN eq 'Y' }" var='res'>
		<div>로고</div>
		<div>
			<a href="">도서관리</a>
		</div>
			<a href="">사용자관리</a>
		<div><button onclick="location.href='${pageContext.request.contextPath}/logout.jsp'">로그아웃</button></div>
	</c:if> 	
	
	<!-- 사용자 -->
	<c:if test="${ not res }">
		<div>로고</div>
		<div>
			<a href="../book/list.book">도서관리시스템</a>
		</div>
		<a href="./myPage.book">마이페이지</a>
		
		<!-- 로그인 전 -->
		<c:if test="${empty sessionScope.userId }" var="res1">
			<div><button onclick="location.href='${pageContext.request.contextPath}/login.jsp'">로그인</button></div>
		</c:if>
		
		<!-- 로그인 후 -->
		<c:if test="${not res1 }">
			<div><button onclick="location.href='${pageContext.request.contextPath}/logout.jsp'">로그아웃</button></div>
		</c:if>
	</c:if>
 	
 	
 	
</header>
</body>
</html>