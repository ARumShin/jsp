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
 <%@page import="java.sql.*" %>
 <%@include file="dbconn.jsp" %>
 <%
 	String pid=request.getParameter("pid");
	if (pid == null || pid.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	String sessionId=(String)session.getAttribute("sessionId");
	
// 	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
// 	if(list == null){
// 		list = new ArrayList<Product>();
// 		session.setAttribute("cartlist",list);
// 	}
	
		//데이터베이스 접근
	PreparedStatement pstmt=null;
	ResultSet rs=null;


	try{

		String sql = "select * from cart where m_id = ? and p_id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		pstmt.setString(2,pid);
		rs=pstmt.executeQuery();


		if(rs.next()){
			sql="UPDATE cart SET p_amount = p_amount+1, p_total=p_total+p_price WHERE m_id=? and p_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,sessionId);
			pstmt.setString(2,pid);
			pstmt.executeUpdate();
		}else{
			sql="select * from product where p_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,pid);
			rs=pstmt.executeQuery();
			
			Product p=new Product();
			if(rs.next()){
				
				p.setPname(rs.getString("p_name"));
				p.setUnitPrice(rs.getInt("p_unitPrice"));
			}
			
			sql="insert into cart (m_id,p_id,p_name,p_price,p_amount,p_total)values(?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,sessionId);
			pstmt.setString(2,pid);
			pstmt.setString(3,p.getPname());
			pstmt.setInt(4,p.getUnitPrice());
			pstmt.setInt(5,1);
			pstmt.setInt(6,p.getUnitPrice());
			pstmt.executeUpdate();
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
	response.sendRedirect(request.getContextPath()+"/Product.goods?pid="+pid);
	
 %>
 
</body>
</html>