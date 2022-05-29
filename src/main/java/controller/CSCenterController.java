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
				
				String useremail = "";
				
				HttpSession session = request.getSession();
				if ((String)session.getAttribute("loginID") == null) {
					useremail = request.getParameter("emailAddr");
					SendMail sm = new SendMail(useremail, emailTitle, emailContents);
					
					response.sendRedirect("/csmain.cscenter");
					
				}else {
					String id = (String)session.getAttribute("loginID");
					useremail = mdao.searchEmail(id);
					SendMail sm = new SendMail(id, useremail, emailTitle, emailContents);
					
					response.sendRedirect("/csmain.cscenter");
				}			

			}else if (uri.equals("/csmap.cscenter")) {
				response.sendRedirect("/cscenter/csmap.jsp");
			}else if (uri.equals("/csemail.cscenter")) {
				response.sendRedirect("/cscenter/csemail.jsp");
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.html");
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
