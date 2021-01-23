<%@page import="mvc.model.cart.ShippingInfoVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.net.URLDecoder" %>
<%@page import="dto.Product" %>
<%-- <%@page import="dao.ProductRepository" %> --%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@page import="java.sql.*" %>
 <%@include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

// 	String cartId = session.getId();
	
	String shipping_cartId="";
	String shipping_name="";
	String shipping_shippingDate="";
	String shipping_country="";
	String shipping_zipCode="";
	String shipping_addressName="";
	String shipping_addressName2="";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies !=null){
		for(int i=0;i<cookies.length;i++){
			Cookie thisCookie=cookies[i];
			String n=thisCookie.getName();
			if(n.equals("Shipping_cartId")){
				shipping_cartId=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_name")){
				shipping_name=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_shippingDate")){
				shipping_shippingDate=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_country")){
				shipping_country=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_zipCode")){
				shipping_zipCode=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_addressName")){
				shipping_addressName=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if(n.equals("Shipping_addressName2")){
				shipping_addressName2=URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			
		}
	}
// ShippingInfoVO c= (ShippingInfoVO)request.getAttribute("shippingInfo");

// System.out.println("확인 : " + c);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 성명: <% out.println(shipping_name); %> <br>
				우편번호: <% out.println(shipping_zipCode); %> <br>
				주소: <% out.println(shipping_addressName); %> <br>
				<% out.println(shipping_addressName2); %> <br>
<%-- 				(<% out.println(shipping_country); %>)<br> --%>
			</div>
			<div class="col-4" align="right">
				<p> <em>배송일: <% out.println(shipping_shippingDate); %></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">
			<tr>
				<th class="text-center">도서</th>
				<th class="text-center">#</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<%-- <%
			int a=0;
				int sum=0;
				ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
				if(cartList==null){
					cartList=new ArrayList<Product>();
				}
				for(int i=0;i<cartList.size();i++){
					Product product=cartList.get(i);
					int total=product.getUnitPrice()*product.getQuantity();
					sum=sum+total;
					a+=product.getQuantity();
			%> --%>
			
			<%
			String sessionId = (String) session.getAttribute("sessionId");
	int a=0;
	int sum=0;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{

		String sql = "select * from cart where m_id = ? ";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		rs=pstmt.executeQuery();

		while(rs.next()){
			a=a+rs.getInt("p_amount");
			sum=sum+rs.getInt("p_total");
%>
			<tr>
				<td class="text-center"><em><%=rs.getString("p_name") %></em></td>
				<td class="text-center"><%=rs.getInt("p_amount") %></td>
				
				<td class="text-center"><fmt:formatNumber value='<%=rs.getInt("p_price")%>' pattern="#,###"/></td>
				<td class="text-center"><fmt:formatNumber value='<%=rs.getInt("p_total")%>' pattern="#,###"/></td>
			</tr>			
			<%
		}
	}catch(Exception e){
		e.getMessage();
	}finally{
		if(rs!=null)rs.close();
		if(pstmt!=null)pstmt.close();
		if(conn!=null)conn.close();
	}
	
			%>
			<tr>
				<td></td>
				<td class="text center text-danger"><strong>총 갯수: <%=a %></strong></td>
				<td class="text-right"><strong>총액: </strong></td>
				<td class="text-center text-danger" ><strong><fmt:formatNumber value='<%=sum %>' pattern="#,###"/></strong></td>
			</tr>
			</table>
			<%
				String orderNo = "";
			
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
				
				orderNo += sdf.format(date);
				orderNo += "#" + sessionId;
				
			%>
			<a href="./shippingInfo.jsp?cartId=<%=sessionId%>" class="btn btn-secondary" role="button">이전</a>
			<a href="./processOrderConfirmation.jsp" class="btn btn-success" role="button">주문 완료</a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
		</div>
	</div>
</body>
</html>