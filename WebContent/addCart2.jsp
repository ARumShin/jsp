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
	if (id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	Product product = dao.getProductById(id);
	if(product == null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> goodsList = dao.getAllProducts();
	Product goods = new Product();
	for(int i=0;i<goodsList.size();i++){
		goods = goodsList.get(i);
		if(goods.getProductId().equals(id)){
			break;
		}
	}
	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<Product>();
		session.setAttribute("cartlist",list);
	}
	
	int cnt = 0;
	Product goodsQnt = new Product();
	for(int i=0;i<list.size();i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cnt++;
			int orderQuantity = goodsQnt.getQuantity()+1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	if(cnt == 0){
		goods.setQuantity(1);
		list.add(goods);
	}
	response.sendRedirect("product.jsp?id="+id);
%>
 --%>
 <%@page import="java.sql.*" %>
 <%@include file="dbconn.jsp" %>
 <%
 	String id=request.getParameter("id");
	if (id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	///ProductRepository dao = ProductRepository.getInstance();
		
	//Product product = dao.getProductById(id);
		//Product product = rs.
	/*if(product == null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> goodsList = dao.getAllProducts();
	Product goods = new Product();
	for(int i=0;i<goodsList.size();i++){
		goods = goodsList.get(i);
		if(goods.getProductId().equals(id)){
			break;
		}
	}*/
	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<Product>();
		session.setAttribute("cartlist",list);
	}
	
		//데이터베이스 접근
		PreparedStatement pstmt=null;
		ResultSet rs=null;
	
	int cnt = 0;
	Product goodsQnt = new Product();
	for(int i=0;i<list.size();i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cnt++;
			int orderQuantity = goodsQnt.getQuantity()+1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	if(cnt == 0){
		try{
			Product goods = new Product();
			String sql = "select * from product where p_id = ?";
			//String productId=request.getParameter("id");
			//String sql="select * from product where p_id=?";
			pstmt=conn.prepareStatement(sql);
			//pstmt.setString(1,productId);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			/*while(rs.next()){
				rs.getString("p_id");
			}
			*/
			while(rs.next()){
				goods.setPname(rs.getString("p_name"));
				goods.setProductId(rs.getString("p_id"));
				goods.setUnitPrice(rs.getInt("p_unitPrice"));
				//goods.setProductId(rs.getString("p_id"));
				goods.setQuantity(1);//첫번째 장바구니 담는거니까 수량은 1로 해준다.
				
				list.add(goods);
			}
			
			/*if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
			*/
		}catch(SQLException e){
			out.println("addCart.jsp 오류<br>");
			out.println("SQLException:"+e.getMessage());
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		//goods.setQuantity(1);
		//list.add(goods);
	}
	response.sendRedirect("product.jsp?id="+id);
	
 %>
 
</body>
</html>