<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 처리</title>
</head>

<body>
	<%
		String id = (String)session.getAttribute("sessionId");
	String passwd = request.getParameter("passwd");
	Date now = new Date();
	SimpleDateFormat sf = 
	  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sf.format(now);
	%>
<%@include file="setDataSource.jsp" %>
	<sql:update dataSource="${dataSource}" var="resultSet">

		update member set deleteYn='Y', deldate=? where id=? and passwd=?
		<sql:param value="<%=today%>" />
		<sql:param value="<%=id%>" />
		<sql:param value="<%=passwd%>" />
	</sql:update>
<%
session.invalidate();
%>
	<c:redirect url="resultMember.jsp?gubun=delete" />
</body>
</html>