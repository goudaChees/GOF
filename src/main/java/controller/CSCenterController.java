package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dao.NoticeDAO;
import dto.Board1DTO;
import dto.NoticeDTO;
import utils.SendMail;


@WebServlet("*.cscenter")
public class CSCenterController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String uri = request.getRequestURI();
		MemberDAO mdao = MemberDAO.getInstance();
		NoticeDAO ndao = NoticeDAO.getInstance();
		
		try {
			if(uri.equals("/csmain.cscenter"))  {
				response.sendRedirect("/cscenter/csmain.jsp");
			}else if (uri.equals("/sendmail.cscenter")) {
				
				String emailTitle = request.getParameter("emailTitle");
				String emailContents = request.getParameter("emailContents");
				
				String useremail = "";
				
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
			
			// -- 공지사항 페이지
			} else if (uri.equals("/csnotice.cscenter")) {
				int cpage = 1;
				if (request.getParameter("cpage") != null) {
					cpage = Integer.parseInt(request.getParameter("cpage"));
				}
				ArrayList<NoticeDTO> dto = ndao.selectByPage(cpage);
				// 글 리스트
				String pageNavi = ndao.navi(cpage);
				
				session.setAttribute("cpage", cpage);
				request.setAttribute("navi", pageNavi);
				List<NoticeDTO> list = ndao.selectAll();
				request.setAttribute("list", list);
				request.getRequestDispatcher("/cscenter/csnotice.jsp").forward(request, response);
			
			// 공지사항 글보기
			} else if (uri.equals("/detailNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String loginID = (String) request.getSession().getAttribute("loginID");
				
				// view_Count 올리기
				String referer = request.getHeader("referer");
				if(referer.contains("/csnotice.cscenter")) {
					ndao.addViewCount(seq);
				};
				
				// 페이지 내용 가져오기
				NoticeDTO dto = ndao.SelectPage(seq);
				request.setAttribute("dto", dto);
				request.setAttribute("loginID", loginID);
				request.getRequestDispatcher("/cscenter/detailNotice.jsp").forward(request, response);
			
				// 공지사항 글쓰기
			} else if (uri.equals("/writeNotice.cscenter")) {
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				String loginID = (String) request.getSession().getAttribute("loginID");

				String nickname = ndao.findNicknameById(loginID);
				ndao.insert(new NoticeDTO(0, nickname, title, contents, null, 0, loginID));

				response.sendRedirect("/csnotice.cscenter");
			
				// 공지사항 글 삭제
			} else if (uri.equals("/deleteNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq")); 
				int dto = ndao.delNotice(seq);
				response.sendRedirect("/csnotice.cscenter?cpage=1");
				
				// 공지사항 글 수정
			} else if (uri.equals("/udtNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq"));				
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");				
				ndao.udtNotice(seq, title, contents);
				response.sendRedirect("/detailNotice.cscenter?seq="+seq);
				
				// 공지사항 글 검색
			} else if (uri.equals("/searchNotice.cscenter")) {
				
				int cpage =1; // cpage는 1로 설정
				int searchCategory = Integer.parseInt(request.getParameter("searchCategory"));//검색 카테고리
				String searchTarget = request.getParameter("searchTarget");//검색어
				List<NoticeDTO> list = ndao.searchNotice(searchTarget, searchCategory, cpage);//리스트 출력
				request.setAttribute("list", list);//리스트 담기
				request.setAttribute("searchCategory", searchCategory);//카테고리 담기
				request.setAttribute("searchTarget", searchTarget);//리스트 request 넣기

				String navi = ndao.getNavi(cpage,searchCategory,searchTarget);

				request.setAttribute("navi", navi);//네비 넣기
				request.getRequestDispatcher("/cscenter/csnotice.jsp?&cpage=1").forward(request, response);
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
