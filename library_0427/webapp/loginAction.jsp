<%@page import="com.utils.test"%>
<%@page import="com.library.vo.Member"%>
<%@page import="com.library.service.MemberService"%>
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
	
	// lib 이동
	// java resources -> webapp/WEB-INF/lib
	MemberService service = new MemberService();
	
	Member member = service.login(id, pw);
	
	// 아이디 쿠키에 저장	
	String saveYN = request.getParameter("saveYN");
	if("Y".equals(saveYN)){
		test.makeCookie("userId", id, 3600, response);
	}
	
	//out.print("member : " + member);
	if(member != null){
		//response.sendRedirect("login.jsp?name=" + member.getId());
		session.setAttribute("member", member);
		
		if(member.getId().equals("admin")){

	// 관리자 페이지 호출
	response.sendRedirect("loginAdmin.jsp");
		}else{

	// 사용자 페이지 호출
	response.sendRedirect("loginMember.jsp");
		}
	}else{
		response.sendRedirect("login.jsp?loginErr=Y");
	}
%>
</body>
</html>