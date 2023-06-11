<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 활용한 팝업창 제어 ver2.0</title>
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
</style>
<script>
// 페이지가 로드되면 실행
window.onload = function() {
	// 버튼이 클릭되면 함수를 실행
	closeBtn.onclick = function() {
		// 버튼이 클릭되면 팝업창 숨기기
		popup.style.display='none';
		
		var chkVal = document.querySelector("input[id=inactiveTday]:checked");
		
		if(chkVal == 1){
			// 쿠키 생성
			alert('쿠키생성');
		}
	}
}
</script>
</head>
<body>
<%
CookieManager.readCookie(request, "PopupClose");
%>
	<div id="popup">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
        </div>
	</div>
</body>
</html>