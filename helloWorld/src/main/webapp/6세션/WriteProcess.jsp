<%@page import="common.JSFunction"%>
<%@page import="dao.BoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="IsLogin.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	// 1. 입력값을 받아서 DTO객체를 생성
	
	// 사용자가 로그아웃을 하지 않았어도
	// 일정 시간이 경과되면 세션이 제거되므로 오류가 발생할 수 있다.
	String id = (String)session.getAttribute("UserId");
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board();
	board.setId(id);
	board.setTitle(title);
	board.setContent(content);

	// 2. DAO.insert(...) 호출 : DB에 게시글을 등록하고 결과를 숫자로 반환
	BoardDao dao = new BoardDao();
	int res = dao.insert(board);

	// 3. 등록 성공 : 등록이 되었으면 리스트 페이지로 이동
	// 		등록 실패 : 메시지 처리
	if(res>0){
		// 등록 성공
		JSFunction.alertLocation("게시글이 등록 되었습니다.", "Board.jsp", out);
		/*
		% >
		<script>
			alert("게시글이 등록 되었습니다.");
			location.href="Board.jsp";
		</script>
		< %
		*/
	}else{
		// 등록 실패
		JSFunction.alertBack("등록 중 오류가 발생하였습니다.", out);
	}
	
%>
</body>
</html>