package utils;

import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
	
	public SendMail() {
		
	}
	
	public SendMail(String userid, String useremail, String emailTitle, String emailContents) {
		// 호스트와 계정정보. 보내는 계정(SMTP 설정이 된 계정)
		String host = "smtp.naver.com";
		String user = "realishy@naver.com";
		String password = "london00";
				
		String to = "realishy@naver.com"; //받을 계정정보
				
		// get the session object
				
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.debug", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
				
		// Compose the message
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
					
		// 메일 제목
			message.setSubject(emailTitle);
					
		// 메일 내용
			message.setText("문의내용 : "+ emailContents +"   [[유저id :"+userid+"     유저email :"+useremail+"]]");
					
		// 메일 전송
			Transport.send(message);
			System.out.println("mail succuess");
					
		}catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
