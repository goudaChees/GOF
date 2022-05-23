package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board1DAO;
import dao.Board1_ReplyDAO;
import dto.Board1_ReplyDTO;


@WebServlet("*.brd1_reply")
public class Board1_ReplyController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		Board1_ReplyDAO rdao = new Board1_ReplyDAO();
		Board1DAO dao = new Board1DAO();

		try {
			if(uri.equals("/write.brd1_reply")) {
				String writer = request.getParameter("nickname");
				String contents = request.getParameter("contents");
				String agree = request.getParameter("agree");
				int parent_Seq = Integer.parseInt(request.getParameter("parent_seq"));
				System.out.println(agree);
				//댓글 테이블 저장
				rdao.insert(new Board1_ReplyDTO(0,writer,contents,null,0,agree,parent_Seq));
				
				//찬반여부 Board1 테이블에 저장
				dao.addAgree(agree);		
				response.sendRedirect("/detail.brd1?seq="+parent_Seq);
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
