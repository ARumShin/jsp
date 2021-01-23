package mvc.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Product;
import mvc.database.DBConnection;

public class GoodsDAO {
	private static GoodsDAO instance;
	private GoodsDAO() {}

	public static GoodsDAO getInstance() {
		if(instance==null)
			instance=new GoodsDAO();
		return instance;
	}
	
	public ArrayList<Product> getProductList(){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		sql="select * from product";
		
		ArrayList<Product> list=new ArrayList<Product>();
		try {
			conn=DBConnection.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Product p=new Product();
				p.setProductId(rs.getString("p_id"));
				p.setPname(rs.getString("p_name"));
				p.setUnitPrice(rs.getInt("p_unitPrice"));
				p.setDescription(rs.getString("p_description"));
				p.setCategory(rs.getString("p_category"));
				p.setManufacturer(rs.getString("p_manufacturer"));
				p.setUnitsInStock(rs.getInt("p_unitsInStock"));
				p.setCondition(rs.getString("p_condition"));
				p.setFilename(rs.getString("p_fileName"));
				list.add(p);
			}
			return list;
		}catch(Exception ex) {
			System.out.println("getProductList() 에러"+ex);
		}finally {
			try {
				if (rs != null)
				rs.close();
				if (pstmt != null)
				pstmt.close();
				if (conn != null)
				conn.close();
				} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
				}
		}
		
		return null;
	}
	
	public void amountUp(HttpServletRequest req) {
		Connection con=null;
		PreparedStatement pstmt=null;
		HttpSession session=req.getSession();
		String loginUser=(String)session.getAttribute("sessionId");
		String pid=req.getParameter("pid");
		System.out.println("loginUser:"+loginUser+", pid:"+pid);
		
		try {
			con=DBConnection.getConnection();
			String sql="update cart set p_amount=(p_amount+1),p_total=(p_total+p_price) where m_id=? and p_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, loginUser);
			pstmt.setString(2, pid);
			pstmt.executeUpdate();
		}catch(ClassNotFoundException | SQLException e) {e.printStackTrace();}
		finally {
			try {
				if(pstmt!=null) {pstmt.close();}
				if(con!=null) {con.close();}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void amountDown(HttpServletRequest req) {
		Connection con=null;
		PreparedStatement pstmt=null;
		HttpSession session=req.getSession();
		String loginUser=(String)session.getAttribute("sessionId");
		String pid=req.getParameter("pid");
		System.out.println("loginUser:"+loginUser+", pid:"+pid);
		try {
			con=DBConnection.getConnection();
			String sql="update cart set p_amount=(p_amount-1),p_total=(p_total-p_price)where m_id=? and p_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, loginUser);
			pstmt.setString(2, pid);
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) {pstmt.close();}
				if(con!=null) {con.close();}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public Product getProduct(HttpServletRequest req) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String pid=req.getParameter("pid");
		
		String sql;
		sql="select * from product where p_id=?";
		
		Product p=new Product();
		try {
			conn=DBConnection.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				p.setProductId(rs.getString("p_id"));
				p.setPname(rs.getString("p_name"));
				p.setUnitPrice(rs.getInt("p_unitPrice"));
				p.setDescription(rs.getString("p_description"));
				p.setCategory(rs.getString("p_category"));
				p.setManufacturer(rs.getString("p_manufacturer"));
				p.setUnitsInStock(rs.getInt("p_unitsInStock"));
				p.setCondition(rs.getString("p_condition"));				
				p.setFilename(rs.getString("p_fileName"));
				System.out.println("getProduct.condition : " +rs.getString("p_id"));
				System.out.println("getProduct.condition : " +rs.getString("p_condition"));
				System.out.println("getProduct.filename : " +rs.getString("p_fileName"));
			}
			return p;
		}catch(Exception ex) {
			System.out.println("getProductList() 에러"+ex);
		}finally {
			try {
				if (rs != null)
				rs.close();
				if (pstmt != null)
				pstmt.close();
				if (conn != null)
				conn.close();
				} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
				}
		}
		
		return null;
	}

	public void addProduct(HttpServletRequest req) {
//		String filename = "";
		String realFolder = "D:\\jsp\\1Pet\\WebContent\\resources\\images";
		int maxSize = 5*1024*1024;
		String encType = "UTF-8";
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			MultipartRequest multi=new MultipartRequest(req,realFolder,maxSize,encType,new DefaultFileRenamePolicy());		
			String pId=multi.getParameter("productId");
			String pName=multi.getParameter("name");
			String unitPrice=multi.getParameter("unitPrice");
			String description=multi.getParameter("description");
			String category=multi.getParameter("category");
			String manufacturer=multi.getParameter("manufacturer");
			String unitsInStock=multi.getParameter("unitsInStock");
			String condition=multi.getParameter("condition");
			
			Integer price;
			if(unitPrice.isEmpty())
					price=0;
			else
					price=Integer.valueOf(unitPrice);
			long stock;
			if(unitsInStock.isEmpty())
				stock=0;
			else
				stock=Long.valueOf(unitsInStock);
			
//		String filename=multi.getParameter("productImage");
			
			Enumeration files=multi.getFileNames();
			String fname=(String)files.nextElement();
			String fileName=multi.getFilesystemName(fname);
			
			String sql="insert into product values(?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,pId);
			pstmt.setString(2,pName);
			pstmt.setInt(3,price);
			pstmt.setString(4,description);
			pstmt.setString(5,category);
			pstmt.setString(6,manufacturer);
			pstmt.setLong(7,stock);
			pstmt.setString(8,condition);
			pstmt.setString(9,fileName);
			pstmt.executeUpdate();
		} catch (NumberFormatException | IOException | SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
	}

	@SuppressWarnings("null")
	public void modifyProduct(HttpServletRequest req) {
		String filename="";
		String realFolder="D:\\jsp\\1Pet\\WebContent\\resources\\images";
		String encType="utf-8";
		int maxSize=5*1024*1024;
		Connection con=null;		
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
					
			MultipartRequest multi=new MultipartRequest(req,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
			String productId=multi.getParameter("productId");
			String name=multi.getParameter("name");
			String unitPrice=multi.getParameter("unitPrice");
			String description=multi.getParameter("description");
			String manufacturer=multi.getParameter("manufacturer");
			String category=multi.getParameter("category");
			String unitsInStock=multi.getParameter("unitsInStock");
			String condition=multi.getParameter("condition");

			Integer price;
			if(unitPrice.isEmpty()){
				price=0;
			}else{
				price=Integer.valueOf(unitPrice);
			}
			long stock;
			if(unitsInStock.isEmpty()){
				stock=0;
			}else{
				stock=Long.valueOf(unitsInStock);
			}
			
			Enumeration files=multi.getFileNames();
			String fname=(String)files.nextElement();
			String fileName=multi.getFilesystemName(fname);
			
			String sql="select * from product where p_id = ?";
			
			con = DBConnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,productId);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				System.out.println("pid : " + rs.getString("p_id"));
				System.out.println("pname : " + rs.getString("p_name"));
				System.out.println("price : " + rs.getString("p_unitPrice"));
				System.out.println("filename : " + rs.getString("p_fileName"));
				
				
				if(fileName!=null){
					sql="UPDATE product SET p_name=?, p_unitPrice=?,"+
							"p_description=?,p_manufacturer=?,p_category=?,p_unitsInStock=?,p_condition=? p_fileName=? WHERE p_id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,name);
					pstmt.setInt(2,price);
					pstmt.setString(3,description);
					pstmt.setString(4,manufacturer);
					pstmt.setString(5,category);
					pstmt.setLong(6,stock);
					pstmt.setString(7,condition);
					pstmt.setString(8,fileName);
					pstmt.setString(9,productId);
					pstmt.executeUpdate();
				}else{
					sql="UPDATE product SET p_name=?, p_unitPrice=?,p_description=?,p_manufacturer=?,p_category=?, p_unitsInStock=?,p_condition=? WHERE p_id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,name);
					pstmt.setInt(2,price);
					pstmt.setString(3,description);
					pstmt.setString(4,manufacturer);
					pstmt.setString(5,category);
					pstmt.setLong(6,stock);
					pstmt.setString(7,condition);
					pstmt.setString(8,productId);
					pstmt.executeUpdate();
				}
					//pstmt.executeUpdate();//중복되는거 한번만 선언해 주면 된다.
			
			}
		} catch (NumberFormatException | IOException | SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	

}
