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
	<h2>MVC 모델2 게시판</h2>
	
	<c:set var="list" value="${requestScope.list }"></c:set>
	<table border="1" width="90%">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성일</th>
			<th>원본파일명</th>
			<th>저장된 파일명</th>
			<th>다운로드 횟수</th>
			<th>조회수</th>
		</tr>
		<c:if test="${ empty list }" var="result">
			<tr>
				<td colspan="9">게시물이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${ not result }">
			<c:forEach items="${list }" var="board">
				<tr>
					<td>${board.idx }</td>
					<td>${board.name }</td>
					<td>${board.title }</td>
					<td>${board.content }</td>
					<td>${board.postdate }</td>
					<td>${board.ofile }</td>
					<td>${board.sfile }</td>
					<td>${board.downcount }</td>
					<td>${board.visitcount }</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<c:set var="pageDto" value="${requestScope.pageDto }"/>
    <table border='1' width="90%">
		<tr align="center">
			<td><%@include file="PageNavi.jsp" %></td>
		</tr>    
    </table>
</body>
</html>