package mvc.controller;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5;

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
		
		if(command.equals("/BoardListAction.do")) {
			requestBoardList(req);
//			System.out.println();
			RequestDispatcher rd=req.getRequestDispatcher("./board/list.jsp");
			rd.forward(req, resp);
		}else if(command.contentEquals("/BoardWriteForm.do")) {
			requestLoginName(req);
			RequestDispatcher rd=req.getRequestDispatcher("./board/writeForm.jsp");
					rd.forward(req,resp);
					
		}else if(command.contentEquals("/BoardWriteAction.do")) {
			requestBoardWrite(req);
//			RequestDispatcher rd=req.getRequestDispatcher("/BoardListAction.do");
//			rd.forward(req, resp);
//			resp.sendRedirect("./BoardListAction.do");
			resp.sendRedirect(req.getContextPath() + "/BoardListAction.do");
		}else if (command.equals("/BoardViewAction.do")) {//선택된 글 상세 페이지 가져오기
			requestBoardView(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardView.do");
			rd.forward(req, resp);
		} else if (command.equals("/BoardView.do")) { //글 상세 페이지 출력하기
			RequestDispatcher rd = req.getRequestDispatcher("./board/view.jsp");
			rd.forward(req, resp);
		} else if (command.equals("/BoardUpdateAction.do")) { //선택된 글의 조회수 증가하기
			requestBoardUpdate(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardListAction.do");
			rd.forward(req, resp);
		}else if (command.equals("/BoardDeleteAction.do")) { //선택된 글 삭제하기
			requestBoardDelete(req);
			RequestDispatcher rd = req.getRequestDispatcher("/BoardListAction.do");
			rd.forward(req, resp);
		}
	}
		
	

	
	//등록된 글 목록 가져오기
	public void requestBoardList(HttpServletRequest request){
	BoardDAO dao = BoardDAO.getInstance();
	List<BoardDTO> boardlist = new ArrayList<BoardDTO>();
	int pageNum=1;
	int limit=LISTCOUNT;
	if(request.getParameter("pageNum")!=null)
	pageNum=Integer.parseInt(request.getParameter("pageNum"));
	String items = request.getParameter("items");
	String text = request.getParameter("text");
	int total_record=dao.getListCount(items, text);
	boardlist = dao.getBoardList(pageNum,limit, items, text);
	int total_page;
	if (total_record % limit == 0){
	total_page =total_record/limit;
	Math.floor(total_page);
	}else{
	total_page =total_record/limit;
	Math.floor(total_page);
	total_page = total_page + 1;
	}
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("total_page", total_page);
	request.setAttribute("total_record",total_record);
	request.setAttribute("boardlist", boardlist);
	}
	
	//인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request){
	String id = request.getParameter("id");
	BoardDAO dao = BoardDAO.getInstance();
	String name = dao.getLoginNameById(id);
	request.setAttribute("name", name);
	}
	
	// 새로운 글 등록하기
	public void requestBoardWrite(HttpServletRequest request){
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO board = new BoardDTO();
	board.setId(request.getParameter("id"));
	board.setName(request.getParameter("name"));
	board.setSubject(request.getParameter("subject"));
	board.setContent(request.getParameter("content"));
	board.setAuthority(Integer.parseInt(request.getParameter("authority")));
	java.text.SimpleDateFormat formatter = new
	java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
	String regdate = formatter.format(new java.util.Date());
	board.setHit(0);
	board.setRegdate(regdate);
	board.setIp(request.getRemoteAddr());
	dao.insertBoard(board);
	}
	
	//선택된 글 상세 페이지 가져오기
	public void requestBoardView(HttpServletRequest request){
	BoardDAO dao = BoardDAO.getInstance();
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	BoardDTO board = new BoardDTO();
	board = dao.getBoardByNum(num, pageNum);
	request.setAttribute("num", num);
	request.setAttribute("page", pageNum);
	request.setAttribute("board", board);
	}
	//선택된 글 내용 수정하기
	public void requestBoardUpdate(HttpServletRequest request){
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO board = new BoardDTO();
	board.setNum(num);
	board.setName(request.getParameter("name"));
	board.setSubject(request.getParameter("subject"));
	board.setContent(request.getParameter("content"));
	java.text.SimpleDateFormat formatter = new
	java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
	String regdate = formatter.format(new java.util.Date());
	board.setHit(0);
	board.setRegdate(regdate);
	board.setIp(request.getRemoteAddr());
	dao.updateBoard(board);
	}
	//선택된 글 삭제하기
	public void requestBoardDelete(HttpServletRequest request){
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	BoardDAO dao = BoardDAO.getInstance();
	dao.deleteBoard(num);
	}
	
}
