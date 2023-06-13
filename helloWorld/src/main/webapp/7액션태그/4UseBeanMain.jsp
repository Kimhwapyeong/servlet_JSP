<%@page import="dto.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션태그 - UseBean</title>
</head>
<body>
<%
/*
자바빈 이란?
	요청발생시 화면으로 부터 입력받은 데이터를 하나의 객체 담아 편리하게 사용할 수 있습니다.
	JSP 페이지간의 데이터 전달할 경우 자바빈을 이용합니다. 
	표준 액션태그를 이용해 자바빈을 활용하면 코드가 간결해집니다.

자바빈으로 생성될수 있는 객체(DTO/VO)
	- 자바빈은 기본(default)패키지 이외의 패키지에 속해 있어야 한다.
	- 기본 생성자가 존재해야 한다.
	- 멤버변수의 접근제어자는 private로 선언되어야 한다.
	- 멤버변수에 접근 가능한 getter 와 setter 메서드가 존재해야 한다.
	- getter 와 setter는 접근자가 public으로 선언되어야 한다.
	
	
<jsp:useBean> 		: 자바빈을 생성합니다
<jsp:setProperty> 	: 자바빈 속성을 저장 합니다
<jsp:getProperty> 	: 자바빈 속성을 추출 합니다 
*/
%>

	<h2>useBean 액션태그</h2>
	<h3>자바빈스 생성하기</h3>
	
	<!-- 
		id		: 자바빈즈 이름
		class	: 패키지명을 포함한 클래스명
		scope	: 저장될 영역
		
		dto패키지의 Person 객체를 생성후 request영역에 저장
		액션태그를 이용해서 자자빈을 생성시 기본생성자를 이용
		값을 세팅하기 위해서는 jsp:setProperty태그를 이용
	 -->
	<jsp:useBean id="person" class="dto.Person" scope="request"></jsp:useBean>
	
	<h3>setProperty 액션 태그로 자바빈스 속성 지정하기</h3>
	
	<!-- 
		name		: 자바빈스 이름
		property	: 필드명
		value		: 필드값
	 -->
	<jsp:setProperty property="name" name="person" value="하니"/>
	<jsp:setProperty property="age" name="person" value="20"/>
	
	<h3>getProperty 액션 태그로 자바빈스 속성 읽기</h3>
	<ul>
		<li>이름 : <jsp:getProperty property="name" name="person"/></li>
		<li>나이 : <jsp:getProperty property="age" name="person"/></li>
	</ul>	
	
	<h3>request 객체를 이용하여 자바빈스 속성 읽기</h3>
	<%
		Person p = (Person)request.getAttribute("person");
	%>
	이름 : <%=p.getName() %><br>
	나이 : <%=p.getAge() %>
</body>
</html>