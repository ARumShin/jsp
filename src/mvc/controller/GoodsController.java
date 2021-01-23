package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Product;
import mvc.database.DBConnection;
import mvc.model.GoodsDAO;


public class GoodsController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestURI=req.getRequestURI();
		String contextPath=req.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		resp.setContentType("text/html; charset=utf-8");
		req.setCharacterEncoding("utf-8");
		if(command.equals("/ProductList.goods")) {
			productList(req);
			RequestDispatcher rd=req.getRequestDispatcher("/product/products.jsp");
			rd.forward(req, resp);
		}
		else if(command.equals("/Product.goods")) {
			getProduct(req);
			RequestDispatcher rd=req.getRequestDispatcher("/product/product.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/ProductAdd.goods")) {
			RequestDispatcher rd=req.getRequestDispatcher("/product/addProduct.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/ProductAddAction.goods")) {
			requestAddProduct(req);
			resp.sendRedirect("/ProductList.goods");
		}else if(command.equals("/ProductModify.goods")) {
			getProduct(req);
			RequestDispatcher rd=req.getRequestDispatcher("/product/updateProduct.jsp");			
			rd.forward(req, resp);
		}
		else if(command.equals("/ProductModifyAction.goods")) {
			requestModifyProduct(req);
			resp.sendRedirect(req.getContextPath()+"/ProductList.goods");
		}
		
		
		else if(command.equals("/CartAmountUp.goods")) {			
			cartAmountUp(req);
			resp.sendRedirect(req.getContextPath() + "/CartViewAction.goods");
		}else if(command.equals("/CartAmountDown.goods")) {
			cartAmountDown(req);
			resp.sendRedirect(req.getContextPath() + "/CartViewAction.goods");
		}
	}

	
	

	private void getProduct(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		Product product=new Product();
		product=dao.getProduct(req);
		req.setAttribute("product", product);
	}

	private void productList(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		List<Product> products=new ArrayList<Product>();
		products=dao.getProductList();
		
		req.setAttribute("productList", products);
		
	}
	private void cartAmountUp(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		dao.amountUp(req);
		
	}
	private void cartAmountDown(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		dao.amountDown(req);
	}
	private void requestAddProduct(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		dao.addProduct(req);
	}
	private void requestModifyProduct(HttpServletRequest req) {
		GoodsDAO dao=GoodsDAO.getInstance();
		dao.modifyProduct(req);
	}


	
	
	
}
