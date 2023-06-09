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
	// name 속성의 값을 매개값으로 넘겨주면 value 속성의 값을 반환한다.
	String id = request.getParameter("userid");
	String pw = request.getParameter("userpw");
	
	// 아이디 저장 체크박스
	String saveYN = request.getParameter("save_check");
	out.print("saveYN : " + saveYN + "<br>");
	
	// 아이디 저장하기 체크박스에 체크가 되었다면
	// 쿠키에 아이디를 저장합니다.
	if("Y".equals(saveYN)){
		
		// CookieManager를 이용하여 쿠키를 생성후 응답객체에 담아줍니다
		CookieManager.makeCookie("userId", id, 3600, response);
		/*
		// 쿠키 생성하기 (userId, 사용자 아이디)
		Cookie cookie = new Cookie("userId", id);
		
		// 유지시간 설정
		cookie.setMaxAge(3600);
		
		// 응답객체에 담기
		response.addCookie(cookie);
		*/
	}
	
	if("abc".equals(id) && "123".equals(pw)){
		response.sendRedirect("login.jsp?name="+id);
	}else{
		//response.sendRedirect("login.jsp?loginErr=Y");
		out.print("로그인 실패");
	}
%>
</body>
</html>