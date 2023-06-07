<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>

<%
	
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pwd");
	
	out.print("id : " + id + "<br>");
	out.print("pw : " + pw + "<br>");
	
	// 아디가 abc, 비밀번호 123
	/// equals() 메소드에서 반대로 쓰면 null 체크를 해주어야함
	if("abc".equals(id) && "123".equals(pw)){
		// 로그인 성공
		out.print("로그인 성공");
		// 요청할 페이지 정보
		response.sendRedirect("ResponseWelcome.jsp");
	}else{
		// 로그인 실패
		out.print("로그인 실패");
		response.sendRedirect("ResponseMain.jsp?loginErr=1");
	}
%>
</body>
</html>