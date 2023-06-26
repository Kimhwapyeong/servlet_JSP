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
	
	총 게시물 수 : ${totalCnt }
	<form name='searchForm'>
	<input type='hidden' name="pageNo" value="1">
	<table border='1' width="90%">
		<tr>
			<td align="center">
				<select name="searchField">
					<c:if test="${param.searchField eq 'title'}" var="res1">
						<c:set var="titleSelected" value="selected"></c:set>
					</c:if>
					<!-- //아래 if문은 필요 없음. 3항연산자를 통해 그냥 할 수 있음-->
					<c:if test="${criteria.searchField eq 'content' }" var="res2">
						<c:set var="contentSelected" value="selected"></c:set>
					</c:if>
					<option value="title" ${titleSelected }>제목</option>
					<option value="content" ${criteria.searchField eq 'content' ? "selected" : "" }>내용</option>
				</select>
				<input type="text" name="searchWord" value="${requestScope.criteria.searchWord }">
				<input type="submit" value="검색하기">
			</td>
		</tr>
	</table>
	</form>
	
	<c:set var="list" value="${requestScope.list }"></c:set>
	<table border="1" width="90%">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>다운로드 횟수</th>
			<th>조회수</th>
		</tr>
		<c:if test="${ empty list }" var="result">
			<tr>
				<td colspan="8" style='text-align: center'>게시물이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${ not result }">
			<c:forEach items="${list }" var="board">
				<tr>
					<td>${board.idx }</td>
					<td>${board.name }</td>
					<td><a href='../mvcboard/view.do?idx=${board.idx }'>${board.title }</a></td>
					<td>${board.content }</td>
					<td>${board.postdate }</td>
					<td>
						<c:if test="${not empty board.ofile}">
							<a href="../mvcboard/download.do?ofile=${board.ofile }&sfile=${board.sfile }&idx=${board.idx } ">[Down]</a>						
						</c:if>
					</td>
					<td>${board.downcount }</td>
					<td>${board.visitcount }</td>
				</tr>
			</c:forEach>
		</c:if>
	<!-- 글쓰기 버튼 추가
		글쓰기 버튼 클릭시 글쓰기 페이지로 이동 -->
	<tr>
		<td colspan='9' style='text-align: right'>
				<input type="button" value="글쓰기" onclick="location.href='../mvcboard/write.do'"></td>
	</tr> 
	</table>
	
	<c:set var="pageDto" value="${requestScope.pageDto }"/>
    <table border='1' width="90%">
		<tr align="center">
			<td><jsp:include page="PageNavi2.jsp"></jsp:include></td>
		</tr>    
    </table>
</body>
</html>