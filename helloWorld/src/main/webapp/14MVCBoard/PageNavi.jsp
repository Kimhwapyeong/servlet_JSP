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


<c:if test="${pageDto.prev }">
	<input type='button' value='처음' 
				onclick="location.href='list.do?pageNo=1&searchField=${criteria.searchField}&searchWord=${criteria.searchWord }'"> 
	<!-- 이전 버튼 -->
	<input type='button' value='이전' 
				onclick="location.href='list.do?pageNo=${pageDto.startNo-1}&searchField=${criteria.searchField}&searchWord=${criteria.searchWord }'"> 
</c:if>
<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
	<a href="list.do?pageNo=${i}&searchField=${criteria.searchField}&searchWord=${criteria.searchWord }">${i}</a>
</c:forEach>
<c:if test="${pageDto.next }">
	<input type='button' value='다음' 
				onclick="location.href='list.do?pageNo=${pageDto.endNo+1}&searchField=${criteria.searchField}&searchWord=${criteria.searchWord }'"> 	
	<input type='button' value='마지막' 
				onclick="location.href='list.do?pageNo=${pageDto.realEnd}&searchField=${criteria.searchField}&searchWord=${criteria.searchWord }'"> 
</c:if>
<br>
</body>
</html>