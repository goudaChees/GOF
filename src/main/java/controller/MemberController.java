package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.MemberDAO;
import dto.MemberDTO;
import dto.MyReplyDTO;
import dto.MyWritingDTO;
import utils.EncryptUtils;


@WebServlet("*.member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
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
				String jointype="일반";
				dao.insert(new MemberDTO(0,id,pw,name,phone,email,nickname,null),jointype);
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
				dao.deleteAllContents(id);
				dao.deleteAllReplys(id);
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
			
			}else if(uri.equals("/myWriting.member")) {	// 내 글 보기 클릭시
				String nickname = (String) request.getSession().getAttribute("loginNN");
				int boardNum = Integer.parseInt(request.getParameter("board"));
				int page=Integer.parseInt(request.getParameter("page"));
				String pageList = dao.PageList(nickname, boardNum, page);
				String link = dao.getLink(boardNum);
				List<MyWritingDTO> list = dao.SelectPage(nickname, boardNum, page);
				request.setAttribute("list", list);
				request.setAttribute("pageList", pageList);
				request.setAttribute("link",link);
				request.getRequestDispatcher("/member/myWriting.jsp").forward(request, response);
			
			}else if(uri.equals("/myReply.member")) {	// 내 댓글 보기 클릭시
				String nickname = (String) request.getSession().getAttribute("loginNN");
				int boardNum = Integer.parseInt(request.getParameter("board"));
				int page=Integer.parseInt(request.getParameter("page"));
				String pageList = dao.reply_PageList(nickname, boardNum, page);
				List<MyReplyDTO> replyList = dao.reply_SelectPage(nickname, boardNum, page);
				String link = dao.getLink(boardNum);
				request.setAttribute("replyList", replyList);
				request.setAttribute("pageList", pageList);
				request.setAttribute("link",link);
				request.getRequestDispatcher("/member/myReply.jsp").forward(request, response);
			
			} else if (uri.equals("/kakaoCheck.member")) { // 카카오 가입 회원인지 먼저 확인
				String id = request.getParameter("id");
				String email = request.getParameter("email");
				String nickname = request.getParameter("nickname");
				Boolean isIdExist=dao.isIdExist(id);
				
				if(isIdExist == true) { // 회원인 경우 카카로 로그인 진행
					request.setAttribute("id", id);
					request.getRequestDispatcher("/kakaoLogin.member").forward(request, response);
				} else { // 비회원인경우 추가 정보 수집
					request.setAttribute("id", id);
					request.setAttribute("email", email);
					request.setAttribute("nickname", nickname);
					request.getRequestDispatcher("/kakaoJoin.member").forward(request, response);
				}
			
			} else if (uri.equals("/kakaoLogin.member")) { // 카카오 로그인
				String id = request.getParameter("id");
				String pw = eUtil.SHA512(id);
				
				Boolean isLoginOk=dao.IsloginOk(id,pw); // 아이디, 비번 검사
				prw.append(isLoginOk.toString());
				if(isLoginOk) {
					HttpSession session = request.getSession();
					session.setAttribute("loginID", id); // 로그인
					String nickname = dao.getNickname(id);
					session.setAttribute("loginNN", nickname);
				}
				response.sendRedirect("/index.jsp");
			
			} else if (uri.equals("/kakaoJoin.member")) {
				String id = request.getParameter("id");
				String pw = eUtil.SHA512(id);
				String email = request.getParameter("email");
				String nickname = request.getParameter("nickname");
				String jointype = "카카오";
				dao.insert(new MemberDTO(0,id,pw,nickname,null,email,nickname,null), jointype);
				
				request.setAttribute("id", id);
				request.getRequestDispatcher("/kakaoLogin.member").forward(request, response);
			} else if (uri.equals("/findid.member")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String id = "";
				boolean isfindid = dao.isgetID(name, email);
				String jointype = dao.howJoin(name, email);
				if(isfindid) {
					if(jointype.equals("카카오")) {
						prw.append(g.toJson(jointype+"로 가입한 회원입니다."));
					} else if(jointype.equals("일반")){	
						id = dao.getID(name, email);
						prw.append(g.toJson(id));
					}
				} else {
					prw.append("false");
				}
				
			} else if (uri.equals("/findpw.member")) {
				String id = request.getParameter("id");
				String email = request.getParameter("email");
				String pw = eUtil.SHA512(request.getParameter("newpw"));
				int isok = dao.chpw(pw,id,email);
				prw.append(g.toJson(isok));
				
			} else if (uri.equals("/idisok.member")) {
				String id = request.getParameter("id");
				boolean isok = dao.isidok(id);
				prw.append(g.toJson(isok));
				
			} else if (uri.equals("/emailok.member")) {
				String email = request.getParameter("email");
				boolean isok = dao.emailidok(email);
				prw.append(g.toJson(isok));
				
			} else if (uri.equals("/idandmailok.member")) {
				String id = request.getParameter("id");
				String email = request.getParameter("email");
				boolean isok = dao.isallok(id,email);
				prw.append(g.toJson(isok));
				
			} else if(uri.equals("/joinCheck.member")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String jointype = dao.howJoin(name, email);
				prw.append(g.toJson(jointype));
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
