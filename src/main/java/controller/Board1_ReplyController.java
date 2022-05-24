package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Board1DAO;
import dao.Board1_ReplyDAO;
import dto.Board1_ReplyDTO;


@WebServlet("*.brd1_reply")
public class Board1_ReplyController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		Board1_ReplyDAO rdao = new Board1_ReplyDAO();
		Board1DAO dao = new Board1DAO();

		try {
			if(uri.equals("/write.brd1_reply")) {
				String writer = request.getParameter("nickname");
				String contents = request.getParameter("contents");
				String agree = request.getParameter("agree");
				int parent_Seq = Integer.parseInt(request.getParameter("parent_seq"));
				//1. 댓글 테이블 저장
				rdao.insert(new Board1_ReplyDTO(0,writer,contents,null,0,agree,parent_Seq));
				//2. 찬반여부 Board1 테이블에 저장
				dao.addAgree(agree,parent_Seq);		
				//3. 댓글 수 추가
				dao.addReplyCount(parent_Seq);
				System.out.println(parent_Seq);
				response.sendRedirect("/detail.brd1?seq="+parent_Seq);
			
			}else if(uri.equals("/modify.brd1_reply")) {//댓글 수정
				//1. 댓글 내용 수정
				int seq = Integer.parseInt(request.getParameter("replySeqToUpdate"));//댓글 seq
				String agree = request.getParameter("agree_re");//승인/불가 여부
				String contents = request.getParameter("reply_contents");//수정된 댓글 내용
				int parent_Seq = Integer.parseInt(request.getParameter("parent_seq2"));
				
				//이전의 승인, 불가 여부와 비교하기 위해 seq에 따른 바뀌기 전 agree 뽑기
				String preAgree = rdao.getAgreeByseq(seq); 
				int result = rdao.modifyReply(seq,agree,contents);
				
				//2.Board1 테이블의 찬반 내용 바꾸기
				
				if(!preAgree.equals(agree)) {//이전 agree와 수정 agree가 같지 않을 경우만 board1의 agree_count값을 조정해주면 된다.
					dao.modifyAgree(agree,parent_Seq);
				}
				
				response.sendRedirect("/detail.brd1?seq="+parent_Seq);
				
			}else if(uri.equals("/delete.brd1_reply")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				int parent_Seq = Integer.parseInt(request.getParameter("board_Seq"));
				String agree = rdao.getAgreeByseq(seq); //agree값 받아오기
				
				//1. seq에 따른 댓글 테이블에서 댓글 데이터 삭제
				rdao.deleteReplyBySeq(seq);
				
				//2. board1 테이블에서 agree/disagree_count 감소		
				dao.subtractAgreeCount(parent_Seq,agree);
				
				//3. board1 테이블에서 reply_count 감소
				dao.subtractReplyCount(parent_Seq);
				
				response.sendRedirect("/detail.brd1?seq="+parent_Seq);
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
