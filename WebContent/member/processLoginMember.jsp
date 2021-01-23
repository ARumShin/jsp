<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String passwd = 
			request.getParameter("password");
	%>
	
<%@include file="setDataSource.jsp" %>
		
<%-- 	 <sql:query --%>
<%-- 	      dataSource="${dataSource}" --%>
<%-- 	      var="resultSet"> --%>
	      
<!-- 	      select *  -->
<!-- 	        from member -->
<!-- 	       where id = ? -->
<!-- 	         , passwd = ? -->

<%-- 		  <sql:param value="<%=id%>" /> --%>
<%-- 		  <sql:param value="<%=passwd%>" /> --%>
<%-- 	 </sql:query> --%>
<%@include file="../dbconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql="select * from member where id=? and passwd=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1,id);
	pstmt.setString(2,passwd);
	rs=pstmt.executeQuery();
	if(rs.next()){
		if(rs.getString("deleteYn").equals("Y")){
			response.sendRedirect("resultMember.jsp?gubun=loginError");
		}else{
			session.setAttribute("sessionId", id);
			response.sendRedirect("resultMember.jsp?gubun=login");
		}
	}
%>
 
<%-- 	 <c:if test="${resultSet.rowCount > 0}"> --%>
	 	
<%-- 	  <% --%>
// 	 	session.setAttribute("sessionId",id);
<%-- 	  %> --%>
<%-- 	  <c:redirect url="resultMember.jsp?gubun=login"/> --%>
<%-- 	 </c:if> --%>
	 
<%-- 	 <c:if test="${resultSet.rowCount == 0}"> --%>
<%-- 	 	<c:redirect url="resultMember.jsp?gubun=loginError"/> --%>
	 
<%-- 	 </c:if>	 --%>
	 	
	 
	 	
	
</body>
</html>

