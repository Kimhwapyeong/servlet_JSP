<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.onload = () => {
		document.querySelector("[name=searchForm]").action = '../book/myPage.book';
	}
</script>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<h2>마이페이지 - 나의 대여 목록</h2>
<jsp:include page="../common/searchForm.jsp"></jsp:include>
<c:set value="${bookMap.list }" var="list"></c:set>
<table border='1' width='100%'>
	<tr>
		<th width='10%'>책번호</th>
		<th width='20%'>제목</th>
		<th width='20%'>대여일</th>
		<th width='20%'>반납일</th>
		<th width='10%'>연체일</th>
	</tr>
	<c:forEach items='${list }' var='book'>
	<tr>
		<td>${book.no }</td>
		<td>${book.title }</td>
		<td>${book.startDate }</td>
		<td>${book.returnDate }</td>
		<td>${book.overDate }</td>
	</tr>
	</c:forEach>
</table>
<jsp:include page="../common/PageNavi.jsp"/>
</body>
</html>