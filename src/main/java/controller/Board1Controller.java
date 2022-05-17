package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.Board1DAO;
import dto.Board1DTO;


@WebServlet("*.brd1")
public class Board1Controller extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		request.setCharacterEncoding("utf8");
		Board1DAO dao = new Board1DAO();
		HttpSession session = request.getSession();


		try {
			if(uri.equals("/write.brd1")) {
				//글 업데이트
				String id = (String)session.getAttribute("loginID");
	
				String writer = dao.selectNicknameById(id);
	
				String title = request.getParameter("title");
				String item = request.getParameter("item");
				int item_price = Integer.parseInt(request.getParameter("item_price"));
				String contents = request.getParameter("contents");
	
				dao.insert(new Board1DTO(0,writer,title,contents,null,item,item_price,0,0,0));
	
				response.sendRedirect("/board1List.jsp");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
