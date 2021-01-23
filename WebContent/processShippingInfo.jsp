<%@page import="mvc.model.cart.ShippingInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

// 	Cookie cartId = new Cookie("Shipping_cartId",URLEncoder.encode(request.getParameter("cartId"),"utf-8"));
	Cookie name=new Cookie("Shipping_name",URLEncoder.encode(request.getParameter("name"),"utf-8"));
	Cookie shippingDate=new Cookie("Shipping_shippingDate",URLEncoder.encode(request.getParameter("shippingDate"),"utf-8"));
// 	Cookie country=new Cookie("Shipping_country",URLEncoder.encode(request.getParameter("country"),"utf-8"));
	Cookie zipCode=new Cookie("Shipping_zipCode",URLEncoder.encode(request.getParameter("zipCode"),"utf-8"));
	Cookie addressName=new Cookie("Shipping_addressName",URLEncoder.encode(request.getParameter("addressName"),"utf-8"));
	Cookie addressName2=new Cookie("Shipping_addressName2",URLEncoder.encode(request.getParameter("addressName2"),"utf-8"));
	
// 	cartId.setMaxAge(24*60*60);
	name.setMaxAge(24*60*60);
	zipCode.setMaxAge(24*60*60);
// 	country.setMaxAge(24*60*60);
	addressName.setMaxAge(24*60*60);
	addressName2.setMaxAge(24*60*60);
	
// 	response.addCookie(cartId);
	response.addCookie(name);
	response.addCookie(shippingDate);
// 	response.addCookie(country);
	response.addCookie(zipCode);
	response.addCookie(addressName);
	response.addCookie(addressName2);
// ShippingInfoVO info=new ShippingInfoVO();
// info.setCartId(request.getParameter("cartId"));
// info.setName(request.getParameter("name"));
// info.setZipCode(request.getParameter("zipCode"));
// info.setCountry(request.getParameter("country"));
// info.setAddressName(request.getParameter("addressName"));
// info.setAddressName2(request.getParameter("addressName2"));



// request.setAttribute("shippingInfo",info);

// RequestDispatcher dispatcher=request.getRequestDispatcher("orderConfirmation.jsp");
// dispatcher.forward(request,response);
response.sendRedirect("orderConfirmation.jsp");
%>
</body>
</html>