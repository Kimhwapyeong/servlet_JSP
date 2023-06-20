<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>url태그를 이용해서 릴크 걸기</h4>
	<!-- 
		c:URL
		지정한 경로와 매개변수를 이용해서 컨텍스트루트를 포함한 URL을 생성합니다.
		a태그의 href속성이나 form태그의 action속성에 이용할 수 있습니다.
		
		value	: 경로
		var		: 변수명
	-->
	
	<a href="/11JSTL/inc/OtherPage.jsp">페이지 바로가기</a><br>
	
	<c:url value="/11JSTL/inc/OtherPage.jsp" var="url"></c:url>
	<a href="${url }">url 태그를 이용한 바로가기</a>
	
	<form action="${url }">
		<button>전송</button>
	</form>
	
	<h4>예외처리</h4>
	<!-- 
	c:catch 태그
		예외가 발생하면 지정한 변수에 에러메시지가 저장되어 전달
	-->
	
	<%
		int num1 = 100;
	%>
	<c:catch var="eMessage">
		<%
			int res = num1/0;
		%>
	</c:catch>
	
	예외내용 : ${eMessage }
	
	<h4>EL에서의 예외</h4>
	<c:set var="num2" value="200"></c:set>
	
	<c:catch var="eMessage">
	${"일" + num2 }
	</c:catch>
	${eMessage }
	
	
</body>
</html>