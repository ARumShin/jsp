<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.util.*" %>
<%
	String id = (String)session.getAttribute("sessionId");
%>
<%-- <sql:setDataSource var="dataSource"  --%>
<%-- driver="com.mysql.jdbc.Driver" --%>
<%-- url="jdbc:mysql://localhost:3306/ap"  --%>
<%-- user="root" password="1234"/> --%>
<%-- <%@include file="setDataSource.jsp" %>
<sql:update dataSource="${dataSource}"
var="resultSet">
	delete from member where id=?
	<sql:param value="<%=id %>"/>
</sql:update>
<%
	session.invalidate();
%>
<c:redirect url="resultMember.jsp?gubun=delete"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제</title>
</head>
<body>
<form action="processDeleteMember.jsp">
회원 탈퇴 확인 
아이디 : <%=id %>
비밀번호 입력 <input type="text" name="passwd">
<button type="submit">삭제</button>
</form>
<%-- <%@ include file="../menu.jsp" %> --%>

</body>
</html>