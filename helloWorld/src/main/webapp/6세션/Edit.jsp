<%@page import="dto.Board"%>
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
	String num = request.getParameter("num");

	BoardDao dao = new BoardDao();
	Board board = dao.selectOne(num);
	
%>
<jsp:include page="Link.jsp" />
<h2>회원제 게시판 - 수정하기(Edit)</h2>
<form name="editFrm" method="post" action="EditProcess.jsp"
      onsubmit="return validateForm(this);">
    <input type="text" name="num" style="display:none" value="<%=num %>">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=board.getTitle() %>"/>
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
                <button type="submit">수정하기</button>
                <button type="reset">초기화</button>
                <button type="button" onclick="location.href='Board.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>