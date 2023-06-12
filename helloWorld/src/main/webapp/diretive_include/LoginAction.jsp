<%@page import="utils.CookieManager"%>
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
	String id = request.getParameter("userid");
	String pw = request.getParameter("userpw");
	
	String saveYN = request.getParameter("saveYN");
	
	// 체크박스가 체크되었을 경우, 아이디를 쿠키에 저장합니다.
	if("Y".equals(saveYN)){
		CookieManager.makeCookie("userId", id, 60*60*24*7, response);
	}
	


	if("abc".equals(id) && "123".equals(pw)){
		// 로그인 성공
		
		// 세션에 저장
		session.setAttribute("id", id);
		
		// response.sendRedirect("gogreen.jsp?name="+id);
		response.sendRedirect("gogreen.jsp");
	}else{
		// 로그인 실패
		response.sendRedirect("gogreen.jsp?loginErr=y");
	}
	%>
</body>
</html>