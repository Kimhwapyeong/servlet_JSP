<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.DBConnPool"%>
<%@page import="java.sql.Connection"%>
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

	Connection conn = DBConnPool.getConnection();

	PreparedStatement psmt = conn.prepareStatement("select sysdate from dual");
	
	ResultSet rs = psmt.executeQuery();
	
	if(rs.next()){
		out.print(rs.getString(1));
	}
	
	rs.close();
	psmt.close();
	conn.close();

%>

</body>
</html>