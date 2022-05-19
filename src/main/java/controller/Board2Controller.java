package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.Board2DAO;
import dao.Board2_replyDAO;
import dto.Board2DTO;
import dto.Board2_replyDTO;

@WebServlet("*.brd2")
public class Board2Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Gson g = new Gson();
	Board2DAO dao = new Board2DAO();
	Board2_replyDAO rdao = new Board2_replyDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();

		try {
			if (uri.equals("/list.brd2")) {
				int cpage = 1;
				if (request.getParameter("cpage") != null) {
					cpage = Integer.parseInt(request.getParameter("cpage"));
				}
				ArrayList<Board2DTO> dto = dao.selectByPage(cpage);
				// 글 리스트
				String pageNavi = dao.navi(cpage);

				session.setAttribute("cpage", cpage);
				request.setAttribute("navi", pageNavi);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/board2/board2_List.jsp").forward(request, response);

			} else if (uri.equals("/write.brd2")) {
				response.sendRedirect("/board2/board2_Write.jsp");
			} else if (uri.equals("/board2/write2.brd2")) {
				String nickname = (String) session.getAttribute("loginNN");
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				String item = request.getParameter("item");
				dao.insert(new Board2DTO(0, nickname, title, contents, item, "0", 0));
				response.sendRedirect("/list.brd2?cpage=1");
			} else if (uri.equals("/modi.brd2")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				request.setAttribute("seq", seq);
				request.getRequestDispatcher("/board2/board2_Write.jsp").forward(request, response);
			} else if(uri.equals("/modi2.brd2")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
//				String item = request.getParameter("item");
				dao.update(title, contents, seq);
				response.sendRedirect("/list.brd2?cpage=1");
			}
			else if (uri.equals("/read.brd2")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String loginNN = (String) session.getAttribute("loginNN");
				Board2DTO dto = dao.contents(seq);
				request.setAttribute("dto", dto);
				// 글보기
				dao.count(seq, dto.getView_count());
				// 조회수 증가
				ArrayList<Board2_replyDTO> rdto = rdao.list(seq);
				request.setAttribute("rdto", rdto);
				// 댓글보기
				request.setAttribute("loginNN", loginNN);
				
				boolean cck = rdao.ischoice();
				// 선택체크 선택되어 있다면 true
				boolean wck = rdao.iswrite(rdto);
				// 작성여부 체크 작성한적이 있다면 true
				request.setAttribute("cck", cck);
				request.setAttribute("wck", wck);
				request.getRequestDispatcher("/board2/board2_DetailView.jsp").forward(request, response);
			} else if (uri.equals("/del.brd2")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.del(seq);
				response.sendRedirect("/list.brd2?cpage=1");				
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
