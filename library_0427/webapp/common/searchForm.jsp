<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name='searchForm' action="../book/list.book">
<input type='hidden' name='pageNo' value='1'>
<!-- <input type='hidden' name='pageNo' value='${ empty pageNo && "" eq pageNo ? 1 : pageNo}'> -->
<input type='hidden' name='delNo'>
<table border='1' width='100%'>
	<tr>
		<td align="center">
			<select name='searchField'>
				<option value='title' ${param.searchField eq 'title' ? "selected" : "" }>제목</option>
				<option value='author' ${param.searchField eq 'author' ? "selected" : "" }>작가</option>
			</select>
			<input type="text" name="searchWord" value="${param.searchWord }">
			<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>
</body>
</html>