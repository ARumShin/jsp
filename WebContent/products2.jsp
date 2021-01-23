<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page import="java.util.ArrayList" %> --%>
<%-- <%@ page import="dto.Product" %> --%>
<%-- <%@ page import="dao.ProductRepository" %> --%>
<%@page import="java.sql.*" %>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/> --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
<!-- 	<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/> -->
<meta charset="UTF-8">
<title>상품 목록</title>
</head>

<body>
	<jsp:include page="menu.jsp"/>

		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">상품 목록</h1>
			</div>
		</div>
		
	<%-- 	<%
			//ArrayList<Product> listOfProducts=productDAO.getAllProducts();
		
			ProductRepository dao=ProductRepository.getInstance();//dao인스턴스 생성
			ArrayList<Product> listOfProducts=dao.getAllProducts();//dao인스턴스 사용
		%> --%>
		
		<div class="container">
			<div class="row" align="center">
				<%-- <%
					for(int i=0;i<listOfProducts.size();i++){
						Product product=listOfProducts.get(i);
					
				%> --%>
				<%@include file="dbconn.jsp" %>
				<%
					PreparedStatement pstmt=null;
					ResultSet rs=null;
					String sql="select * from product";
					pstmt=conn.prepareStatement(sql);
					rs= pstmt.executeQuery();
					while(rs.next()){
				%>
				<div class="col-md-4">
						<img src="${pageContext.request.contextPath }/resources/images/<%=rs.getString("p_fileName") %>" style="width:100%">
					<h3><%-- <%=product.getPname() %> --%><%=rs.getString("p_name") %></h3>
<%-- 					<h3><%=product.getDescription()%><%=rs.getString("p_description") %></h3> --%>
				<h3><fmt:formatNumber value='<%=rs.getString("p_UnitPrice")%>' pattern="#,###"/>원</h3>
				
				<p><a href="./product.jsp?id=<%=rs.getString("p_id")%>"
				      class="btn btn-info" role="button">상세정보&raquo;</a>
					
				</div>
				<%} %>
				<% 
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				%>
			</div>
<!-- 			<hr> -->
		</div>

	<jsp:include page="footer.jsp"/>
</body>
</html>