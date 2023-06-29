<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/list_style.css">
<style type="text/css">

</style>
<script>
	
	/// 메시지가 있다면 메시지 출력
	/// script 에서도 el태그 사용 가능
	let message = '${message}';
	if(message != null && "" != message){
		alert(message);
	}
				/// 삭제 후에도 같은 페이지에 있기 위해 파라메터로 pageNo를 넘겨줌
				/// searchField와 searchWord는 검색 된 경우 파라메터로 넘어와서 selected
				/// 되어 있기 때문에 자동으로 submit() 될 때 파라메터로 넘어감
	function deleteBook(pageNo) {
		// 체크박스가 선택된 요소의 value값을 ,로 연결
		delNoList = document.querySelectorAll("[name=delNo]:checked");
		
		let delNo = "";
		// 배열을 돌면서 저장된 변수 e의 value를 delNo 변수에 +
		delNoList.forEach((e)=>{
			delNo += e.value + ',';
		})
		// 마지막 , 삭제
		delNo = delNo.substr(0, delNo.length-1);
		console.log(delNo);
		// 삭제 요청
		searchForm.action="../book/delete.book";
		searchForm.delNo.value=delNo;
		searchForm.pageNo.value=pageNo;
		searchForm.submit();
		
	}
</script>
</head>
<body>
<%@include file="../common/header.jsp" %>
<!-- //책 삭제 후 뒤로가기 했을 때 메시지가 alert 되는 것을 없애기 위해 넣음 -->
<c:set value="" var="message"/>
<h2>도서목록</h2>

총건수 : ${requestScope.map.totalCnt }

<jsp:include page="../common/searchForm.jsp"></jsp:include>

<c:set var="list" value="${requestScope.map.list }"></c:set>
<table border="1" width="100%" class='listtb'>
	<c:if test="${sessionScope.adminYN eq 'Y' }">
	<tr>
		<td colspan='5' class='right'>
			<!-- 어드민 계정인 경우, 등록, 삭제 버튼을 출력 -->
			<button onclick="location.href='../book/write.book'">도서등록</button>
			<button onclick="deleteBook(${param.pageNo})">도서삭제</button>
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
		<c:set var="pageDto" value="${requestScope.map.pageDto}"></c:set>
		<table border='1' width='100%'>
			<tr  class='center'>
				<td><jsp:include page="../common/PageNavi.jsp"></jsp:include></td>
			</tr>
		</table>
	</c:if>
	
</table> 

</body>
</html>