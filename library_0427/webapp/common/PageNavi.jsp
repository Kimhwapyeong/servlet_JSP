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
<script>
	function go(page, searchField, searchWord) {
		//location.href="Board.jsp?pageNo="+page;
		
		document.searchForm.pageNo.value=page;
		document.searchForm.searchField.value=searchField
		document.searchForm.searchWord.value=searchWord
		document.searchForm.submit();
	}
</script>
<c:set var='searchF' value='${map.criteria.searchField}'/>
<c:set var='searchW' value='${map.criteria.searchWord }'/>

<c:if test="${map.pageDto.prev }">
	<input type='button' value='처음' 
				onclick="go(1, '${searchF}', '${searchW}')"> 
	<!-- 이전 버튼 -->
	<input type='button' value='이전' 
				onclick="go(${map.pageDto.startNo-1}, '${searchF}', '${searchW}')"> 
</c:if>
<c:forEach begin="${map.pageDto.startNo }" end="${map.pageDto.endNo }" var="i">
	<!-- <a href="list.book?pageNo=${i}&searchField=${searchF}&searchWord=${searchW}">${i}</a> -->
	<button onclick="go(${i}, '${searchF}', '${searchW}')">${i }</button>
</c:forEach>
<c:if test="${map.pageDto.next }">
	<input type='button' value='다음' 
				onclick="go(${map.pageDto.endNo+1}, '${searchF}', '${searchW}')"> 	
	<input type='button' value='마지막' 
				onclick="go(${map.pageDto.realEnd}, '${searchF}', '${searchW}')"> 
</c:if>
<br>
</body>
</html>