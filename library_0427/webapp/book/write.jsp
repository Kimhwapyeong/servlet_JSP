<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<link rel="stylesheet" href="../css/list_style.css">
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
        if (form.name.value == "") {
            alert("작성자를 입력하세요.");
            form.name.focus();
            return false;
        }
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
        if (form.pass.value == "") {
            alert("비밀번호를 입력하세요.");
            form.pass.focus();
            return false;
        }
    }
</script>
</head>
<jsp:include page="../common/header.jsp"></jsp:include>
<form name="writeFrm" method="post" enctype="multipart/form-data"
      action="./write.book" onsubmit="return validateForm(this);">
<h2>책 등록하기</h2>
<table border="1" width="100%">
    <tr>
        <td>작성자</td>
        <td>
            <input type="text" name="id" style="width:150px;" value="${sessionScope.userId }"  readonly="readonly"/>
        </td>
    </tr>
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="title" style="width:150px;" />
        </td>
    </tr>
    <tr>
        <td>작가</td>
        <td>
            <input type="text" name="author" style="width:150px;" />
        </td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <textarea name="content" style="width:300px;height:100px;"></textarea>
        </td>
    </tr>
    <tr>
        <td>책 이미지</td>
        <td>
            <input type="file" name="bookImg" />
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
        	<!-- 글쓰기 버튼 클릭하면 글 등록 -->
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='./list.book';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</body>
</html>