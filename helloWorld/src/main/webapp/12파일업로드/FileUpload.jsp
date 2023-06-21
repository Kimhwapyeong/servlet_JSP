<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function validateForm(form) {
		alert(form.name.value);
		alert(form.attachedFile.value);
		if(form.attachedFile.value == ""){
			return false;		
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	
	<h3>파일 업로드</h3>
	
	<!-- 
	파일을 업로드 
	라이브러리(cos.jar) 추가 후 form태그의 속성을 설정
	
	<< form태그의 속성 설정 >>
		method	: post
		enctype	: multipart/form-data
	-->
	<!-- 
	유효성 검사, validation체크
	사용자입력체크 로직 추가 -->
	<form action="UploadProcess.jsp" method="post" 
			enctype="multipart/form-data"
			onsubmit="return validateForm(this);">
	
		<p>
			작성자 : <input type="text" name="name" value="하니">
		</p>
		<p>
			제목 : <input type="text" name="title" value="제목">
		</p>
		<p>
			카테고리 : 
			<input type="checkbox" name="category" value="사진" checked>사진
			<input type="checkbox" name="category" value="과제">과제
			<input type="checkbox" name="category" value="워드">워드
			<input type="checkbox" name="category" value="음원">음원
		</p>
		<p>
			첨부 파일 : <input type="file" name="attachedFile">
		</p>
		
		<input type="submit" value="전송하기">
	</form>
	
	<!-- 
		enctype : form값을 서버로 전송할때의 인코딩 방식을 지정
			
			- application/x-www-form-urlencoded (기본값)
				모든 문자를 서버로 전송하기 전에 인코딩 합니다.
			
			- multipart/form-data
				<form>태그를 통해 파일을 서버로 전송할 때 사용 합니다.
				모든 문자를 인코딩 하지 않습니다.
	 -->
	
</body>
</html>