<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	BoardDao boardDao = new BoardDao();
	List<Board> list = boardDao.getList();
	
	int totalCnt = boardDao.getTotalCnt();
	
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	
	// 검색어가 null이 아니면 검색 기능을 추가
	out.print((searchWord==null || searchWord.equals(""))?"":searchField);
	out.print(searchWord==null?"":searchWord);
%>

<jsp:include page="Link.jsp"></jsp:include>
<h2>목록보기(List)</h2>
총 건수 : <%=totalCnt %>

<form>
<table border='1' width="90%">
	<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord" value="<%=searchWord==null?"":searchWord%>">
			<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>

<table border='1' width="90%">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>		
	</tr>
	<%
	if(list.isEmpty()){
		// 게시글이 하나도 없을때
	%>
		<tr>
			<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
		</tr>
	<% 
	} else {
		for(Board board : list){
	%>
		<tr>
			<td><%=board.getNum() %></td>
			<td><a href="" style='text-decoration:none'><%=board.getTitle() %></a></td>
			<td><%=board.getId() %></td>
			<td><%=board.getVisitCount() %></td>
			<td><%=board.getPostDate() %></td>
		</tr>
		<% 
		} 
	}
	%>
</table>

<table border='1' width="90%">
	<tr>
		<td align="right">
			<input type="submit" value="글쓰기">
		</td>
	</tr>
</table>

</body>
</html>