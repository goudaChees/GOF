package controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.MailDAO;

@WebServlet("*.mail")
public class MailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Gson g = new Gson();
   
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		MailDAO dao = new MailDAO();
		try {
		if(uri.equals("/send.mail")) {
			String random = dao.randomString(); // 난수 설정
			String receiver = request.getParameter("email"); // 메일 받을 주소
			String title = "[땡그랑]회원가입 인증 메일입니다.";
			String content = "<h2>안녕하세요. 땡그랑 관리자입니다.</h2>"
					+ "회원가입 인증 번호는 다음과 같습니다.<br>[ "
					+ random + " ]입니다.<br>";
			Message message = new MimeMessage(dao.getSession());
			
			message.setFrom(new InternetAddress("sendMail@gmail.com", "관리자", "utf-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html; charset=utf-8");

			Transport.send(message);
			
			PrintWriter pw = response.getWriter();
			pw.append(g.toJson(random));//난수 발송
		
	  }else if(uri.equals("/findpw.mail")) {
		  String random =dao.randomString(); // 난수설정
		  String receiver = request.getParameter("email"); // 메일 받을 주소
		  String title = "[땡그랑]비밀번호 찾기 인증 메일입니다.";
		  String content = "<h2>안녕하세요. 땡그랑 관리자입니다.</h2>"
					+ "비밀번호찾기 인증 번호는 다음과 같습니다.<br>[ "
					+ random +" ]입니다.<br>";
		  Message message = new MimeMessage(dao.getSession());
			
			message.setFrom(new InternetAddress("sendMail@gmail.com", "관리자", "utf-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html; charset=utf-8");

			Transport.send(message);
			
			PrintWriter pw = response.getWriter();
			pw.append(g.toJson(random));//난수 발송
	  }
	} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.html");
	}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
