<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 등록</title>
<script type="text/javascript" src="./resources/js/validation.js"></script>
</head>
<body>
<!-- 20200612 다국어 처리하기 -->
<fmt:setLocale value='<%=request.getParameter("language") %>'/>
<fmt:bundle basename="bundle.message">
	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
<%-- 			<h1 class="display-3"><fmt:message key="title"/></h1> --%>
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<div class="container">
<!-- 	<div class="text-right"> -->
<!-- 		<a href="?language=ko">Korean</a>|<a href="?language=en">English</a> -->
<!-- 	<a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a> -->
<!-- 	</div> -->
		<form name="newProduct" action="/ProductAddAction.goods" 
		class="form-horizontal" method="post"
		enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" name="productId" class="form-control"
					id="productId">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="name" class="form-control"
					id="name">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="text" name="unitPrice" class="form-control"
					id="unitPrice">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">설명</label>
				<div class="col-sm-5">
					<textarea name="description"cols="50"rows="2" class="form-control">
					</textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-3">
					<input type="text" name="unitsInStock" class="form-control"
					id="unitsInStock">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">
<%-- 				<fmt:message key="condition"/> --%>상태
				</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New">
<%-- 					<fmt:message key="condition_New"/> --%>새거
					<input type="radio" name="condition" value="Old">
<%-- 					<fmt:message key="condition_Old"/> --%>중고
					<input type="radio" name="condition" value="Refurbished">
<%-- 					<fmt:message key="condition_Refurbished"/> --%>재생상품
				</div>
			</div>
			
			<!-- 2020.06.10 파일업로드 추가 244p-->
			<div class="form-group row">
				<label class="col-sm-2">이미지</label>
				<div class="col-md-5">
				<!-- 1. col-xs-숫자:항상 가로로 배치 
						xs,md,lg
					 2. col-sm-숫자:가로가768px이상일때만 가로표시
					 3.col-md-숫자:가로가 992px이상일때만 가로표시
					 4. col-lg-숫자:가로가 1200px이상일때만 가로표시
				
				-->
					<input type="file"name="productImage" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="등록" onclick="CheckAddProduct()">
				</div>
			</div>
		</form>
	</div>
</fmt:bundle>
</body>
</html>