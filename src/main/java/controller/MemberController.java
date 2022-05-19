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
		Gson g = new Gson();
		EncryptUtils eUtil = new EncryptUtils();
		PrintWriter prw = response.getWriter();
		String uri = request.getRequestURI();
		MemberDAO dao = MemberDAO.getInstance();
		try {
			if(uri.equals("/login.member")) { // 로그인 버튼 클릭시

				String id = request.getParameter("id");
				String pw= request.getParameter("pw");
				pw=eUtil.SHA512(pw);
				Boolean isLoginOk=dao.IsloginOk(id,pw); // 아이디, 비번 검사
				prw.append(isLoginOk.toString());
				if(isLoginOk) {
					HttpSession session = request.getSession();
					session.setAttribute("loginID", id); // 로그인
					String nickname = dao.getNickname(id);
					session.setAttribute("loginNN", nickname);
				}
				
			}else if(uri.equals("/joinform.member")) { // 회원가입 클릭시 회원가입폼으로 보냄
				response.sendRedirect("/member/joinform.jsp");
				
			}else if(uri.equals("/idDuplCheck.member")) { // 아이디 중복체크
				String id = request.getParameter("id");
				Boolean isIdExist=dao.isIdExist(id);
				prw.append(g.toJson(isIdExist));
				
			}else if(uri.equals("/nnDuplCheck.member")) { //닉네임 중복체크
				String nickname = request.getParameter("nickname");
				Boolean isNNExist=dao.isNNExist(nickname);
				prw.append(g.toJson(isNNExist));
				
			}else if(uri.equals("/member/join.member")) { //회원가입폼 제출시
				String id= request.getParameter("id");
				String pw= request.getParameter("pw1");
				pw=eUtil.SHA512(pw);
				String name= request.getParameter("name");
				String phone= request.getParameter("phone1")
								+request.getParameter("phone2")
								+request.getParameter("phone3");
				String email= request.getParameter("email");
				String nickname= request.getParameter("nickname");
				
				dao.insert(new MemberDTO(0,id,pw,name,phone,email,nickname,null));
				response.sendRedirect("/index.jsp");
				
			}else if(uri.equals("/logout.member")) { // 로그아웃
				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");
				
			} else if(uri.equals("/mypage.member")) {	// 마이페이지 클릭시
				String id = (String) request.getSession().getAttribute("loginID");
				MemberDTO dto = dao.selectById(id);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/member/mypage.jsp").forward(request, response);
			
			} else if(uri.equals("/memberCheck.member")) { // 회원탈퇴 비밀번호 검사 
				String id = (String) request.getSession().getAttribute("loginID");
				String pw = eUtil.SHA512(request.getParameter("pw"));
				Boolean isLoginOk=dao.IsloginOk(id,pw); // 아이디, 비번 검사				
				prw.append(g.toJson(isLoginOk));
				
			} else if(uri.equals("/realOut.member")) { // 탈퇴진행
				String id = (String) request.getSession().getAttribute("loginID");
				dao.deleteById(id);
				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");
				
			} else if(uri.equals("/update.member")) { // 내 정보 수정하기
				String phone= request.getParameter("phone");
				String email= request.getParameter("email");
				String nickname= request.getParameter("nickname");
				String id = (String) request.getSession().getAttribute("loginID");
				dao.update(new MemberDTO(0, id, null, null, phone, email, nickname, null));
				response.sendRedirect("/mypage.member");
			
			} else if(uri.equals("/pwCheck.member")) { 
				String id = (String) request.getSession().getAttribute("loginID");
				String nowpw = eUtil.SHA512(request.getParameter("nowpw"));
				Boolean isLoginOk=dao.IsloginOk(id,nowpw); // 아이디, 비번 검사				
				prw.append(g.toJson(isLoginOk));
			
			} else if (uri.equals("/pwChange.member")) {
				String id = (String) request.getSession().getAttribute("loginID");
				String pw = eUtil.SHA512(request.getParameter("newpw"));
				dao.updatePw(pw, id);
				response.sendRedirect("/mypage.member");
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
