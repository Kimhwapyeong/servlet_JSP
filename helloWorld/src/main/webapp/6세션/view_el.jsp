<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%

	BoardDao dao = new BoardDao();
	dao.updateVisitCount(request.getParameter("num"));
	// 게시글 1건을 조회 후 board객체에 담아서 반환
	Board board = dao.selectOne(request.getParameter("num"));
	
	if(board == null){
		JSFunction.alertBack("게시글이 존재하지 않습니다.", out);
		
		return;
	}

	String num = board.getNum();
	String boardId = board.getId();
	String title = board.getTitle();
	String content = board.getContent().replace("\r\n", "<br>");
	String postdate = board.getPostDate();
	String visitcount = board.getVisitCount();
	
	request.setAttribute("board", board);
%>
<script>
	function deletePost() {
		var res = confirm("삭제 하시겠습니까?");
		if(res){
			location.href="DeleteProcess.jsp?num=<%=board.getNum()%>"
		}
	}
</script>
</head>
<body>
<%@include file="Link.jsp" %>
<h2>회원제 게시판 - 상세보기(View)</h2>
<table border='1' width='90%'>
	<tr>
		<td>번호</td>
		<td>${board.num }</td>
		<td>작성자</td>
		<td>${board.id }</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td>${board.postDate }</td>
		<td>조회수</td>
		<td>${board.visitCount }</td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan='3'>${board.title }</td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan='3' height='60px'>${board.content }</td>
	</tr>
	<tr>
		<td colspan='4' style='text-align:center'>
		<input type="button" value="목록보기" onclick="location.href='Board.jsp'">
		<%
		if(session.getAttribute("UserId") != null 
				&& session.getAttribute("UserId").equals(boardId)){
		%> 
			<input type='button' value='수정' onclick="location.href='Edit.jsp?num=${board.num}'">
			<input type='button' value='삭제' onclick="deletePost()">
		<%
		}
		%>
		</td>
	</tr>
</table>
</body>
</html>