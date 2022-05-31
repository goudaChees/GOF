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
				
			} else if (uri.equals("/detailNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String loginID = (String) request.getSession().getAttribute("loginID");
				NoticeDTO dto = ndao.SelectPage(seq);
				request.setAttribute("dto", dto);
				request.setAttribute("loginID", loginID);
				request.getRequestDispatcher("/cscenter/detailNotice.jsp").forward(request, response);
			
			} else if (uri.equals("/writeNotice.cscenter")) {
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				String nickname = (String) session.getAttribute("loginNN");
				System.out.println(nickname);
				System.out.println(title);
				System.out.println(contents);
				ndao.insert(new NoticeDTO(0, nickname, title, contents, null, 0));
				response.sendRedirect("/csnotice.cscenter");
			
				// 공지사항 글 삭제
			} else if (uri.equals("/delNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq")); 
				int dto = ndao.delNotice(seq);
				response.sendRedirect("/csnotice.cscenter");
				
				// 공지사항 글 수정
			} else if (uri.equals("/udtNotice.cscenter")) {
				int seq = Integer.parseInt(request.getParameter("seq"));				
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");				
				ndao.udtNotice(seq, title, contents);
				response.sendRedirect("/opencontent.board?seq="+seq);
				
				// 공지사항 글 검색
			} else if (uri.equals("/searchNotice.notice")) {
				String searchTarget = request.getParameter("searchTarget"); 
				int cpage =1; //cpage는 1로 설정
				
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
