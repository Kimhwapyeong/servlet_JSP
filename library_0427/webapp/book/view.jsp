<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
	function setAction(action){
		viewForm.action=action;
	}
</script>
</head>
<body>
${map.message  }
<jsp:include page="/common/header.jsp"/>
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>
<form name="viewForm" method="Post">
대여번호 : <input type="text" name="rentno" value="${book.rentno }">
도서번호 : <input type="text" name="no" value="${book.no }">
<!-- <input type='hidden' name='id' value=${sessionScope.userId }> -->
<table border="1" width='100%'>
    <colgroup>
        <col width="30%"/> 
        <col width="15%"/> <col width="20%"/>
        <col width="15%"/> <col width="20%"/>
    </colgroup>

    <!-- 게시글 정보 -->
    <tr>
        <td rowspan="3">
        	<img alt="${ book.title }이미지" width="200px" src="../images/bookimg/${book.sfile }">
        </td>
        <td>도서명</td><td>${ book.title }</td>
        <td>작가</td> <td>${ book.author }</td>
    </tr>
    <tr>
        <td>대여</td> 
        	<!-- 대여하기/반납하기 -->
        	<c:choose>
        		
        		<c:when test="${empty book.rentno}">
	        		<td colspan="3"><button onclick="setAction('./rent.book')">대여하기</button></td>
	        				
        		</c:when>
        		<c:when test="${book.id eq sessionScope.userId }"> 
        			<td><button onclick="setAction('./return.book')">반납하기</button></td>
        			<td>대여기간</td> <td>${ book.startDate } ~ ${ book.endDate }</td>
        		</c:when>
        		<c:otherwise>
        			<td>대여중</td>
        			<td>대여기간</td> <td>${ book.startDate } ~ ${ book.endDate }</td>
        		</c:otherwise>
        	</c:choose>
    </tr>
    <tr>
    	<td height="200px">상세설명</td><td colspan="3"></td>
    </tr>
    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="5" align="center">
            <button type="button" onclick="location.href='./edit.book?no=${book.no}';">
                수정하기
            </button>
            <button type="button" onclick="location.href='./delete.book?delNo=${ book.no }';">
            	삭제하기
            </button>
            <button type="button" onclick="location.href='./list.book';">
                목록 바로가기
            </button>
           	<c:if test=""></c:if>
           	
            
            
        </td>
    </tr>
</table>
</form>
<!-- 	<tr>
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
	</c:if> -->
</body>
</html>



