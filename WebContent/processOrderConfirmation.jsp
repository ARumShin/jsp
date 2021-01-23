<%@page import="java.net.URL"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");

// PreparedStatement pstmt=null;
CallableStatement cstmt=null;

Date date=new Date();
SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
String currentDate=sdf.format(date);

String orderNo=sessionId+"@"+currentDate;
//쿠키 만들고 반영하는 과정
Cookie orderNumber=new Cookie("Shipping_orderNo", URLEncoder.encode(orderNo,"UTF-8"));
orderNumber.setMaxAge(24*60*60);
response.addCookie(orderNumber);

String shipping_cartId="";
String shipping_name="";
String shipping_shippingDate="";
String shipping_zipCode="";
String shipping_addressName="";
String shipping_addressName2="";

Cookie[] cookies=request.getCookies();

if(cookies!=null){
	for(int i=0;i<cookies.length;i++){
		Cookie thisCookie=cookies[i];
		String n=thisCookie.getName();
		if(n.equals("Shipping_name")){
			System.out.println("case 1");
			shipping_name=URLDecoder.decode((thisCookie.getValue()),"UTF-8");
		}
		if(n.equals("Shipping_shippingDate")){
			System.out.println("case 2");
			shipping_shippingDate=URLDecoder.decode((thisCookie.getValue()),"UTF-8");
		}
		if(n.equals("Shipping_zipCode")){
			System.out.println("case 3");
			shipping_zipCode=URLDecoder.decode((thisCookie.getValue()),"UTF-8");
		}
		if(n.equals("Shipping_addressName")){
			System.out.println("case 4");
			shipping_addressName=URLDecoder.decode((thisCookie.getValue()),"UTF-8");
		}
		if(n.equals("Shipping_addressName2")){
			System.out.println("case 5");
			shipping_addressName2=URLDecoder.decode((thisCookie.getValue()),"UTF-8");
		}
	}
}
try{
	cstmt= conn.prepareCall("{call orderComplete(?,?,?,?,?,?,?)}");
	cstmt.setString(1,orderNo);
	cstmt.setString(2,sessionId);
	cstmt.setString(3,shipping_name);
	cstmt.setString(4,shipping_shippingDate);
	cstmt.setString(5,shipping_zipCode);
	cstmt.setString(6,shipping_addressName);
	cstmt.setString(7,shipping_addressName2);
	
	System.out.println("orderNo  : "+orderNo);
	System.out.println("sessionId : "+sessionId);
	System.out.println("name : " + shipping_name);
	System.out.println("date : " + shipping_shippingDate);
	System.out.println(shipping_zipCode);
	System.out.println(shipping_addressName);
	System.out.println(shipping_addressName);
	System.out.println("address2 : " + shipping_addressName2);
	
	cstmt.execute();

}catch(Exception e){
e.printStackTrace();
}finally{
if(cstmt!=null)cstmt.close();
if(conn!=null)conn.close();
}


response.sendRedirect("thankCustomer.jsp");
%>
%>
</body>
</html>