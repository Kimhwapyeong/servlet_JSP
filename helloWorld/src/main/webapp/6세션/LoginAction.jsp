<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	
	/*
	MemberDao.login() : 아이디 비밀번호가 일치하는 회원이 있으면 Member객체 반환
						없으면 null 반환
	*/
	
	MemberDao dao = new MemberDao();
	
	Member member = dao.login(id, pw);
	
	if(member != null && !"".equals(id)){
		// 로그인 성공
		
		// 세션에 저장
		session.setAttribute("member", member);
		
		// response.sendRedirect("gogreen.jsp?name="+id);
		response.sendRedirect("login.jsp");
	}else{
		// 로그인 실패
		response.sendRedirect("login.jsp?loginErr=y");
	}
%>
</body>
</html>