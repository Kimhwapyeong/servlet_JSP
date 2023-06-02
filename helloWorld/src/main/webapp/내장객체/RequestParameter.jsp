<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 한글깨짐 처리 -->
<%
	// 한글 깨짐 처리 => web.xml 설정파일에서 설정
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String sex = request.getParameter("sex");
	
	// 줄바꿈이 있는 경우 \r\n -> <br>
	String intro = request.getParameter("intro");
	
	// 체크박스는 여러개가 선택될 수 있기 때문에 배열 형태로 받아서 처리해야 한다
	String[] favo = request.getParameterValues("favo");
	String favoStr = "";
	out.print(Arrays.toString(favo));

	for(String fav : favo){
		favoStr += fav + " ";
	}
%>
<ul>
	<li>아이디 : <%= id %></li>
	<li>성별 : <%= sex %></li>
	<li>관심사 : <%= favoStr %></li>
	<!-- 줄바꿈 처리 -->
	<li>자기소개 : <br><b style="font-size:3em"><%= intro.replace("\r\n", "<br>") %></b></li>
</ul>
</body>
</html>