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
import utils.EncryptUtils;


@WebServlet("*.member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf8");
		
		String uri = request.getRequestURI();
		MemberDAO dao = MemberDAO.getInstance();
		try {
			if(uri.equals("/login.member")) {
				Gson g = new Gson();
				EncryptUtils eUtil = new EncryptUtils();
				String id = request.getParameter("id");
				String pw= request.getParameter("pw");
				pw=eUtil.SHA512(pw);
				Boolean isLoginOk=dao.IsloginOk(id,pw); // 아이디, 비번 검사
				if(isLoginOk) {
					HttpSession session = request.getSession();
					session.setAttribute("loginID", id); // 로그인
				}
				PrintWriter prw = response.getWriter();
				prw.append(g.toJson(isLoginOk));
				
			}else if(uri.equals("/joinform.member")) {
				response.sendRedirect("/member/joinform.jsp");
				
			}else if(uri.equals("/idDuplCheck.member")) {
				Gson g = new Gson();
				String id = request.getParameter("id");
				Boolean isIdExist=dao.isIdExist(id);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(isIdExist));
				
			}else if(uri.equals("/nnDuplCheck.member")) {
				Gson g = new Gson();
				String nickname = request.getParameter("nickname");
				Boolean isNNExist=dao.isNNExist(nickname);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(isNNExist));
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
