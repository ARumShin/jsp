<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%-- <%@page import="dto.Product" %> --%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> --%>
<%@page import="mvc.model.CartItemDTO" %>
<%@page import="java.sql.Connection" %>
<%@page import="mvc.database.DBConnection" %>
<%@page import="java.sql.*" %>
<%
String sessionId = (String) session.getAttribute("sessionId");
// 	String loginUser = (String) session.getAttribute("loginUser");
	
// 	System.out.println(loginUser);
	ArrayList<CartItemDTO> cartList = (ArrayList<CartItemDTO>)request.getAttribute("cartList");
%>
<script>
	function checkOrder(){
	
						//#아이디명
						//해당 아이디 접근 , 그 값을 가져옴						
		var rowCount = $('#rowCount').val();
		
		alert("rowCount : " + rowCount); 
		if(rowCount<1){
			alert("카트가 비었습니다!");
			return false;
		}		
		return true;
	}
	function change(){
		
	}

</script>
<!DOCTYPE html>
<html>
<head>
<%
	String x=null;
	int rowCount = 0;
%>

<meta charset="UTF-8">
 <%@include file="dbconn.jsp" %>
<%
	
	int a=0;
	int sum=0;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{

		String sql = "select * from cart where m_id = ? ";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		rs=pstmt.executeQuery();

%>
<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?id=<%=sessionId%>" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?id=<%=sessionId%>" onclick="return checkOrder()"	class="btn btn-success" >주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top:50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th class="text-right">가격</th>
					<th class="text-right">수량</th>
					<th class="text-right">소계</th>
					<th>비고</th>
				</tr>
<!-- 				<form name="joinForm"> -->
				<%
				
				System.out.println("확인");
				while(rs.next()){
// 					x="1";
					rowCount ++;
					a=a+rs.getInt("p_amount");
					sum=sum+rs.getInt("p_total");
					System.out.println(rowCount);

				%>
				<tr>
					<td id="td_id"><%=rs.getString("p_id") %> - <%=rs.getString("p_name") %></td>
					<td id="td_price" class="text-right" ><fmt:formatNumber value='<%=rs.getInt("p_price") %>' pattern='#,###'/></td>
					<td id="td_amount" class="text-right">
<%-- 					<td class="text-right" id="pAmount"><fmt:formatNumber value='<%=rs.getInt("p_amount") %>' pattern="#,###"/> --%>
					
					<input type="text" class=" text-right amount" id="amount" name="amount" value="<%=rs.getInt("p_amount")%>" readonly>
				
					<a href="#" id="countup"onclick="countUp(this)">▲</a>
					<a href="#" id="countdown"onclick="countDown(this)">▼</a>
					</td>
					<td id="td_total" class="text-right"><fmt:formatNumber value='<%=rs.getInt("p_total") %>' pattern="#,###"/></td>
					<td><a href="./removeCart.jsp?pid=<%=rs.getString("p_id")%>" class="badge badge-danger">삭제</a></td>
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
<!-- 				</form> -->
				<tr>
					<th></th>
					<th></th>
					<th class="text-right">총수: <%=a %></th>
					<th class="text-right">총액: <fmt:formatNumber value="<%=sum %>" pattern="#,###"/></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-info"> &laquo; 쇼핑 계속하기</a>
			<input type="hidden" id="rowCount" name="rowCount" value="<%=rowCount %>">
		</div>
<!-- 		<hr> -->
	</div>
	<jsp:include page="footer.jsp"/>

</body>

<script>
	var request=new XMLHttpRequest();
	var sum=$('#td_sum');
	sum.text(sum.text().replace(/\B(?=(\d{3})+(?!\d))/g,","));
	function countUp(obj){
		var pidobj=$(obj).closest('tr').children('#td_id');
		
		var hyphen=pidobj.text().indexOf("-")-1;
		var pid=pidobj.text().substring(0,hyphen);
		request.open("Post","${pageContext.request.contextPath}/CartAmountUp.goods?pid="+encodeURIComponent(pid),true);
		request.onreadystatechange=aaa;
		request.send(null);
	}
	function countDown(obj){
		var qnt=$(obj).closest('tr').children('#td_amount').children(".amount");
		var pidobj = $(obj).closest('tr').children('#td_id');
	    if(qnt.val()>1){
	    var hyphen = pidobj.text().indexOf("-")-1;
	    
	    var pid = pidobj.text().substring(0,hyphen);
	    
	    request.open("Post", "${pageContext.request.contextPath}/CartAmountDown.goods?pid=" + encodeURIComponent(pid),true);
	    request.onreadystatechange = aaa;
	    request.send(null);
	    }
	}
	function aaa(){
		
		location.href="${pageContext.request.contextPath}/cart.jsp";
	}
</script>
</html>