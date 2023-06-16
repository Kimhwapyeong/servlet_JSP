<%@page import="dto.Board"%>
<%@page import="dao.NewBoardDao"%>
<%@page import="common.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>

</head>
<body>
<%
	String num = request.getParameter("num");

	if(num == null){
		JSFunction.alertBack("존재하지 않는 게시물 입니다.", out);
		return;
	}
	
	NewBoardDao dao = new NewBoardDao();
	Board board = dao.seletOne(num);
	
   	String pageNo = request.getParameter("pageNo") == null ? "1"
			: request.getParameter("pageNo");
%>
<%@include file="../6세션/Link.jsp" %>
<h2>회원제 게시판 - 수정하기(Edit)</h2>
<form action="EditProcess.jsp">
	<input type="text" name="num" value="<%=board.getNum() %>" style="display:none">
	<!--게시물 수정 후 게시물이 있던 페이지를 보기 위한 파라메터 --> 
	<input type="text" name="pageNo" value="<%=pageNo %>" style="display:none">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=board.getTitle()%>"/> 
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"><%=board.getContent() %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">수정 완료</button>
                <button type="reset">초기화</button>
                <button type="button" onclick="location.href='List.jsp'">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>