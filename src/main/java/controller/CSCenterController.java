package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import utils.SendMail;


@WebServlet("*.cscenter")
public class CSCenterController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		MemberDAO mdao = MemberDAO.getInstance();
		try {
			if(uri.equals("/csmain.cscenter"))  {
				response.sendRedirect("/cscenter/csmain.jsp");
			}else if (uri.equals("/sendmail.cscenter")) {
				
				String emailTitle = request.getParameter("emailTitle");
				String emailContents = request.getParameter("emailContents");
				
				HttpSession session = request.getSession();
				String id = (String)session.getAttribute("loginID");
				
				String useremail = mdao.searchEmail(id);
				
				
				System.out.println(emailTitle +"   "+emailContents);
				
				SendMail sm = new SendMail(id, useremail, emailTitle, emailContents);
				
				response.sendRedirect("/csmain.cscenter");
			}
			
			
		}catch (Exception e) {
			
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
