<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.*" %>
<%
	Connection conn=null;

	try{
// 		String url="jdbc:mysql://localhost:3306/ap";
// 		String user="root";
String url="jdbc:mysql://34.64.186.191:3306/ap";
		String user="shin";
		String password="0323";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		conn=DriverManager.getConnection(url,user,password);
		
	}catch(SQLException ex){
		out.println("데이터베이스 연결 실패<br>");
		out.println("SQLException:"+ex.getMessage());
		
	}
%>

</body>
</html>