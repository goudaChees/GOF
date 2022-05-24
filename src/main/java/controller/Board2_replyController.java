package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.Board2_replyDAO;
import dto.Board2_replyDTO;


@WebServlet("*.brd2_reply")
public class Board2_replyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Board2_replyDAO dao = new Board2_replyDAO();    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Gson gs = new Gson();
		try{
			if(uri.equals("/write.brd2_reply")) {
			String nickname = (String) session.getAttribute("loginNN");
			int pseq = Integer.parseInt(request.getParameter("pseq"));
			String contents = request.getParameter("contents");
			Long price = (long) Integer.parseInt(request.getParameter("price"));
			dao.insert(new Board2_replyDTO(0,nickname,pseq,price,contents,"0",'Y'));
			response.sendRedirect("/read.brd2?seq="+pseq);
		}else if(uri.equals("/choice.brd2_reply")) {
			int seq = Integer.parseInt(request.getParameter("rseq"));
			dao.choice(seq);

		}else if(uri.equals("/del.brd2_reply")) {
			int seq = Integer.parseInt(request.getParameter("rseq"));
			int pseq = Integer.parseInt(request.getParameter("pseq"));
			dao.del(seq,pseq);
		}else if(uri.equals("/modi.brd2_reply")) {
			int seq = Integer.parseInt(request.getParameter("rseq"));
			String contents = request.getParameter("contents");
			int price = Integer.parseInt(request.getParameter("price"));
			dao.update(price, contents, seq);
		}
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
