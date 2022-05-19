package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dto.MemberDTO;


@WebServlet("*.admin")
public class AdminController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");

		response.setCharacterEncoding("utf-8");

		request.setCharacterEncoding("utf-8");
		MemberDAO mdao = MemberDAO.getInstance();
		
		String uri = request.getRequestURI();
		try {
			if(uri.equals("/adminmain.admin")) {
				int cpage = 1;
				if (request.getParameter("cpage") != null) {
					cpage =  Integer.parseInt(request.getParameter("cpage"));
				}
				List<MemberDTO> list = mdao.selectByPage(cpage);
				
				String pageNavi = mdao.getPageNavi(cpage);
				
				request.setAttribute("list", list);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("/admin/adminmain.jsp").forward(request, response);
					
			}else if(uri.equals("/detailViewMember.admin")) {
				
				String id = request.getParameter("id");
				MemberDTO mdto = mdao.selectById(id);
				request.setAttribute("mdto", mdto);
				request.getRequestDispatcher("/admin/detailViewMember.jsp").forward(request, response);
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
