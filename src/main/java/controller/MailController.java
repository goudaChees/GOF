package controller;
import java.io.IOException;

import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MailDAO;

/**
 * Servlet implementation class MailController
 */
@WebServlet("*.mail")
public class MailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MailController() {
        super();
       
    }
   
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		HttpSession sessions = request.getSession();
		MailDAO dao = new MailDAO();
		System.out.println(uri);
		try {
		if(uri.equals("/send.mail")) {
			
			String receiver = request.getParameter("joinmail"); // 메일 받을 주소
			String title = "회원가입 인증 메일입니다.";
			String content = "<h2>안녕하세요. 땡그랑 관리자입니다.</h2>"
					+ "회원가입 인증 번호는 다음과 같습니다."
					+ "";
			Message message = new MimeMessage(dao.getSession());
			
			message.setFrom(new InternetAddress("sendMail@gmail.com", "관리자", "utf-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html; charset=utf-8");

			Transport.send(message);
			
	  }
	} catch (Exception e) {
			e.printStackTrace();
	}

	 

	  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
