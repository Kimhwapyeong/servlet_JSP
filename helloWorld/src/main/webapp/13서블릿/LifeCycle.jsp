<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
function requestAction(form, type) {
	if(type == 1){
		form.method = 'get';		
	} else {
		form.method = 'post';		
	}
	form.submit();
}

</script>

<form action="./LifeCycle.do">
	<input type="button" value="Get방식 요청"
				onclick="requestAction(this.form, 1)">
	<input type="button" value="Post방식 요청"
				onclick="requestAction(this.form, 2)">
</form>



</body>
</html>