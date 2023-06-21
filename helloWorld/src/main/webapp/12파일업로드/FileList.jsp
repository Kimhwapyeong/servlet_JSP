<%@page import="java.util.List"%>
<%@page import="fileUpload.FileDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="fileUpload.FileDao"%>
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
<%
	FileDao dao = new FileDao();
	List<FileDto> list = dao.getFileList();
%>
	<h2>DB에 등록된 파일 목록 보기</h2>
	<a href="FileUpload.jsp">파일 등록하기</a>
	<!-- 게시물 목록 테이블(표) -->
	<table border="1" width="90%">
		<!-- 각 칼럼의 이름 -->
		<tr>
			<th>No</th>
			<th>작성자</th>
			<th>제목</th>
			<th>카테고리</th>
			<th>원본 파일명</th>
			<th>저장된 파일명</th>
			<th>작성일</th>
			<th></th>
		</tr>
		<!-- 목록의 내용 -->
		<!-- EL에서 사용하기 위해 변수를 페이지 영역에 저장 -->
		<c:set var="list" value="<%=list %>"></c:set>

		<!-- 리스트가 비었는지 확인 -->
		<c:if test="${ empty list }" var="result">
			<tr>
				<td colspan='8' style="text-align: center">게시물이 없습니다.</td>
			</tr>
		</c:if>

		<!-- 리스트가 비어있지 않다면, 리스트를 출력 -->
		<c:if test="${ not result }">
			<!-- 반복문을 통해 리스트에 담긴 board객체를 출력 
				items : 향상된 for문
			-->
			<c:forEach items="${list }" var="file">
				<tr align="center">
					<td>${file.idx }</td>
					<td>${file.name}</td>
					<td>${file.title }</td>
					<td>${file.cate }</td>
					<td>${file.ofile }</td>
					<td>${file.sfile }</td>
					<td>${file.postdate }</td>
					<td><a
						href="Download.jsp?oName=${file.ofile }&sName=${file.sfile}">다운로드</a></td>
				</tr>
			</c:forEach>
		</c:if>

	</table>

</body>
</html>