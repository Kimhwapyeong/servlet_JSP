<%@page import="dto.Board"%>
<%@page import="common.JSFunction"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");	
	
	// 파라메터를 입력받아 Dto 객체 생성
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board();
	
	board.setNum(num);
	board.setTitle(title);
	board.setContent(content);
	
	// 게시물 업데이트
	BoardDao dao = new BoardDao();
	int res = dao.updateBoard(board);
	
	if(res>0){
		//out.print("<script>");
		//out.print(" 	alert('수정 완료 되었습니다.');");
		//out.print(" 	location.href='view.jsp?num="+num+"'");
		//out.print("</script>");
		
		// 성공 : 메시지 출력 상세페이지로 이동
		JSFunction.alertLocation("수정이 완료 되었습니다.", "view.jsp?num="+num, out);
	} else {
		// 실패 : 메시지 출력 이전 페이지로 이동
		JSFunction.alertBack("수정 중 오류 발생", out);
	}
	
%>




	
</body>
</html>