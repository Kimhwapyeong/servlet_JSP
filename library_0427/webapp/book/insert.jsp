<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/list_style.css">
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<form action="./addbook.book">
	제목 : <input type="text" name="title"><br>
	작가 : <input type="text" name="author">
	<button type="submit">추가</button>
</form>
</body>
</html>