<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pw");
	
	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);

	if(member != null){
		// 로그인 성공 -> 세션에 member 객체를 저장
		session.setAttribute("UserId", member.getId());
		session.setAttribute("member", member);
		
		response.sendRedirect("Board.jsp");
		
	} else {
		// 로그인 실패 -> loginForm 페이지로 이동
		request.setAttribute("LoginErrMsg", "아이디, 비밀번호가 일치하지 않습니다.");
		
		/// request에 setAtrribute 하므로 sendredirect하게 되면 저장되지 못함.
		// loinForm.jsp로 이동
		// request영역을 공유하기 위해 forward 사용
		request.getRequestDispatcher("LoginForm.jsp?").forward(request, response);
	}

%>


</body>
</html>