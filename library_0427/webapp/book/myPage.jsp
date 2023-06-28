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
<link rel='stylesheet' href='../css/list_style.css'>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<h2 class='center'>마이페이지 - 나의 대여 목록</h2>
<jsp:include page="../common/searchForm.jsp"></jsp:include>
<c:set value="${bookMap.list }" var="list"></c:set>
<table border='1' width='100%'>
	<tr>
		<th width='5%'>책번호</th>
		<th width='20%'>제목</th>
		<th width='10%'>작가</th>
		<th width='20%'>대여일</th>
		<th width='20%'>반납일</th>
		<th width='5%'>연체일</th>
		<th width='10%'>반납</th>
	</tr>
	<c:if test="${empty list }" var='res1'>
		<tr>
			<td colspan='7' style='text-align:center'>조회된 결과가 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not res1 }">
		<c:forEach items='${list }' var='book'>
		<tr>
			<td>${book.no }</td>
			<td>${book.title }</td>
			<td>${book.author }</td>
			<td>${book.startDate }</td>
			<td>${book.returnDate }</td>
			<td>${book.overDate }</td>
			<td>
				<c:if test="${empty book.returnDate }" var='res'>
			   		<form action="../book/return.book">
						<input type='hidden' name='no' value='${book.no }'>
						<input type='hidden' name='rentno' value='${book.rentno }'>
						<input type="hidden" name='pageNo' value='${bookMap.criteria.pageNo }'>
						<input type='hidden' name='searchField' value='${bookMap.criteria.searchField }'>
						<input type='hidden' name='searchWord' value='${bookMap.criteria.searchWord }'>
						<button>반납하기</button>
					</form> 
				</c:if>
				<c:if test="${not res }">
					반납 완료
				</c:if>
			</td>
		</tr>
		</c:forEach>
		<table border='1' width='100%'>
			<tr class='center'>
				<td><jsp:include page="../common/PageNavi.jsp"/></td>
			</tr>
		</table>
	</c:if>
</table>
</body>
</html>