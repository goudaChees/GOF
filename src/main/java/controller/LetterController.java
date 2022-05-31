package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.LetterDAO;
import dto.LetterDTO;

@WebServlet("*.letter")
public class LetterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		LetterDAO ldao = LetterDAO.getInstance();
		
		try {
			if(uri.equals("/toSend.letter")) { // 쪽지보내기 화면으로 이동
				
				String id = (String) request.getSession().getAttribute("loginID");
				String nickname = ldao.getNickname(id);
				System.out.println(nickname);
				request.setAttribute("nickname", nickname);
				response.sendRedirect("/letter/letter_Write.jsp");
			
			
			}else if(uri.equals("/send.letter")) { // 쪽지보내기
				int seq = ldao.getNextSeq();
				String id = (String) request.getSession().getAttribute("loginID");
				String nickname = ldao.getNickname(id);
				String receiver = request.getParameter("receiver");
				String receiverId = ldao.getId(receiver);
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				
				ldao.insertRLetter(new LetterDTO(seq, nickname, receiver, title, contents, null,0,id,receiverId));
				ldao.insertSLetter(new LetterDTO(seq, nickname, receiver, title, contents, null,0,id,receiverId));
				
				response.sendRedirect("/letter/list.jsp");
				
			
			}else if(uri.equals("/searchNN.letter")) { // 팝업창에서 닉네임 검색
				Gson g = new Gson();
				String id = (String) request.getSession().getAttribute("loginID");
				String nickname = ldao.getNickname(id);
				String target = request.getParameter("target");
				List<String> list = ldao.searchNN(target,nickname);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(list));			
			
				
			}else if(uri.equals("/reply.letter")) { // 답장하기 클릭 시 받을 사람의 닉네임 전달
				int seq = Integer.parseInt(request.getParameter("seq"));
				String receiverid = ldao.getReceiver(seq);
				String receiver = ldao.getNickname(receiverid);
				request.setAttribute("receiver", receiver);
				response.sendRedirect("/letter/letter_Write.jsp");
			
				
			}else if(uri.equals("/list.letter")) { //메세지 목록보기
				String id = (String) request.getSession().getAttribute("loginID");
				String type=request.getParameter("type"); // r:받은 편지함 , s:보낸편지함
				int page=Integer.parseInt(request.getParameter("page")); 
				
				String pageList = "";
				List<LetterDTO> list = null;
				int newLetter = 0;
				
				if(type.equals("r")){
					pageList = ldao.rPageList(id, page);
					list = ldao.rSelectPage(id, page);
					newLetter = ldao.newLetter(id);
				}else if(type.equals("s")) {
					pageList = ldao.sPageList(id, page);
					list = ldao.sSelectPage(id, page);
				}
				
				request.setAttribute("type", type);
				request.setAttribute("list", list);
				request.setAttribute("pageList", pageList);
				request.setAttribute("newLetter", newLetter);
				request.getRequestDispatcher("/letter/list.jsp").forward(request, response);
			
				
				
			}else if(uri.equals("/read.letter")) { // 메세지 읽기
				String type=request.getParameter("type"); // r:받은 편지함 , s:보낸편지함
				int seq = Integer.parseInt(request.getParameter("seq"));
				
				LetterDTO ldto=null;
				if(type.equals("r")) {
					ldao.letterChecked(seq); // 메세지 읽음 처리
					ldto=ldao.readRBySeq(seq);
				}else if(type.equals("s")) {
					ldto=ldao.readSBySeq(seq);
				}
				
				request.setAttribute("ldto", ldto);
				request.getRequestDispatcher("/letter/readLetter.jsp").forward(request, response);
			
			
			}else if(uri.equals("/delete.letter")) { // 메세지 삭제하기
				String type=request.getParameter("type"); // r:받은 편지함 , s:보낸편지함
				int seq = Integer.parseInt(request.getParameter("seq"));
				
				ldao.deleteLetter(type,seq);				
				response.sendRedirect("/list.letter?type="+type+"&page=1");
			
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
