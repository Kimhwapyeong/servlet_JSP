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
<%@include file="../common/header.jsp" %>
<h2>도서목록</h2>

총건수 : ${requestScope.bookMap.totalCnt }

<form name='searchForm' action="../book/list.book">
<input type='hidden' name='pageNo' value='1'>
<table border='1' width='90%'>
	<tr>
		<td align="center">
			<select name='searchField'>
				<option value='title' ${param.searchField eq 'title' ? "selected" : "" }>제목</option>
				<option value='author' ${param.searchField eq 'author' ? "selected" : "" }>작가</option>
			</select>
			<input type="text" name="searchWord" value="${param.searchWord }">
			<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>

<c:set var="list" value="${requestScope.bookMap.list }"></c:set>
<table border="1" width="90%">
	<c:if test="${sessionScope.adminYN eq 'Y' }">
	<tr>
		<td colspan='5' class='right'>
			<!-- 어드민 계정인 경우, 등록, 삭제 버튼을 출력 -->
			<button>도서등록</button>
			<button>도서삭제</button>
		</td>
	</tr>
	</c:if>
	<tr>
		<th width='5%'></th>
		<th width='35%'>제목</th>
		<th width='20%'>작가</th>
		<th width='10%'>대여여부</th>
		<th width='30%'>등록일</th>
	</tr>
	<c:if test="${empty list }" var="res">
		<tr>
			<td colspan="5" class='center'>게시물이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not res }">
		<c:forEach items="${list }" var="book">
			<tr>
				<td class='center'>
					<!-- 삭제용 체크박스 -->
					<input type='checkbox' name='delNo' value='${book.no }'>
				</td>
				<td><a href='../book/view.book?no=${book.no }'>${book.title }</a></td>				
				<td>${book.author }</td>				
				<td>${book.rentyn }</td>				
				<td></td>				
			</tr>
		</c:forEach>
	</c:if>
	
</table> 

<c:set var="pageDto" value="${requestScope.bookMap.pageDto}"></c:set>
<table border='1' width='90%'>
	<tr algin='center'>
		<td><jsp:include page="../common/PageNavi.jsp"></jsp:include></td>
	</tr>
</table>
</body>
</html>