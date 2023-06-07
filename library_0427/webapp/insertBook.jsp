<%@page import="com.library.service.BookService"%>
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
		String insertErr = request.getParameter("insertErr");
		if("Y".equals(insertErr)){
			out.print("<script>alert('책제목/작가를 적어줘요잉')</script>");
		}
	%>
	<h2>도서등록</h2>
	<form action="insertBook22.jsp">
		책 제목 : <input type='text' name='title'>
		작가 : <input type='text' name='author'>
		<input type='submit' value='등록'>
	</form>

</body>
</html>