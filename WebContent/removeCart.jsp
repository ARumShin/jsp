<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.util.ArrayList" %>
<%@page import="dto.Product" %>
<%-- <%@page import="dao.ProductRepository" %> --%>
<%-- <%
	String id=request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	Product product = dao.getProductById(id);
	if(product == null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	Product goodsQnt = new Product();
	for(int i=0;i<cartList.size();i++){
		goodsQnt = cartList.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cartList.remove(goodsQnt);
	
		}
	}
	
	response.sendRedirect("cart.jsp");
%> --%>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<%
String pid=request.getParameter("pid");
if(pid == null || pid.trim().equals("")){
	response.sendRedirect("products.jsp");
	return;
}

/* ProductRepository dao = ProductRepository.getInstance();

Product product = dao.getProductById(id);
if(product == null){
	response.sendRedirect("exceptionNoProductId.jsp");
} */

// ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
// Product goodsQnt = new Product();
// for(int i=0;i<cartList.size();i++){
// 	goodsQnt = cartList.get(i);
// 	if(goodsQnt.getProductId().equals(id)){
// 		cartList.remove(goodsQnt);

// 	}
// }


	
	PreparedStatement pstmt=null;
	
	try{

		String sql = "delete from cart where m_id = ? and p_id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		pstmt.setString(2,pid);
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