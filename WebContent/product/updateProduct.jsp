<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<!-- <link rel="stylesheet" href="./resources/css/bootstrap.min.css"/> -->
</head>
<body>
<%@page import="java.sql.*" %>
<%
	Product p=(Product)request.getAttribute("product");
	
	System.out.println("condition : " + p.getCondition());
%>

	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="${pageContext.request.contextPath }/resources/images/<%=p.getFilename()%>" alt="image" style="width:100%"/>
			</div>
			<div class="col-md-7">
				<form name="newProduct" action="${pageContext.request.contextPath }/ProductModifyAction.goods" class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<label class="col-sm-2">상품 코드</label>
						<div class="col-sm-3">
							<input type="text" id="productId" name="productId" class="form-control" value='<%=p.getProductId() %>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상품명</label>
						<div class="col-sm-3">
							<input type="text" id="name" name="name" class="form-control" value='<%=p.getPname() %>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">가격</label>
						<div class="col-sm-3">
							<input type="text" id="unitPrice" name="unitPrice" class="form-control" value='<%=p.getUnitPrice()%>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상세 설명</label>
						<div class="col-sm-5">
							<textarea name="description" cols="50" rows="2" class="form-control"><%=p.getDescription() %></textarea>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">제조사</label>
						<div class="col-sm-3">
							<input type="text" name="manufacturer" class="form-control" value='<%=p.getManufacturer()%>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">분류</label>
						<div class="col-sm-3">
							<input type="text" name="category" class="form-control" value='<%=p.getCategory()%>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">재고 수</label>
						<div class="col-sm-3">
							<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" value='<%=p.getUnitsInStock()%>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상태</label>
						<div class="col-sm-3">
							<input type="radio" name="condition" value="New"<%if(p.getCondition().equals("New")){ %>checked<%} %>>신규 제품
							<input type="radio" name="condition" value="Old"<%if(p.getCondition().equals("Old")){ %>checked<%} %>>중고 제품
							<input type="radio" name="condition" value="Refurbished"<%if(p.getCondition().equals("Refurbished")){ %>checked<%} %>>재생 제품
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">이미지</label>
						<div class="col-sm-3">
							<input type="file" name="productImage" class="form-control">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" value="등록">
						</div>
					</div>
				 </form>
			</div>
		</div>
	</div>
</body>
</html>