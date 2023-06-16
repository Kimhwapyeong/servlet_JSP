<%@page import="dto.PageDto"%>
<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.NewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<%
	// 검색 조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String pageNo = request.getParameter("pageNo");
	
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	NewBoardDao dao = new NewBoardDao();
	
	int total = dao.getTotalCnt(criteria); 
	PageDto pageDto = new PageDto(total, criteria);
	
	//List<Board> boardList = dao.getList(criteria);
	List<Board> boardList = dao.getListPage(criteria);
	
	//if(searchField != null && searchField){
	//	String titleSelected = searchField.equals("title") ? "selected" : "";
	//}
%>
<%@include file="../6세션/Link.jsp" %>
<body>
    <h2>목록 보기(List)</h2>
    <!-- 검색폼 --> 
    <form method="get" name="searchForm">  
    <input type="hidden" name="pageNo" value=<%=criteria.getPageNo() %>>
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title" <%="title".equals(searchField)?"selected":"" %>>제목</option> 
                <option value="content" <%="content".equals(searchField)?"selected":"" %>>내용</option>
            </select>
            <input type="text" name="searchWord" value="<%=searchWord==null?"":searchWord%>"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        <!-- 목록의 내용 --> 
		<% 
		if(boardList.isEmpty()){ %>
			<tr>
				<td colspan='5' style="text-align: center">게시물이 없습니다.</td>
			</tr>
		<%	
		}else{
			for(Board board : boardList){ %>
	        <tr align="center">
	            <td><%=board.getNum() %></td>  <!--게시물 번호-->
	            <td align="left">  <!--제목(+ 하이퍼링크)-->
	                <a href='View.jsp?num=<%=board.getNum() %>&pageNo=<%=criteria.getPageNo() %>' style='text-decoration:none'><%=board.getTitle() %></a>
	            </td>
	            <td align="center"><%=board.getId() %></td>          <!--작성자 아이디-->
	            <td align="center"><%=board.getVisitCount() %></td>  <!--조회수-->
	            <td align="center"><%=board.getPostDate() %></td>    <!--작성일-->
	        </tr>
					
			<%
			}
		}
		%>

    </table>
    <!--목록 하단의 [글쓰기] 버튼-->
    <%
    if(session.getAttribute("UserId") != null && !"".equals(session.getAttribute("UserId"))){
    %>
    <table border="1" width="90%">
        <tr align="right">
            <td><button type="button" onclick="location.href='Write.jsp'">글쓰기</button></td>
        </tr>
    </table>
    <%
    }
    %>
    <table border='1' width="90%">
		<tr align="center">
			<td><%@include file="../6세션/PageNavi.jsp" %></td>
		</tr>    
    </table>

    
</body>
</html>
