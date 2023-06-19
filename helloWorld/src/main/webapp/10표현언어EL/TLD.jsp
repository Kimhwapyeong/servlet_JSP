<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
		TLD(Tag Library Descriptor)
			JSP에서 사용되는 커스텀태그나 JSTL의 태그들에 대한 설정파일
			WEB-INF 하위 위치에 작성해야 인식 가능함!
			
		prefix : EL에서 사용할 접두어
		uri : tld 파일의 경로
	 -->
	 <%@taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld" %>
	 <%
	 	pageContext.setAttribute("response", response);
	 %>

	
	 <h3>TLD 파일에 등록 후 메소드 호출하기</h3>
	 <ul>
	 	<li>${mytag:isNumber("100") }</li>
	 	<li>${mytag:isNumber("백") }</li>
	 	<li>${mytag:makeCookie("myCookie", "쿠키쿠키", 10, response) }
	 		${cookie.myCookie.value }
	 </ul>
	 	
	 
</body>
</html>