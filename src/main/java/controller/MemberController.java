package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.MemberDAO;
import dto.MemberDTO;
import utils.EncryptUtils;


@WebServlet("*.member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf8");
		
		String uri = request.getRequestURI();
		MemberDAO dao = MemberDAO.getInstance();
		try {
			if(uri.equals("/joinform.member")) {
				response.sendRedirect("/member/joinform.jsp");
				
			}else if(uri.equals("/member/join.member")) {
//				EncryptUtils eUtil = new EncryptUtils();
//				
//				String id= request.getParameter("id");
//				String pw= request.getParameter("pw1");
//				pw=eUtil.SHA512(pw);
//				String name= request.getParameter("name");
//				String phone= request.getParameter("phone");
//				String email= request.getParameter("email");
//				String zipcode=request.getParameter("postcode");
//				String address1=request.getParameter("roadAddress");
//				String address2=request.getParameter("detailAddress");
//				
//				dao.insert(new MemberDTO());
//				response.sendRedirect("/index.jsp");
				
			}else if(uri.equals("/duplCheck.member")) {
//				Gson g = new Gson();
//				String id = request.getParameter("id");
//				Boolean duplExist=dao.duplCheck(id);
//				PrintWriter pw = response.getWriter();
//				pw.append(g.toJson(duplExist));
				
			}else if(uri.equals("/login.member")) {
				EncryptUtils eUtil = new EncryptUtils();
				String id = request.getParameter("id");
				String pw= request.getParameter("pw");
				pw=eUtil.SHA512(pw);
				Boolean isLoginOk=dao.loginCheck(id,pw); // 아이디, 비번 검사
				if(isLoginOk) {
					HttpSession session = request.getSession();
					session.setAttribute("loginID", id); // 로그인
				}
				response.sendRedirect("/index.jsp");
		
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.html");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
