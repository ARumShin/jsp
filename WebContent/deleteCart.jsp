<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="dto.Product" %>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%-- <%@ page import="dao.ProductRepository" %> --%>
<%
// 	String id = request.getParameter("cartId");
/* if(id == null||id.trim().equals("")){
	response.sendRedirect("cart.jsp");
	return;
} */
// session.invalidate(); 로그아웃
	String sessionId = (String) session.getAttribute("sessionId");
%>
<%


	PreparedStatement pstmt=null;
	
	try{

		String sql = "delete from cart where m_id = ?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		pstmt.executeUpdate();
	
}catch(Exception e){
	e.getMessage();
}finally{
	if(pstmt!=null)pstmt.close();
	if(conn!=null)conn.close();
}


response.sendRedirect("cart.jsp");
%>
</body>
</html>