package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.AdminDAO;
import dto.Board1DTO;
import dto.Board1_ReplyDTO;
import dto.Board2DTO;
import dto.Board2_replyDTO;
import dto.MemberDTO;
import utils.EncryptUtils;


@WebServlet("*.admin")
public class AdminController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		Gson g = new Gson();
		EncryptUtils util = new EncryptUtils();
		PrintWriter prw = response.getWriter();
		
		AdminDAO adao = AdminDAO.getInstance();
		
		String uri = request.getRequestURI();
		try {
			if(uri.equals("/adminmain.admin")) {
				int cpage = 1;
				if (request.getParameter("cpage") != null) {
					cpage =  Integer.parseInt(request.getParameter("cpage"));
				}
				List<MemberDTO> list = adao.selectByPage(cpage);
				
				String pageNavi = adao.getPageNavi(cpage);
				
				request.setAttribute("list", list);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("/admin/adminmain.jsp").forward(request, response);
					
			}else if(uri.equals("/detailViewMember.admin")) {
				
				String id = request.getParameter("id");
				MemberDTO mdto = adao.selectById(id);
				request.setAttribute("mdto", mdto);
				request.getRequestDispatcher("/admin/detailViewMember.jsp").forward(request, response);
				
			}else if(uri.equals("/adminPwCheck.admin")) {
				
				String adminPw = util.SHA512(request.getParameter("adminPw"));
				System.out.println(adminPw);
				Boolean isAdminOk = adao.isAdminOk(adminPw);
				System.out.println(isAdminOk);
				prw.append(g.toJson(isAdminOk));
				
			}else if(uri.equals("/banMember.admin")) {
				
				String banId = request.getParameter("banId");				
				
				int result = adao.deleteById(banId);
				System.out.println(result);
				prw.append(g.toJson(result));
			
			}else if(uri.equals("/modifyMember.admin")) {
				
				String id = request.getParameter("id");
				MemberDTO mdto = adao.selectById(id);
				request.setAttribute("mdto", mdto);
				request.getRequestDispatcher("/admin/modifyMember.jsp").forward(request, response);
				
			}else if (uri.equals("/adminUpdate.admin")) {
				String id = request.getParameter("id");
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String nickname = request.getParameter("nickname");
				adao.adminUpdate(new MemberDTO(0, id, null, name, phone, email, nickname, null));
				response.sendRedirect("/adminmain.admin");
				
			}else if (uri.equals("/adminBoardsList.admin")) {
				int board = 1;
				if (request.getParameter("board") != null ) {
					board = Integer.parseInt(request.getParameter("board"));
				}
				int page = 1;
				if (request.getParameter("page") != null) {
					page = Integer.parseInt(request.getParameter("page"));
				}
				
				if (board == 1) {
					List<Board1DTO> list1 = adao.selectBoard1Page(page);
					String pageNavi = adao.getBrdPageNavi(board, page);
					request.setAttribute("list1", list1);
					request.setAttribute("pageNavi", pageNavi);
					request.getRequestDispatcher("/admin/adminBoard1List.jsp").forward(request, response);
					
				}else if (board == 2) {
					List<Board2DTO> list2 = adao.selectBoard2Page(page);
					String pageNavi = adao.getBrdPageNavi(board, page);
					request.setAttribute("list2", list2);
					request.setAttribute("pageNavi", pageNavi);
					request.getRequestDispatcher("/admin/adminBoard2List.jsp").forward(request, response);
				}	
				
			}else if (uri.equals("/searchbrd.admin")) {
				int board = 1;
				if (request.getParameter("board") != null ) {
					board = Integer.parseInt(request.getParameter("board"));
				}
				
				int page = 1;
				if (request.getParameter("page") != null) {
					page = Integer.parseInt(request.getParameter("page"));
				}
				
				int searchCategory = Integer.parseInt(request.getParameter("searchCategory"));
				String toSearch = request.getParameter("toSearch");
				
				if (board == 1) {
					List<Board1DTO> list1 = adao.brd1search(toSearch, searchCategory, page); 
					String  searchPage = adao.getBrdSearchPageNavi(page, searchCategory, board, toSearch);
					
					request.setAttribute("list1", list1);
					request.setAttribute("searchCategory", searchCategory);
					request.setAttribute("toSearch", toSearch);
					request.setAttribute("pageNavi", searchPage);
					
					request.getRequestDispatcher("/admin/adminBoard1List.jsp?board=1&page=1").forward(request, response);
					
				}else if (board == 2) {
					List<Board2DTO> list2 = adao.brd2search(toSearch, searchCategory, page);
					String searchPage = adao.getBrdSearchPageNavi(page, searchCategory, board, toSearch);
					
					request.setAttribute("list2", list2);
					request.setAttribute("searchCategory", searchCategory);
					request.setAttribute("toSearch", toSearch);
					request.setAttribute("pageNavi", searchPage);
					
					request.getRequestDispatcher("/admin/adminBoard2List.jsp?board=2&page=1").forward(request, response);
					
				}
			}else if (uri.equals("/adminReplysList.admin")) {
				int board = 1;
				if (request.getParameter("board") != null) {
					board = Integer.parseInt(request.getParameter("board"));
				}
					
				int page = 1;
				if (request.getParameter("page") != null) {
					page = Integer.parseInt(request.getParameter("page"));
				}
				
				if (board == 1) {
					List<Board1_ReplyDTO> listR1 = adao.selectBrd1ReplyPage(page);
					String pageNavi = adao.getBrdReplyPageNavi(board, page);
					request.setAttribute("listR1", listR1);
					request.setAttribute("pageNavi", pageNavi);
					request.getRequestDispatcher("/admin/adminReply1List.jsp").forward(request, response);
					
				}else if (board == 2) {
					List<Board2_replyDTO> listR2 = adao.selectBrd2ReplyPage(page);
					String pageNavi = adao.getBrdReplyPageNavi(board, page);
					request.setAttribute("listR2", listR2);
					request.setAttribute("pageNavi", pageNavi);
					request.getRequestDispatcher("/admin/adminReply2List.jsp").forward(request, response);
						
				}
			}
				

			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
