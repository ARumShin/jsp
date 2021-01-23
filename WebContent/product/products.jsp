<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
</head>

<body>
	<jsp:include page="../menu.jsp"/>

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
				
				<%
					ArrayList products=(ArrayList)request.getAttribute("productList");
					for(int i=0;i<products.size();i++){
						Product p=(Product)products.get(i);
					
				
				%>
				<div class="col-md-4">
						<img src="${pageContext.request.contextPath }/resources/images/<%=p.getFilename() %>" style="width:100%">
					<h3><%=p.getPname() %></h3>
					<h3><%=p.getDescription() %></h3>
				<h3><fmt:formatNumber value='<%=p.getUnitPrice()%>' pattern="#,###"/>원</h3>
				
				<p><a href="${pageContext.request.contextPath }/Product.goods?pid=<%=p.getProductId()%>"
				      class="btn btn-info" role="button">상세정보&raquo;</a>
					
				</div>

				<% 
					}
				%>
			</div>
<!-- 			<hr> -->
		</div>

	<jsp:include page="../footer.jsp"/>
</body>
</html>