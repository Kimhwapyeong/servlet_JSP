<!-- 

jsp : 동적인 페이지를 작성하기 위해서 JAVA라는 언어를 사용!

지시어(Directive)
jsp페이지를 servlet코드로 변환하는데 필요한 정보

지시어의 종류
	page	:	JSP페이지에 대한 정보를 설정
	include :	외부 파일을 현재 JSP페이지에 포함시킴
	taglib	:	표현언어에서 사용할 자바 클래스나 JSTL을 선언
	
작성방법
	< %@ 지시어종류 속성1="값",... (속성 나열) %>
	
jsp 파일 생성시 기본인코딩을 변경하는 방법
	window > preferences > JSP Files 선택 > encoding utf-8 선택
-->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>집에 가고싶은 나의 마음</title>
</head>
<body>
	<h1>집에 가자~</h1>
	<img src="https://t1.daumcdn.net/cfile/tistory/997D193C5F389B0B1E" style="" srcset="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&amp;fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F997D193C5F389B0B1E" width="800" height="486" filename="house3.PNG" filemime="image/jpeg">
</body>
</html>