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

import dao.MemberDAO;
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
				
			}else if(uri.equals("/adminPwCheck.admin")) {
				
				String adminPw = util.SHA512(request.getParameter("adminPw"));
				System.out.println(adminPw);
				Boolean isAdminOk = mdao.isAdminOk(adminPw);
				System.out.println(isAdminOk);
				prw.append(g.toJson(isAdminOk));
				
			}else if(uri.equals("/banMember.admin")) {
				
				String banId = request.getParameter("banId");				
				
				int result = mdao.deleteById(banId);
				System.out.println(result);
				prw.append(g.toJson(result));
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
