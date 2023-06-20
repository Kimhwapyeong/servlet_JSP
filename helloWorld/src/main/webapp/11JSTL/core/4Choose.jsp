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
	<h4>choose 다중 조건문</h4>
	
	<h4>홀짝 판단하기</h4>
	<!-- 변수 선언 -->
	<c:set var="number" value="100"/>
	<!-- 다중 조건문 사용하기 -->
	<c:choose>
		<c:when test="${number mod 2 eq 0 }">
			${number }는(은) 짝수 입니다.
		</c:when> 
		
		<c:otherwise>
			${number }는(은) 홀수 입니다.
		</c:otherwise>
	</c:choose>
	
	<h4>국, 영, 수 점수를 입력하면 평균을 내어 학점을 출력</h4>
	<p>>=90 : A학점, >=80 : B학점, >=70 : C학점, >=60 : D학점</p>
	<form>
		국어 : <input type="text" name="kor"><br>
		영어 : <input type="text" name="eng"><br>
		수학 : <input type="text" name="math"><br>
		<input type="submit" value="학점 구하기">
	</form>
	
	
	<!-- 모든 과목의 점수가 입력되었는지 확인 -->
	<c:if test="${ not (empty param.kor or empty param.eng or empty param.math) }" var="result">
		
		<!-- 점수 출력 -->
		국어점수 : ${param.kor }<br>
		영어점수 : ${param.eng }<br>
		수학점수 : ${param.math }<br>
		
		<!-- 평균점수 계산 -->
		<c:set var="avg" value="${ (param.kor + param.eng + param.math) div 3 }"/>
		
		<!-- 학점 출력 -->
		<c:choose>
			<c:when test="${ avg ge 90 }">
				평균 점수는 ${ avg }이고, 학점은 A학점 입니다.
			</c:when>
			<c:when test="${ avg ge 80 }">
				평균 점수는 ${ avg }이고, 학점은 B학점 입니다.
			</c:when>
			<c:when test="${ avg ge 70 }">
				평균 점수는 ${ avg }이고, 학점은 C학점 입니다.
			</c:when>
			<c:when test="${ avg ge 60 }">
				평균 점수는 ${ avg }이고, 학점은 D학점 입니다.
			</c:when>
			<c:otherwise>
				평균 점수는 ${ avg }이고, 학점은 F학점 입니다.
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test="${ not result }">
		점수를 모두 입력해주세요.
	</c:if>
</body>
</html>