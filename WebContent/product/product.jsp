<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart(){
		
		if (confirm("상품을 장바구니에 추가하시겠습니까?")){
			/* if(confirm("로그인 하시겠습니까?")){
// 				url="./member/loginMember.jsp"
				location.replace("${pageContext.request.contextPath }/member/loginMember.jsp");
			} */
			<%
			String sessionId = (String) session.getAttribute("sessionId");
		if(sessionId==null || sessionId== ""){
			%> 
			var r=confirm("로그인 하시겠습니까?");
			if(r){
			location.href='${pageContext.request.contextPath}/member/loginMember.jsp';}
			else{
				return true;
			}
			return false;
			<%
		}
	%>
				document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
	<jsp:include page="../menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		Product p=(Product)request.getAttribute("product");
		
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="${pageContext.request.contextPath }/resources/images/<%=p.getFilename() %>" style="width:100%">
			</div>
			<div class="col-md-6">
				<h3><%=p.getPname()%></h3>
				<p><%=p.getDescription()%>
				<p><b>상품코드:</b><span class="badge badge-danger">
				<%=p.getProductId()%></span>
				<p><b>제조사</b>:<%=p.getManufacturer()%>
				<p><b>분류</b>:<%=p.getCategory()%>
				<p><b>재고수</b>:<%=p.getUnitsInStock()%>
				<h4><fmt:formatNumber value='<%=p.getUnitPrice()%>' pattern="#,###" />원</h4>
				
				<p><form name="addForm" action="./addCart.jsp?pid=<%=p.getProductId() %>" method="post">
				<p><a href="#" class="btn btn-success"  onclick="addToCart()">상품주문&raquo;</a>
				
				<a href="./cart.jsp" class="btn btn-warning">장바구니&raquo;</a>
				<a href="./ProductList.goods" class="btn btn-info">상품목록&raquo;</a>
				</form>
			</div>
		</div>
<!-- 		<hr> -->
	</div>	
	
	<jsp:include page="../footer.jsp"/>
</body>
</html>