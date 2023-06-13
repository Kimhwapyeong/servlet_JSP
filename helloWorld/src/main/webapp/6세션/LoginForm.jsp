<%@page import="dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>Session</title></head>
<body>
	<jsp:include page="Link.jsp" />
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;"> 
    </span>
<%
	String ErrMsg = (String)request.getAttribute("LoginErrMsg");
	
	if(ErrMsg != null){
		out.print(ErrMsg);
	} /// 선생님은 다르게 함 확인해볼 것.
	
%>

<%
	Member member = (Member)session.getAttribute("member");
	if(member != null && ErrMsg == null){
		out.print("<h2>" + member.getName() + "님 환영합니다.</h2>");
	} else { %>
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);">
        아이디 : <input type="text" name="user_id" required="required"/><br />
        패스워드 : <input type="password" name="user_pw" required="required"/><br />
        <input type="submit" value="로그인하기" />
    </form>

<%		
	}
%>
    
</body>
</html>