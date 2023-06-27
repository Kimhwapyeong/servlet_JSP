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
<table border='1' width='90%'>
	<tr>
		<th>제목</th>	
		<td>${book.title}</td>	
		<th>작가</th>
		<td>${book.author }</td>
		<th>렌트여부</th>
		<td>${book.rentyn }</td>	
	</tr>
	<c:if test="${book.rentyn eq 'N' && userId != null}">
		<tr>
			<td colspan='6' style="text-align:right"><button onclick="location.href='../book/rent.book?no=${book.no}&id=${userId }'">대여하기</button></td>
		</tr>
	</c:if>
</table>
</body>
</html>