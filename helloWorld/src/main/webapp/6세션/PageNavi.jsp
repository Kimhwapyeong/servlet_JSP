<%@page import="dto.Criteria"%>
<%@page import="dto.PageDto"%>
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
	function go(page) {
		//location.href="Board.jsp?pageNo="+page;
		
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
</script>
<!-- 영역에 저장 -->
<c:set var="pageDto" value="<%=pageDto %>"></c:set>

<c:if test="${pageDto.prev }">
	<input type='button' value='처음' 
				onclick="location.href='List.jsp?pageNo=1'"> 
	<!-- 이전 버튼 -->
	<input type='button' value='이전' 
				onclick="location.href='List.jsp?pageNo=${pageDto.startNo-1}'"> 
</c:if>
<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
	<a href="List.jsp?pageNo=${i}">${i}</a>
</c:forEach>
<c:if test="${pageDto.next }">
	<input type='button' value='다음' 
				onclick="location.href='List.jsp?pageNo=${pageDto.endNo+1}'"> 	
	<input type='button' value='마지막' 
				onclick="location.href='List.jsp?pageNo=${pageDto.realEnd}'"> 
</c:if>
<br>
<%
		
	
	if(pageDto.isPrev()){
		// 1페이지 호출
		out.print("<input type='button' value="
				+"' << ' onclick='go(1)'>");
		
		// 이전 페이지 블럭
		out.print("<input type='button' value="
						+"' < ' onclick='go("+ (pageDto.getStartNo()-1) +")'>");
	}
	
	for(int i=pageDto.getStartNo(); i<=pageDto.getEndNo(); i++){
		out.print("<input type='button' value='" + i + "' onclick='go(" + i + ")'>");

	}
	
	if(pageDto.isNext()){
		// 이후 페이지 블럭
		out.print("<input type='button' value=' > ' onclick='go(" + (pageDto.getEndNo()+1) + ")'>");
		// 마지막 페이지 호출
		out.print("<input type='button' value="
				+"' >> ' onclick='go("+ pageDto.getRealEnd() +")'>");
	}
	
%>


</body>
</html>